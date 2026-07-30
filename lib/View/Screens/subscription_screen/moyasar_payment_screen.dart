import 'dart:async';

import 'package:Senaeya/Core/AppRoute/app_route.dart';
import 'package:Senaeya/Utils/AppColors/app_colors.dart';
import 'package:Senaeya/View/Screens/subscription_screen/model/moyasar_payment_model.dart';
import 'package:Senaeya/View/Screens/subscription_screen/repo/subscription_repo.dart';
import 'package:Senaeya/View/Widgegts/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moyasar/moyasar.dart';

class MoyasarPaymentScreen extends StatefulWidget {
  final MoyasarPaymentPreparation preparation;

  const MoyasarPaymentScreen({
    super.key,
    required this.preparation,
  });

  @override
  State<MoyasarPaymentScreen> createState() => _MoyasarPaymentScreenState();
}

class _MoyasarPaymentScreenState extends State<MoyasarPaymentScreen> {
  late final PaymentConfig _paymentConfig;
  Timer? _statusTimer;
  bool _isVerifying = false;
  bool _statusCheckInFlight = false;
  bool _terminalHandled = false;
  String? _paidPaymentId;

  bool get _isArabic => Get.locale?.languageCode == 'ar';

  @override
  void initState() {
    super.initState();
    PaymentConfig.callbackUrl = widget.preparation.callbackUrl;
    _paymentConfig = PaymentConfig(
      publishableApiKey: widget.preparation.publishableApiKey,
      amount: widget.preparation.amount,
      currency: widget.preparation.currency,
      description: widget.preparation.description,
      metadata: widget.preparation.metadata,
      givenID: widget.preparation.givenId,
      supportedNetworks: const [
        PaymentNetwork.mada,
        PaymentNetwork.visa,
        PaymentNetwork.masterCard,
      ],
      creditCard: CreditCardConfig(saveCard: false, manual: false),
    );
    _statusTimer = Timer.periodic(
      const Duration(seconds: 2),
      (_) => _checkPreparedPaymentStatus(),
    );
  }

  Future<void> _onPaymentResult(dynamic result) async {
    if (_terminalHandled) return;

    if (result is PaymentResponse) {
      if (result.status == PaymentStatus.paid) {
        _markTerminalHandled();
        _paidPaymentId = result.id;
        await _verifyPayment(result.id);
        return;
      }

      if (result.status == PaymentStatus.failed) {
        _markTerminalHandled();
        String message = 'Your subscription payment was not successful.'.tr;
        if (result.source is CardPaymentResponseSource) {
          message =
              (result.source as CardPaymentResponseSource).message ?? message;
        }
        await _showFailureDialog(message);
        return;
      }
    }

    _markTerminalHandled();
    await _showFailureDialog(_paymentErrorMessage(result));
  }

  void _markTerminalHandled() {
    _terminalHandled = true;
    _statusTimer?.cancel();
  }

  Future<void> _checkPreparedPaymentStatus() async {
    if (!mounted || _terminalHandled || _statusCheckInFlight) return;
    _statusCheckInFlight = true;

    final response = await SubscriptionRepo().getMoyasarPaymentStatus(
      paymentId: widget.preparation.givenId,
    );
    _statusCheckInFlight = false;
    if (!mounted || _terminalHandled || response.statusCode != 200) return;

    final data = response.body is Map ? response.body['data'] : null;
    final status = data is Map ? data['status']?.toString() ?? '' : '';
    if (status == 'paid') {
      await _handlePolledTerminalStatus(isPaid: true);
    } else if (status == 'failed' ||
        status == 'voided' ||
        status == 'refunded') {
      await _handlePolledTerminalStatus(isPaid: false);
    }
  }

  Future<void> _handlePolledTerminalStatus({required bool isPaid}) async {
    if (!mounted || _terminalHandled) return;
    _markTerminalHandled();

    final paymentRoute = ModalRoute.of(context);
    if (paymentRoute != null && !paymentRoute.isCurrent) {
      Navigator.of(context).pop();
      await Future<void>.delayed(const Duration(milliseconds: 200));
    }
    if (!mounted) return;

    if (isPaid) {
      _paidPaymentId = widget.preparation.givenId;
      await _verifyPayment(widget.preparation.givenId);
    } else {
      await _showFailureDialog(
        'Your subscription payment was not successful.'.tr,
      );
    }
  }

  String _paymentErrorMessage(dynamic result) {
    if (result is ApiError) return result.message;
    if (result is AuthError) return result.message;
    if (result is ValidationError) return result.message;
    if (result is PaymentCanceledError) {
      return 'Your subscription payment was cancelled.'.tr;
    }
    if (result is TimeoutError || result is NetworkError) {
      return 'An error occurred while verifying payment.'.tr;
    }
    if (result is UnspecifiedError) return result.message;
    return 'Your subscription payment was not successful.'.tr;
  }

  Future<void> _verifyPayment(String paymentId) async {
    if (_isVerifying) return;
    setState(() => _isVerifying = true);

    final response = await SubscriptionRepo().verifyMoyasarPayment(
      paymentId: paymentId,
    );

    if (!mounted) return;
    setState(() => _isVerifying = false);

    if (response.statusCode == 200) {
      final data = response.body is Map ? response.body['data'] : null;
      final subscriptionId = data is Map ? data['_id']?.toString() ?? '' : '';
      await _showSuccessDialog(subscriptionId);
      return;
    }

    await _showVerificationFailureDialog(
      response.statusText ??
          'Unable to verify payment. Please contact support.'.tr,
    );
  }

  Future<void> _showSuccessDialog(String subscriptionId) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: CustomText(text: 'Payment Successful'.tr),
        content: CustomText(
          text: 'Your subscription payment was successful.'.tr,
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: CustomText(text: 'OK'.tr),
          ),
        ],
      ),
    );

    if (!mounted) return;
    if (subscriptionId.isNotEmpty) {
      Get.offNamed(
        AppRoute.invoiceScreen,
        arguments: {'subscriptionId': subscriptionId},
      );
    } else {
      Get.back();
    }
  }

  Future<void> _showFailureDialog(String message) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: CustomText(text: 'Payment Failed'.tr),
        content: CustomText(text: message, maxLines: 4),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: CustomText(text: 'OK'.tr),
          ),
        ],
      ),
    );
    if (mounted) Get.back();
  }

  Future<void> _showVerificationFailureDialog(String message) async {
    final retry = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: CustomText(text: 'Payment Verification Failed'.tr),
        content: CustomText(text: message, maxLines: 4),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: CustomText(text: 'Cancel'.tr),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: CustomText(text: 'Try Again'.tr),
          ),
        ],
      ),
    );

    if (retry == true && _paidPaymentId != null && mounted) {
      await _verifyPayment(_paidPaymentId!);
    }
  }

  @override
  void dispose() {
    _statusTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final amount = (widget.preparation.amount / 100).toStringAsFixed(2);
    return Directionality(
      textDirection: _isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: CustomText(text: 'Complete Payment'.tr),
        ),
        body: Stack(
          children: [
            SafeArea(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'total_amount_including_tax'.tr,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      CustomText(
                        text: '$amount ${widget.preparation.currency}',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  CreditCard(
                    config: _paymentConfig,
                    locale: _isArabic
                        ? const Localization.ar()
                        : const Localization.en(),
                    onPaymentResult: _onPaymentResult,
                  ),
                ],
              ),
            ),
            if (_isVerifying)
              const ColoredBox(
                color: Color(0x99FFFFFF),
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }
}
