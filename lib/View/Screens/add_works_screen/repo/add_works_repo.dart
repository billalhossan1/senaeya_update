import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../Service/api_client.dart';
import '../../../../Service/api_url.dart';


class AddWorksRepo{
  Future<Response>getWorks({required String url})async{

    try{



      Response response;
      response = await ApiClient.getData(url);
      return response;

    }catch(e){
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }

  }



}