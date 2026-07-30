import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../Helper/shared_prefe/shared_prefe.dart';
import '../../../../Service/api_client.dart';
import '../../../../Service/api_url.dart';


class PreviousInvoicesRepo{
  Future<Response>getInvoices({String? paramKey,String? queryParam,int page=1})async{

    try{

      String providerWorkShopId = await SharePrefsHelper.getString(SharedPreferenceValue.workshopId);
      Map<String,dynamic>?query;
      if(paramKey!=null&&queryParam!=null){
     query={
          paramKey:queryParam,
          'page':page,
       'providerWorkShopId':providerWorkShopId
        };
      }




      Response response;
      response = await ApiClient.getData(
        ApiConstant.getInvoices,query:queryParam!=null?query:null,
      );
      return response;

    }catch(e){
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }

  }


  Future<Response>payInvoice({required String invoiceId,String? cardApprovalCode,required String? paymentMethod})async{


    try{
      Map<String, dynamic>? body;
      if(paymentMethod!=null&&paymentMethod.isNotEmpty){
        body={"paymentMethod":paymentMethod};
      }

      if (cardApprovalCode != null && cardApprovalCode.isNotEmpty) {
        body?["cardApprovalCode"] = cardApprovalCode;
      }
      Response response;
      response = await ApiClient.postData(
        ApiConstant.payInvoiceUrl(invoiceId),body: body
      );
      return response;

    }catch(e){
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }

  }



}