import 'package:Senaeya/Helper/shared_prefe/shared_prefe.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../Service/api_client.dart';
import '../../../../Service/api_url.dart';


class GetCarsRepo{
  Future<Response>getApi({String? getUrl,String? queryParam})async{

    try{




      Response response;
      response = await ApiClient.getData(
        getUrl?? ApiConstant.getCars,
      );
      return response;

    }catch(e){
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }

  }


  Future<Response>getAuthorized()async{

    try{


      String providerWorkshopId = await SharePrefsHelper.getString(SharedPreferenceValue.workshopId);
      Response response;
      response = await ApiClient.getData(
        ApiConstant.getAuthorized(providerWorkshopId),
      );
      return response;

    }catch(e){
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }

  }



}