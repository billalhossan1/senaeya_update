import 'package:Senaeya/View/Screens/subscription_screen/model/moyasar_payment_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parses a valid Moyasar payment preparation', () {
    final preparation = MoyasarPaymentPreparation.fromJson({
      'publishableApiKey': 'pk_test_example',
      'amount': 12550,
      'currency': 'SAR',
      'description': 'Senaeya subscription',
      'callbackUrl': 'https://api.senaeya.net/api/v1/moyasar/return',
      'givenId': '8424b5f5-c701-475e-8c37-9f2bcba1e592',
      'metadata': {
        'payment_attempt_id': '8424b5f5-c701-475e-8c37-9f2bcba1e592',
      },
    });

    expect(preparation.isValid, isTrue);
    expect(preparation.amount, 12550);
    expect(preparation.currency, 'SAR');
  });

  test('rejects an incomplete payment preparation', () {
    final preparation = MoyasarPaymentPreparation.fromJson({
      'amount': 0,
      'metadata': null,
    });

    expect(preparation.isValid, isFalse);
    expect(preparation.metadata, isEmpty);
  });
}
