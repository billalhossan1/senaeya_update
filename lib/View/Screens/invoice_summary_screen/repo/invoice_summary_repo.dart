import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../Service/api_client.dart';
import '../../../../Service/api_url.dart';

class InvoiceSummaryRepo {
  Future<Response> getInvoiceById({required String invoiceId}) async {
    try {
      Response response;
      response = await ApiClient.getData(
        "${ApiConstant.getInvoices}/$invoiceId",
      );
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }
  }

  // Future<Response> postPaid({
  //   required String invoiceId,
  //   required String postPaidDate,
  // }) async {
  //   try {
  //     Map<String, dynamic> body = {
  //       "paymentMethod": "postpaid",
  //       "postPaymentDate": postPaidDate,
  //     };
  //     Response response;
  //     response = await ApiClient.patchData(
  //       "${ApiConstant.getInvoices}/$invoiceId",
  //       body: body,
  //     );
  //     return response;
  //   } catch (e) {
  //     return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
  //   }
  // }

  // Create a new invoice
  Future<Response> createInvoice({
    required String clientId,
    required String carId,
    required String paymentMethod,
    required String postPaymentDate,
    required String clientName,
    required bool isCashRecieved,
    required bool isReleased,
    required List<Map<String, dynamic>> worksList,
    required List<Map<String, dynamic>> sparePartsList,
    required dynamic discount,
    String discountType = "flat_amount",
    required String cardApprovalCode,
  }) async {
    try {
      // Build request body and include 'car' only when carId is non-empty
      final Map<String, dynamic> body = {
        "client": clientId,
        "paymentMethod": paymentMethod,
        "postPaymentDate": postPaymentDate,
        "isCashRecieved": isCashRecieved.toString().toLowerCase(),
        "isReleased": isReleased.toString().toLowerCase(),
        "cardApprovalCode": cardApprovalCode,
        "worksList": worksList,
        "customerInvoiceName":clientName,
        "sparePartsList": sparePartsList,
        "discount": discount,
        "discountType": discountType,
      };
      if (carId.isNotEmpty) {
        body['car'] = carId;
      }
      Response response;
      response = await ApiClient.postData(ApiConstant.getInvoices, body: body);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }
  }

  Future<Response> saveInvoice({
    required String invoiceId,
    required String paymentType,
    bool isReleased = false,
    required List<Map<String, dynamic>> sparePartList,
    required List<Map<String, dynamic>> workList,
    dynamic discount,
    required bool isCashRecieved,
    required String carId,
    required String postPaymentDate,
    required String clientId,
  }) async {
    try {
      // Build request body and include 'car' only when carId is non-empty
      final Map<String, dynamic> body = {
        "client": clientId,
        "paymentMethod": paymentType,
        "isReleased": isReleased.toString().toLowerCase(),
        "worksList": workList,
        "sparePartsList": sparePartList,
        "discountType": "flat_amount",
        "discount": discount,
        "isCashRecieved": isCashRecieved.toString().toLowerCase(),
        "postPaymentDate": postPaymentDate,
      };
      if (carId.isNotEmpty) {
        body['car'] = carId;
      }
      Response response;
      response = await ApiClient.postData(
        "${ApiConstant.getInvoices}/$invoiceId",
        body: body,
      );
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }
  }

  Future<Response> makeThePayment({
    required String invoiceId,
    required String paymentMethod,
    String? cardApprovalCode,
    bool? isCashRecieved,
    String? postPaymentDate,
    bool? isRecievedTransfer,
  }) async {
    try {
      Map<String, dynamic> body = {
        "invoice": invoiceId,
        "paymentMethod": paymentMethod,
      };

      // Add optional fields based on payment method
      if (cardApprovalCode != null && cardApprovalCode.isNotEmpty) {
        body["cardApprovalCode"] = cardApprovalCode;
      }

      if (isCashRecieved != null) {
        body["isCashRecieved"] = isCashRecieved;
      }

      if (postPaymentDate != null && postPaymentDate.isNotEmpty) {
        body["postPaymentDate"] = postPaymentDate;
      }

      if (isRecievedTransfer != null) {
        body["isRecievedTransfer"] = isRecievedTransfer;
      }

      Response response;
      response = await ApiClient.postData(
        ApiConstant.payment,
        body: body,
      );
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }
  }
}
