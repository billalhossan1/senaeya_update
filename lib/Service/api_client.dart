import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:mime/mime.dart';

import '../Core/AppRoute/app_route.dart';
import '../Global/Model/error_response.dart';
import '../Helper/shared_prefe/shared_prefe.dart';
import '../Utils/AppConst/app_const.dart';
import '../Utils/AppLog/app_log.dart';
import 'api_url.dart';

class ApiClient extends GetxService {
  static var client = http.Client();

  static  String noInternetMessage = "Can't connect to the internet!".tr;
  static const int timeoutInSeconds = 30;

  /// In-memory bearer token to avoid reading prefs on every request and race after login
  static String bearerToken = "";

  /// When set, automatic navigation-to-login is suppressed until this time.
  static DateTime? _suppressAutoLogoutUntil;

  /// Suppress automatic logout for [duration] from now (used right after login).
  static void suppressAutoLogoutFor(Duration duration) {
    _suppressAutoLogoutUntil = DateTime.now().add(duration);
  }

  static bool get _isAutoLogoutSuppressed {
    final t = _suppressAutoLogoutUntil;
    if (t == null) return false;
    return DateTime.now().isBefore(t);
  }

  /// Handle 401 Unauthorized - Clear all data and navigate to nav screen
  static Future<void> _handle401Unauthorized() async {
    if (_isAutoLogoutSuppressed) {
      appLog('Auto-logout suppressed; skipping 401 handler.');
      return;
    }

    try {
      appLog('Handling 401 Unauthorized - Logging out user');

      // Delete all GetX controllers
      Get.deleteAll();

      // Clear all shared preferences data
      await SharePrefsHelper.clearData();

      // Clear bearer token
      bearerToken = "";

      // Navigate to nav screen (replacing all routes)
      if (Get.context != null) {
        // Pop any open dialogs first
        if (Navigator.of(Get.context!).canPop()) {
          Navigator.of(Get.context!).pop();
        }
        Get.offAllNamed(AppRoute.navScreen);
      }
    } catch (e) {
      appLog('Error in _handle401Unauthorized: $e');
    }
  }

