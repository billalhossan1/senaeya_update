import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../Service/api_client.dart';
import '../../../../Service/api_url.dart';


class NotificationRepo{
  Future<Response>getNotifications()async{

    try{



      Response response;
      response = await ApiClient.getData(ApiConstant.notification, );
      return response;

    }catch(e){
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }

  }



}