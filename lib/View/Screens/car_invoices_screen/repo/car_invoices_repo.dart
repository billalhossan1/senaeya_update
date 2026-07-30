import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../Service/api_client.dart';
import '../../../../Service/api_url.dart';


class CarInvoicesRepo{
  Future<Response>getInvoices({required int page,required String clientId})async{

    try{

      Map<String,dynamic>query={
        'client':clientId,
        'page':page
      };


      Response response;
      response = await ApiClient.getData(ApiConstant.clientInvoicesUrl,query:query,
      );
      return response;

    }catch(e){
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }

  }

  Future<Response>getInvoicesByCar({required int page,required String carId})async{

    try{

      Map<String,dynamic>query={
        'car':carId,
        'page':page
      };


      Response response;
      response = await ApiClient.getData(ApiConstant.clientInvoicesUrl,query:query,
      );
      return response;

    }catch(e){
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }

  }



}