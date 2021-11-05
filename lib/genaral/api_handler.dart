import 'dart:async';
import 'dart:convert';

import 'package:family_pet/genaral/constant/constant.dart';
import 'package:family_pet/model/entity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

bool _statusOk(int? statusCode) {
  if (statusCode != null) {
    return statusCode >= 200 && statusCode <= 300;
  }
  return false;
}

///
/// Hàm gọi API lên Server bằng GET Method
/// [path] là đường link của API (Không phải Base URL). Đây là trường bắt buộc
/// [headers]  Không bắt buộc phải truyền vào trừ trường hợp muốn custom hoặc truyền thêm
///
Future<APIResponse> callGET(String url, {Map<String, String>? headers}) async {
  final Map<String, String> _headers = <String, String>{};
  _headers[Constant.contentType] = 'application/json';
  _headers[Constant.XCSRFToken] =
      'dCI2MSYGL1B1xXZYvTGv9CUdY0naKT7On39vfMhn32Xw6wnsoYxWJHeJCZTsfmAM';
  _headers[Constant.cookie] = 'sessionid=4dv8ia2ypq0wfpgfp8su5ylxlwc5qo6o';
  _headers.addAll(headers ?? <String, String>{});
  try {
    print('GET ===================== ');
    print('HEADER: $_headers');
    print('URL : $url');
    final Response? response = await get(Uri.parse(url), headers: _headers)
        .timeout(const Duration(seconds: 30));
    if (response != null) {
      print('RESPONSE: ' + utf8.decode(response.bodyBytes));
    }
    APIResponse result;
    if (_statusOk(response?.statusCode)) {
      result = APIResponse(
        code: response?.statusCode,
        isOK: true,
        data: json.decode(utf8.decode(response!.bodyBytes)) as Map<String, dynamic>,
      );
    } else {
      // final Map<String, dynamic> jsonError =
      //     jsonDecode(response.body)[Constant.data] as Map<String, dynamic>;
      result = APIResponse(
          isOK: false,
          code: response?.statusCode,
          data: <String, dynamic>{},
          message:  getErrorMessage(response?.statusCode?? 500));
    }
    return result;
  } on TimeoutException catch (timeOutError) {
    print('API Timeout ${timeOutError.message}');
    throw APIException(APIResponse(
      isOK: false,
      code: 408,
      data: <String, dynamic>{},
      message: getErrorMessage(408),
    ));
  } catch (error) {
    print('API Exception $error');
    throw APIException(APIResponse(
      isOK: false,
      code: 100,
      data: <String, dynamic>{},
      message: getErrorMessage(100),
    ));
  }
}

Future<APIResponse> callPOST({
  @required String? url,
  @required dynamic body,
  Map<String, String>? header,
}) async {
  final String _url = url ?? '';
  final Map<String, String> _headers = <String, String>{};
  _headers.addAll(header ?? <String, String>{});
  _headers[Constant.contentType] = 'application/json';
  _headers[Constant.XCSRFToken] =
  'dCI2MSYGL1B1xXZYvTGv9CUdY0naKT7On39vfMhn32Xw6wnsoYxWJHeJCZTsfmAM';
  _headers[Constant.cookie] = 'sessionid=4dv8ia2ypq0wfpgfp8su5ylxlwc5qo6o';
  // final SharedPreferences prefs = await SharedPreferences.getInstance();
  // if (body is List) {
  //   for (final dynamic item in body) {
  //     if ((prefs.getString(Constant.apiToken) ?? '').isNotEmpty) {
  //       item[Constant.apiToken] = prefs.getString(Constant.apiToken);
  //     }
  //   }
  // } else {
  //   if ((prefs.getString(Constant.apiToken) ?? '').isNotEmpty) {
  //     body[Constant.apiToken] = prefs.getString(Constant.apiToken);
  //   }
  // }

  print('Calling post data ===============================================');
  print('header: $_headers');
  print('URL: $url');
  print('body: $body');
  try {
    final Response? response =
        await post(Uri.parse(_url), headers: _headers, body: json.encode(body))
            .timeout(const Duration(seconds: 30));
    if (response != null) {
      print('response: ' + response.body);
    }
    APIResponse result;
    if (_statusOk(response?.statusCode)) {
      result = APIResponse(
        code: response?.statusCode,
        isOK: true,
        data: json.decode(utf8.decode(response!.bodyBytes)) as Map<String, dynamic>,
      );
    } else {
      // final List<dynamic> jsonError =
      //     json.decode(response.body)[Constant.data] as List<dynamic>;

      result = APIResponse(
          isOK: false,
          code: response?.statusCode,
          data: <String, dynamic>{},
          message: getString(Constant.message,
              json.decode(response?.body ?? '') as Map<String, dynamic>));
    }
    return result;
  } on TimeoutException catch (timeOutError) {
    print('API Timeout ${timeOutError.message}');
    throw APIException(APIResponse(
      isOK: false,
      code: 408,
      data: <String, dynamic>{},
      message: getErrorMessage(408),
    ));
  } catch (error) {
    print('hello');
    print('API Exception $error');
    throw APIException(APIResponse(
      isOK: false,
      code: 100,
      data: <String, dynamic>{},
      message: getErrorMessage(100),
    ));
  }
}

