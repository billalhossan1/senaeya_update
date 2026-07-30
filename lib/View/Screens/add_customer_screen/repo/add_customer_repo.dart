import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../Service/api_client.dart';
import '../../../../Service/api_url.dart';


class AddCustomerRepo{


  Future<Response>getBrands({Map<String,dynamic>? query,String? url})async{

    try{

      Response response;
      response = await ApiClient.getData(
       url?? ApiConstant.carBrands,query: query
      );
      return response;

    }catch(e){
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }

  }

  Future<Response>getCustomerList({Map<String,dynamic>? queryParams})async{
    try{
      Response response;
      response = await ApiClient.getData(
        ApiConstant.getClient,
        query: queryParams
      );
      return response;
    }catch(e){
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }
  }

  Future<Response>getCustomerByNumber({required String number})async{

    try{

      Response response;
      response = await ApiClient.getData(
     ApiConstant.getClientByContactUrl(number)
      );
      return response;

    }catch(e){
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }

  }

  Future<Response>getCustomerByCarPlate({required String number})async{

    try{
      Map<String,dynamic>query={
        'plateNumberForInternational':number
      };
      Response response;
      response = await ApiClient.getData(
     ApiConstant.getClient,query: query
      );
      return response;

    }catch(e){
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }

  }

  Future<Response>getCustomerBySaudiCarPlate({required String slug})async{

    try{
      Map<String,dynamic>query={
        'slugForSaudiCarPlateNumber':slug
      };
      Response response;
      response = await ApiClient.getData(
     ApiConstant.getClient,query: query
      );
      return response;

    }catch(e){
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }

  }

  Future<Response>addCustomerForUser({String? symbol,String? name,String? contact,String? vin,String? brandId,String? modelId,String? year,String? arabicText,String? symbolId,String? englishText,String? plateNumber,List<String>? alphabetCombination,required String documentNumber,required String clientCarId,required String clientId, bool isUpdate = false})async{

    try{
      Map<String,dynamic>body={
        "clientType": "User",
        if(brandId != null) "brand": brandId,
        if(modelId != null) "model": modelId,
        if(year != null) "year": year,
        if(vin != null) "vin": vin,
        if(name != null) "name": name,
        if(contact != null) "contact": contact,
        "description": "Regular customer",
        "documentNumber": documentNumber,
      };

      // Add Saudi car plate information if symbol is provided
      if(symbol != null&&symbol.isNotEmpty) {
        body["carType"] = "Saudi";
        body["plateNumberForSaudi"] = {
          "symbol": symbol,
          if(englishText != null) "numberEnglish": englishText,
          if(arabicText != null) "numberArabic": arabicText,
          if(alphabetCombination != null) "alphabetsCombinations": alphabetCombination,
        };
      } else if(plateNumber != null&&plateNumber.isNotEmpty) {
        body["carType"] = "International";
        body["plateNumberForInternational"] = plateNumber;
      }

      if(clientCarId.isNotEmpty&&isUpdate&&clientId.isNotEmpty){
        body["clientId"]=clientId;
        body["carId"]=clientCarId;
      }



      Response response;
      if(isUpdate){
        response = await ApiClient.patchData(
          ApiConstant.updateClient,body: body
        );
      }else {
        response = await ApiClient.postData(
            ApiConstant.createClient, body: body
        );
      }
      return response;

    }catch(e){
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }

  }

  Future<Response>getWorkshopByNumber({required String number})async{

    try{

      Response response;
      response = await ApiClient.getData(
          ApiConstant.getWorkShopByContact(number)
      );
      return response;

    }catch(e){
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }

  }

  Future<Response>addWorkShop({required String number,required String name,required String documentId,required String workShopIdAsClient })async{

    try{
      Map<String,dynamic>body={
        "clientType": "WorkShop",
        "workShopNameAsClient": name,
        "contact": number,
        "documentNumber": documentId,
      };

      Response response;
      response = await ApiClient.postData(
          ApiConstant.createClient,body: body
      );
      return response;

    }catch(e){
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }

  }


  Future<Response>getCustomerByCarPlateNumberOrSlag({required String slugOrPlateNumber})async{

    try{

      Response response;
      response = await ApiClient.getData(
          ApiConstant.getClientByCar(slugOrPlateNumber),
      );
      return response;

    }catch(e){
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }

  }

  Future<Response>isTaxAvailable()async{

    try{

      Response response;
      response = await ApiClient.getData(
          ApiConstant.verifyTaxNumber,
      );
      return response;

    }catch(e){
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }

  }


  Future<Response>createCar({required String clientId,required String brandId,required String modelId,required String year,required String vin, String? plateNumberForInternational, String? symbol, String? englishText, String? arabicText, List<String>? alphabetCombination,})async{

    try{

      Map<String,dynamic>body={
        "brand": brandId,
        "model": modelId,
        "year": year,
        "client": clientId,
        "vin": vin,
        "description": "Regular customer",
      };

      // Add Saudi car plate information if symbol is provided
      if(symbol != null&&symbol.isNotEmpty) {
        body["carType"] = "Saudi";
        body["plateNumberForSaudi"] = {
          "symbol": symbol,
          if(englishText != null) "numberEnglish": englishText,
          if(arabicText != null) "numberArabic": arabicText,
          if(alphabetCombination != null) "alphabetsCombinations": alphabetCombination,
        };
      } else if(plateNumberForInternational != null&&plateNumberForInternational.isNotEmpty) {
        body["carType"] = "International";
        body["plateNumberForInternational"] = plateNumberForInternational;
      }



      Response response;
      response = await ApiClient.postData(ApiConstant.createCar,body: body);
      return response;

    }catch(e){
      return Response(statusCode: 1, statusText: "Error: ${e.toString()}");
    }

  }






}