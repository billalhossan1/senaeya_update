import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../Service/api_client.dart';
import '../../../../Service/api_url.dart';


class CreateInvoiceRepo{
  Future<Response>createInvoice({required String clientId,required String carId,required List<Map<String,dynamic>>workList ,required List<Map<String,dynamic>>sparePartsList,required dynamic discount})async{

    try{
      Map<String,dynamic>body={
        "client":clientId,
        "car": carId,
        "worksList": workList,
        "sparePartsList":sparePartsList,
        "discount": discount,
        "discountType": "flat_amount"
      };


      Response response;
      response = await ApiClient.postData(ApiConstant.getInvoices,body: body);
      return response;

    }catch(e){
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }

  }


  Future<Response>searchSpareParts({required String code,required String workshopId})async{

    try{
      Map<String,dynamic>queryParams={
        "code":code,
        "providerWorkShopId": workshopId,
        'limit': 1,

      };

      Response response;
      response = await ApiClient.getData(ApiConstant.getSparePartsByCode,query: queryParams);
      return response;

    }catch(e){
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }

  }





}