Future<APIResponse> callPUT({
  @required String? url,
  @required dynamic body,
  Map<String, String>? header,
}) async {
  final String _url = url ?? '';
  final Map<String, String> _headers = <String, String>{};
  _headers.addAll(header ?? <String, String>{});
  _headers[Constant.contentType] = 'application/json';
  // if (body is List) {
  //   for (final dynamic item in body) {
  //     item[Constant.timeZone] = 7;
  //     item[Constant.platform] = 1;
  //     item[Constant.deviceType] = 1;
  //     item[Constant.fcmToken] = prefs.getString(Constant.firebaseKey);
  //     item[Constant.deviceId] = prefs.getString(Constant.deviceId);
  //   }
  // } else {
  //   body[Constant.timeZone] = 7;
  //   body[Constant.platform] = 1;
  //   body[Constant.deviceType] = 1;
  //   body[Constant.companyId] = prefs.getString(Constant.companyId);
  //   body[Constant.fcmToken] = prefs.getString(Constant.fcmToken);
  //   body[Constant.deviceId] = prefs.getString(Constant.deviceId);
  // }

  print('Calling put data ===============================================');
  print('header: $_headers');
  print('URL: $url');
  print('body: $body');
  try {
    final Response? response =
        await put(Uri.parse(_url), headers: _headers, body: jsonEncode(body))
            .timeout(const Duration(seconds: 30));
    if (response != null) {
      print('response: ' + response.body);
    }
    APIResponse result;
    if (_statusOk(response?.statusCode)) {
      result = APIResponse(
        code: response?.statusCode,
        isOK: true,
        data: json.decode(utf8.decode(response!.bodyBytes)) as Map<String, dynamic>,
      );
    } else {
      final Map<String, dynamic> jsonError = json
          .decode(response?.body ?? '')[Constant.data] as Map<String, dynamic>;
      result = APIResponse(
        isOK: false,
        code: response?.statusCode,
        data: jsonError,
        message: getErrorMessage(getInt(Constant.code, jsonError)),
      );
    }
    return result;
  } on TimeoutException catch (timeOutError) {
    print('API Timeout ${timeOutError.message}');
    throw APIException(APIResponse(
      isOK: false,
      code: 408,
      data: <String, dynamic>{},
      message: getErrorMessage(408),
    ));
  } catch (error) {
    print('API Exception $error');
    throw APIException(APIResponse(
      isOK: false,
      code: 100,
      data: <String, dynamic>{},
      message: getErrorMessage(100),
    ));
  }
}

/// Lấy string lỗi theo mã
String getErrorMessage(int code) {
  switch (code) {
    case 400:
      return 'Thông tin gửi lên không đúng định dạng';
    case 401:
      return 'Bạn không có quyền thực hiện hành động này';
    case 500:
      return 'Lỗi hệ thống, bạn vui lòng thử lại sau ít phút';
    default:
      return 'Lỗi hệ thống. Vui lòng kiểm tra lại.';
  }
}

class APIException implements Exception {
  APIException(this.apiResponse);

  final APIResponse apiResponse;

  String message() {
    return apiResponse.message ?? '';
  }
}

class APIParse {
   String listToString(String key, List<dynamic> values) {
    String request = '';
    for (final dynamic item in values) {
      request += '$key=$item&';
    }
    print('request $request');
    return request;
  }
}

// Future<StreamedResponse> uploadImage(File file) async {
//   // final SharedPreferences prefs = await SharedPreferences.getInstance();
//   const String _url = URL.uploadImage;
//   final Map<String, String> headers = <String, String>{};
//   headers[Constant.contentType] = 'multipart/form-data';
//
//   print('Calling upload image ===========================================');
//   print('header: ' + headers.toString());
//   print('URL: ' + _url);
//
//   final Uri uri = Uri.parse(_url);
//   final ByteStream stream = ByteStream(Stream.castFrom(file.openRead()));
//   final int length = await file.length();
//
//   final MultipartRequest request = MultipartRequest('POST', uri);
//   final MultipartFile multipartFile = MultipartFile(
//     'file',
//     stream,
//     length,
//     filename: basename(file.path),
//   );
//   request.files.add(multipartFile);
//   request.headers.addAll(headers);
//   print('request' + request.headers.toString());
//   final StreamedResponse response = await request.send();
//   print(response.statusCode);
//   return response;
// }