  ///<======================== This is for get methode =======================>
  ///<======================== This is for get methode =======================>
  static Future<Response> getData(
    String uri, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    String? token,
    Map<String, dynamic>? body, // 👈 body parameter
  }) async {
    // Use in-memory token if already set, otherwise load from SharedPreferences
    if (bearerToken.isEmpty) {
      bearerToken = (await SharePrefsHelper.getString(SharedPreferenceValue.token)).trim();
    }

    var mainHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    if ((token != null && token.trim().isNotEmpty) || bearerToken.isNotEmpty) {
      mainHeaders['Authorization'] = 'Bearer ${token?.trim() ?? bearerToken}';
    }

    // 🔹 Handle query params
    if (query != null && query.isNotEmpty) {
      uri += '?';
      for (String param in query.keys) {
        uri += "$param=${query[param].toString()}&";
      }
      uri = uri.substring(0, uri.length - 1);
    }

    appLog('====> API Call: $uri');
    appLog('====> Headers: ${headers ?? mainHeaders}');
    if (body != null) debugPrint('====> Body: $body');
    String workShopId = await SharePrefsHelper.getString(
      SharedPreferenceValue.workshopId,
    );

    Map<String, dynamic> requestBody = {"providerWorkShopId": workShopId};
    if (body != null) {
      requestBody.addAll(body);
    }

    try {
      // 🔹 Use http.Request to allow custom body with GET
      var request = http.Request('GET', Uri.parse(ApiConstant.baseUrl + uri));

      request.headers.addAll(headers ?? mainHeaders);
      request.body = jsonEncode(requestBody);

      // 🔹 Send request manually
      var streamedResponse = await request.send().timeout(
        const Duration(seconds: timeoutInSeconds),
      );

      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 401) {
        appLog('API returned 401 for GET $uri. Body: ${response.body}');
        await _handle401Unauthorized();
        return const Response(
          statusCode: 401,
          statusText: 'Session expired, please log in',
        );
      }

      return handleResponse(response, uri);
    } catch (e) {
      debugPrint('------------${e.toString()}');
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  // static void _navigateToLoginScreen() {
  //   // If suppressed (just after login) do not redirect the user automatically
  //   if (_isAutoLogoutSuppressed) {
  //     appLog('Auto-logout suppressed; skipping navigation to login screen.');
  //     return;
  //   }
  //
  //   // try {
  //   //   if (Get.currentRoute != AppRoute.loginScreen) {
  //   //     Get.offAllNamed(AppRoute.loginScreen);
  //   //   }
  //   // } catch (e) {
  //   //   appLog('Error navigating to login screen: $e');
  //   // }
  //
  //   // Remove stored token to fully logout
  //   SharePrefsHelper.remove(AppConstants.bearerToken);
  // }

  ///<====================== This is for post methode ========================>

  static Future<Response> postData(
      String uri, {
        Map<String, dynamic>? query,
        Map<String, String>? headers,
        String? token,
        dynamic body,
      }) async {
    if (bearerToken.isEmpty) {
      bearerToken = (await SharePrefsHelper.getString(AppConstants.bearerToken)).trim();
    }

    var mainHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    // Add token
    if ((token != null && token.trim().isNotEmpty) || bearerToken.isNotEmpty) {
      mainHeaders['Authorization'] = 'Bearer ${token?.trim() ?? bearerToken}';
    }

    // Add query params
    if (query != null && query.isNotEmpty) {
      uri += '?';
      for (String param in query.keys) {
        uri += "$param=${query[param].toString()}&";
      }
      uri = uri.substring(0, uri.length - 1);
    }

    if (body != null) appLog('====> Body: $body');

    String workShopId = await SharePrefsHelper.getString(
      SharedPreferenceValue.workshopId,
    );

    Map<String, dynamic> requestBody = {};

    if (workShopId.isNotEmpty) {
      requestBody["providerWorkShopId"] = workShopId;
    }

    if (body != null) {
      requestBody.addAll(body);
    }

    String bodyJson = jsonEncode(requestBody);

    try {
      appLog('====> API Call: $uri');
      appLog('====> Header: ${headers ?? mainHeaders}');
      appLog('====> API Body: $bodyJson');

      http.Response response = await client
          .post(
        Uri.parse(ApiConstant.baseUrl + uri),
        body: bodyJson,
        headers: headers ?? mainHeaders,
      )
          .timeout(const Duration(seconds: timeoutInSeconds));

      if (response.statusCode == 401) {
        appLog('API returned 401 for POST $uri. Body: ${response.body}');
        await _handle401Unauthorized();
        return const Response(
          statusCode: 401,
          statusText: 'Session expired, please log in',
        );
      }

      return handleResponse(response, uri);
    } catch (e) {
      debugPrint('------------${e.toString()}');
      return  Response(statusCode: 1, statusText: noInternetMessage);
    }
  }


  ///<====================== This is for patch methode ========================>
  static Future<Response> patchData(
    String uri, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    if (bearerToken.isEmpty) {
      bearerToken = (await SharePrefsHelper.getString(AppConstants.bearerToken)).trim();
    }
    Map<String, String> mainHeaders;
    if (bearerToken.isEmpty) {
      mainHeaders = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
    } else {
      mainHeaders = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $bearerToken',
      };
    }

    try {
      appLog('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      appLog('====> API Body: $body');
      String workShopId = await SharePrefsHelper.getString(
        SharedPreferenceValue.workshopId,
      );

      Map<String, dynamic> requestBody = {};

      // Add workshopId if available
      if (workShopId.isNotEmpty) {
        requestBody["providerWorkShopId"] = workShopId;
      }

      // Add body if provided
      if (body != null) {
        requestBody.addAll(body);
      }

      String bodyJson = jsonEncode(requestBody);
      // JSON encode the body
      appLog('====> API Body JSON: $bodyJson');

      http.Response response = await client
          .patch(
            Uri.parse(ApiConstant.baseUrl + uri),
            body: bodyJson,
            headers: headers ?? mainHeaders,
          )
          .timeout(const Duration(seconds: timeoutInSeconds));

      if (response.statusCode == 401) {
        appLog('API returned 401 for PATCH $uri. Body: ${response.body}');
        await _handle401Unauthorized();
        return const Response(
          statusCode: 401,
          statusText: 'Session expired, please log in',
        );
      }

      return handleResponse(response, uri);
    } catch (e) {
      appLog('------------${e.toString()}');
      return  Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  ///<====================== This is for postMultipartData  methode ========================>

  static Future<Response> postMultipartData(
    String uri,
    Map<String, String> body, {
    List<MultipartBody>? multipartBody,
    Map<String, String>? headers,
    String? token,
  }) async {
    try {
      bearerToken = await SharePrefsHelper.getString(AppConstants.bearerToken);

      var mainHeaders = {
        'Accept': 'application/json',
        'Authorization': token != null
            ? 'Bearer $token'
            : 'Bearer $bearerToken',
      };

      appLog('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      appLog('====> API Body: $body with ${multipartBody?.length} picture');
      //http.MultipartRequest _request = http.MultipartRequest('POST', Uri.parse("https://b936-114-130-157-130.ngrok-free.app/api/v1/user/profile/store/degree"));
      //_request.headers.addAll(headers ?? mainHeaders);
      // for(MultipartBody multipart in multipartBody!) {
      //   if(multipart.file != null) {
      //     Uint8List _list = await multipart.file.readAsBytes();
      //     _request.files.add(http.MultipartFile(
      //       multipart.key, multipart.file.readAsBytes().asStream(), _list.length,
      //       filename: '${DateTime.now().toString()}.png',
      //     ));
      //   }
      // }
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiConstant.baseUrl + uri),
      );
      request.fields.addAll(body);

      if (multipartBody!.isNotEmpty) {
        // ignore: avoid_function_literals_in_foreach_calls
        multipartBody.forEach((element) async {
          appLog("path : ${element.file.path}");

          var mimeType = lookupMimeType(element.file.path);

          appLog("MimeType================$mimeType");

          var multipartImg = await http.MultipartFile.fromPath(
            element.key,
            element.file.path,
            contentType: MediaType.parse(mimeType!),
          );
          request.files.add(multipartImg);
          //request.files.add(await http.MultipartFile.fromPath(element.key, element.file.path,contentType: MediaType('video', 'mp4')));
        });
      }

      request.headers.addAll(mainHeaders);
      http.StreamedResponse response = await request.send();
      final content = await response.stream.bytesToString();
      appLog('====> API Response: [${response.statusCode}}] $uri\n$content');
      if (response.statusCode == 401) {
        await _handle401Unauthorized();
        return const Response(
          statusCode: 401,
          statusText: 'Session expired, please log in',
        );
      }

      return Response(
        statusCode: response.statusCode,
        statusText: noInternetMessage,
        body: content,
      );
    } catch (e) {
      appLog('------------${e.toString()}');

      return  Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  ///<====================== This is for patchMultipartData methode ========================>

  static Future<Response> patchMultipartData(
    String uri,
    Map<String, dynamic> body, {
    List<MultipartBody>? multipartBody,
    Map<String, String>? headers,
    String? token,
  }) async {
    try {
      bearerToken = await SharePrefsHelper.getString(AppConstants.bearerToken);

      var mainHeaders = {
        'Accept': 'application/json',
        'Authorization': token != null
            ? 'Bearer $token'
            : 'Bearer $bearerToken',
      };

      appLog('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      appLog('====> API Body: $body with ${multipartBody?.length} picture');

      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse(ApiConstant.baseUrl + uri),
      );

      // Convert the body values to String if they are not already
      request.fields.addAll(
        body.map((key, value) {
          return MapEntry(key, value.toString());
        }),
      );

      if (multipartBody!.isNotEmpty) {
        // ignore: avoid_function_literals_in_foreach_calls
        multipartBody.forEach((element) async {
          debugPrint("path : ${element.file.path}");

          var mimeType = lookupMimeType(element.file.path);

          appLog("MimeType================$mimeType");

          var multipartImg = await http.MultipartFile.fromPath(
            element.key,
            element.file.path,
            contentType: MediaType.parse(mimeType!),
          );
          request.files.add(multipartImg);
        });
      }

      request.headers.addAll(mainHeaders);
      http.StreamedResponse response = await request.send();
      final content = await response.stream.bytesToString();
      appLog('====> API Response: [${response.statusCode}}] $uri\n$content');
      if (response.statusCode == 401) {
        await _handle401Unauthorized();
        return const Response(
          statusCode: 401,
          statusText: 'Session expired, please log in',
        );
      }

      return Response(
        statusCode: response.statusCode,
        statusText: noInternetMessage,
        body: content,
      );
    } catch (e) {
      debugPrint('------------${e.toString()}');

      return  Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  ///<====================== This is for patch methode ========================>
  static Future<Response> putData(
    String uri,
    dynamic body, {
    Map<String, String>? headers,
  }) async {
    if (bearerToken.isEmpty) {
      bearerToken = (await SharePrefsHelper.getString(AppConstants.bearerToken)).trim();
    }

    var mainHeaders = {
      'Content-Type': 'application/json', // Changed to application/json
      'Authorization': 'Bearer $bearerToken',
    };

    try {
      appLog('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      appLog('====> API Body: $body');

      // Encode the body as JSON
      http.Response response = await http
          .put(
            Uri.parse(ApiConstant.baseUrl + uri),
            body: jsonEncode(body), // Ensure the body is correctly JSON encoded
            headers: headers ?? mainHeaders,
          )
          .timeout(const Duration(seconds: timeoutInSeconds));
      if (response.statusCode == 401) {
        await _handle401Unauthorized();
        return const Response(
          statusCode: 401,
          statusText: 'Session expired, please log in',
        );
      }

      return handleResponse(response, uri);
    } catch (e) {
      debugPrint('------------${e.toString()}');
      return  Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  static Future<Response> putMultipartData(
    String uri,
    Map<String, String> body, {
    List<MultipartBody>? multipartBody,
    List<MultipartListBody>? multipartListBody,
    Map<String, String>? headers,
  }) async {
    try {
      bearerToken = await SharePrefsHelper.getString(AppConstants.bearerToken);

      var mainHeaders = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $bearerToken',
      };

      appLog('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      appLog('====> API Body: $body with ${multipartBody?.length} picture');

      //http.MultipartRequest _request = http.MultipartRequest('POST', Uri.parse("https://b936-114-130-157-130.ngrok-free.app/api/v1/user/profile/store/degree"));
      //_request.headers.addAll(headers ?? mainHeaders);
      // for(MultipartBody multipart in multipartBody!) {
      //   if(multipart.file != null) {
      //     Uint8List _list = await multipart.file.readAsBytes();
      //     _request.files.add(http.MultipartFile(
      //       multipart.key, multipart.file.readAsBytes().asStream(), _list.length,
      //       filename: '${DateTime.now().toString()}.png',
      //     ));
      //   }
      // }

      var request = http.MultipartRequest(
        'PUT',
        Uri.parse(ApiConstant.baseUrl + uri),
      );
      request.fields.addAll(body);

      if (multipartBody!.isNotEmpty) {
        // ignore: avoid_function_literals_in_foreach_calls
        multipartBody.forEach((element) async {
          debugPrint("path : ${element.file.path}");

          if (element.file.path.contains(".mp4")) {
            debugPrint("media type mp4 ==== ${element.file.path}");
            request.files.add(
              http.MultipartFile(
                element.key,
                element.file.readAsBytes().asStream(),
                element.file.lengthSync(),
                filename: 'video.mp4',
                contentType: MediaType('video', 'mp4'),
              ),
            );
          } else if (element.file.path.contains(".png")) {
            debugPrint("media type png ==== ${element.file.path}");
            request.files.add(
              http.MultipartFile(
                element.key,
                element.file.readAsBytes().asStream(),
                element.file.lengthSync(),
                filename: 'image.png',
                contentType: MediaType('image', 'png'),
              ),
            );
          }

          //request.files.add(await http.MultipartFile.fromPath(element.key, element.file.path,contentType: MediaType('video', 'mp4')));
        });
      }

      request.headers.addAll(mainHeaders);
      http.StreamedResponse response = await request.send();
      final content = await response.stream.bytesToString();
      debugPrint(
        '====> API Response: [${response.statusCode}}] $uri\n$content',
      );
      if (response.statusCode == 401) {
        await _handle401Unauthorized();
        return const Response(
          statusCode: 401,
          statusText: 'Session expired, please log in',
        );
      }

      return Response(
        statusCode: response.statusCode,
        statusText: noInternetMessage,
        body: content,
      );
    } catch (e) {
      return  Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  ///<====================== This is for delete methode ========================>
  static Future<Response> deleteData(
    String uri, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    if (bearerToken.isEmpty) {
      bearerToken = await SharePrefsHelper.getString(AppConstants.bearerToken);
    }

    var mainHeaders = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      appLog('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      appLog('====> API Call: $uri\n Body: $body');

      http.Response response = await http
          .delete(
            Uri.parse(ApiConstant.baseUrl + uri),
            headers: headers ?? mainHeaders,
            body: body,
          )
          .timeout(const Duration(seconds: timeoutInSeconds));
      if (response.statusCode == 401) {
        await _handle401Unauthorized();
        return const Response(
          statusCode: 401,
          statusText: 'Session expired, please log in',
        );
      }
      return handleResponse(response, uri);
    } catch (e) {
      return  Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  ///<====================== This is for handle response methode ========================>
  static Response handleResponse(http.Response response, String uri) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (e) {
      debugPrint(e.toString());
    }
    Response response0 = Response(
      body: body ?? response.body,
      bodyString: response.body.toString(),
      request: Request(
        headers: response.request!.headers,
        method: response.request!.method,
        url: response.request!.url,
      ),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if (response.statusCode == 401) {
      _handle401Unauthorized();
      return const Response(
        statusCode: 401,
        statusText: 'Session expired, please log in',
      );
    }

    if (response0.statusCode != 200 &&
        response0.body != null &&
        response0.body is! String) {
      ErrorResponse errorResponse = ErrorResponse.fromJson(response0.body);
      response0 = Response(
        statusCode: response0.statusCode,
        body: response0.body,
        statusText: errorResponse.message,
      );

      // if(_response.body.toString().startsWith('{errors: [{code:')) {
      //   ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
      //   _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _errorResponse.errors[0].message);
      // }else if(_response.body.toString().startsWith('{message')) {
      //   _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _response.body['message']);
      // }
      // response0 = Response(
      //   statusCode: response0.statusCode,
      //   body: response0.body,
      // );
    } else if (response0.statusCode != 200 && response0.body == null) {
      response0 =  Response(statusCode: 0, statusText: noInternetMessage);
    }

    appLog(
      '====> API Response: [${response0.statusCode}] $uri\n${response0.body}',
    );
    // log.e("Handle Response error} ");
    return response0;
  }

  ///<====================== This is for PUT method ========================>
}

class MultipartBody {
  String key;
  File file;
  MultipartBody(this.key, this.file);
}

class MultipartListBody {
  String key;
  String value;
  MultipartListBody(this.key, this.value);
}
