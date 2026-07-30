import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../Service/api_client.dart';
import '../../../../Service/api_url.dart';


class CustomerCarsRepo{
  Future<Response>getCars({String? queryParam})async{

    try{

      Map<String,dynamic>query={
        'client':queryParam
      };


      Response response;
      response = await ApiClient.getData(
       ApiConstant.getClientCustomer,query:queryParam!=null?query:null,
      );
      return response;

    }catch(e){
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }

  }


  Future<Response>getCarsWithProvider({String? queryParam})async{

    try{

      Map<String,dynamic>query={
        'client':queryParam
      };


      Response response;
      response = await ApiClient.getData(
       ApiConstant.getClientCarsWithProvider,query:queryParam!=null?query:null,
      );
      return response;

    }catch(e){
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }

  }
  Future<Response>getCarsByCar({String? queryParam})async{

    try{

      Map<String,dynamic>query={
        'car':queryParam
      };


      Response response;
      response = await ApiClient.getData(
       ApiConstant.getClientCustomer,query:queryParam!=null?query:null,
      );
      return response;

    }catch(e){
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }

  }



}