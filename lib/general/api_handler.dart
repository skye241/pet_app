import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/general/constant/url.dart';
import 'package:family_pet/main.dart';
import 'package:family_pet/model/entity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';

bool _statusOk(int? statusCode) {
  if (statusCode != null) {
    print(statusCode);
    return statusCode >= 200 && statusCode <= 300;
  }
  return false;
}

class NetworkService {
  final Map<String, String> _headers = <String, String>{
    Constant.contentType: 'application/json',
    // Constant.contentLength: '64',
    Constant.cacheControl: 'no-cache',
  };

  Map<String, String> cookies = <String, String>{};

  //Update và set cookies

  void _updateCookie(Response response) {
    final String? allSetCookie = response.headers['set-cookie'];

    print((response.headers['set-cookie'] ?? '') + '=====Cookie');

    if (allSetCookie != null) {
      final List<String> setCookies = allSetCookie.split(',');

      for (final String setCookie in setCookies) {
        final List<String> cookies = setCookie.split(';');

        for (int i = 0; i < cookies.length; i++) {
          final String cookie = cookies[i];
          _setCookie(cookie);
        }
      }

      _headers[Constant.cookie] = _generateCookieHeader();
      prefs?.setString(Constant.cookie, _generateCookieHeader());
    }
  }

  void _setCookie(String? rawCookie) {
    if (rawCookie != null) {
      final List<String> keyValue = rawCookie.split('=');
      if (keyValue.length == 2) {
        final String key = keyValue[0].trim();
        final String value = keyValue[1];

        // ignore keys that aren't cookies
        if (key == 'path' || key == 'expires') {
          return;
        }

        cookies[key] = value;
      }
    }
  }

  String _generateCookieHeader() {
    String cookie = '';

    for (final String key in cookies.keys) {
      if (cookie.isNotEmpty) {
        cookie += ';';
      }
      cookie += key + '=' + cookies[key]!;
    }

    return cookie;
  }

  ///
  /// Hàm gọi API lên Server bằng GET Method
  /// [path] là đường link của API (Không phải Base URL). Đây là trường bắt buộc
  /// [headers]  Không bắt buộc phải truyền vào trừ trường hợp muốn custom hoặc truyền thêm
  ///
  ///
  Future<APIResponse> callGET(String url,
      {Map<String, String>? headers}) async {
    _headers[Constant.cookie] = prefs?.getString(Constant.cookie) ?? '';
    // _headers[Constant.XCSRFToken] =
    //     '0zWGhQ7G41reHt5oI2Rmeob8QdgiK14MHaH2amWwPknfGly3Sx71JZHBJHquY10h';
    // _headers[Constant.cookie] = 'sessionid=4dv8ia2ypq0wfpgfp8su5ylxlwc5qo6o';
    _headers.addAll(headers ?? <String, String>{});
    try {
      print('GET ===================== ');
      print('HEADER: $_headers');
      print('URL : $url');
      final Response? response = await get(Uri.parse(url), headers: _headers)
          .timeout(const Duration(seconds: 30));
      if (response != null) {
        print('RESPONSE: ' + utf8.decode(response.bodyBytes));
        _updateCookie(response);
      }
      APIResponse result;
      if (_statusOk(response?.statusCode)) {
        result = APIResponse(
          code: response?.statusCode,
          isOK: true,
          data: json.decode(utf8.decode(response!.bodyBytes)),
        );
      } else {
        // final Map<String, dynamic> jsonError =
        //     jsonDecode(response.body)[Constant.data] as Map<String, dynamic>;
        result = APIResponse(
            isOK: false,
            code: response?.statusCode,
            data: <String, dynamic>{},
            message: getErrorMessage(response?.statusCode ?? 500));
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
    @required Map<String, dynamic>? body,
    Map<String, String>? header,
  }) async {
    final String _url = url ?? '';
    if (prefs?.getString(Constant.cookie)!.isNotEmpty ?? false) {
      _headers[Constant.cookie] = prefs?.getString(Constant.cookie) ?? '';
    }
    _headers[Constant.contentLength] =
        utf8.encode(jsonEncode(body)).length.toString();
    _headers.addAll(header ?? <String, String>{});

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
      final Response? response = await post(Uri.parse(_url),
              headers: _headers, body: json.encode(body))
          .timeout(const Duration(seconds: 30));
      if (response != null) {
        print('RESPONSE: ' + utf8.decode(response.bodyBytes));
        _updateCookie(response);
      }

      APIResponse result;
      if (_statusOk(response?.statusCode)) {
        result = APIResponse(
          code: response?.statusCode,
          isOK: true,
          data: json.decode(utf8.decode(response!.bodyBytes)),
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
    _headers.addAll(header ?? <String, String>{});
    _headers[Constant.cookie] = prefs?.getString(Constant.cookie) ?? '';
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
        _updateCookie(response);
      }
      APIResponse result;
      if (_statusOk(response?.statusCode)) {
        result = APIResponse(
          code: response?.statusCode,
          isOK: true,
          data: json.decode(utf8.decode(response!.bodyBytes)),
        );
      } else {
        final Map<String, dynamic> jsonError =
            json.decode(response?.body ?? '')[Constant.message]
                as Map<String, dynamic>;
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

Future<StreamedResponse> uploadImage(
    File file, Map<String, String> body) async {
  // final SharedPreferences prefs = await SharedPreferences.getInstance();
  const String _url = Url.uploadMedia;
  final Map<String, String> headers = <String, String>{};
  headers[Constant.contentType] = 'multipart/form-data';

  print('Calling upload image ===========================================');
  print('header: ' + headers.toString());
  print('URL: ' + _url);

  final Uri uri = Uri.parse(_url);
  final ByteStream stream = ByteStream(Stream.castFrom(file.openRead()));
  final int length = await file.length();

  final MultipartRequest request = MultipartRequest('POST', uri);
  final MultipartFile multipartFile = MultipartFile(
    'file',
    stream,
    length,
    filename: basename(file.path),
  );
  request.files.add(multipartFile);
  request.fields.addAll(body);
  request.headers.addAll(headers);
  print('request' + request.headers.toString());
  final StreamedResponse response = await request.send();
  print(response.statusCode);
  return response;
}
