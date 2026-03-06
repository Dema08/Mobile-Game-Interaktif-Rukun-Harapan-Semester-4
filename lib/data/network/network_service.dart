import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../local/local_storage.dart';
import 'custom_exception.dart';

class NetworkService {
  static dynamic compileResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(generateError(response.body));
      case 401:
        LocalStorage.clearSession();
        throw UnauthorisedException(generateError(response.body));
      case 402:
        throw UnauthorisedException(generateError(response.body));
      case 403:
        throw UnauthorisedException(generateError(response.body));
      case 409:
        throw ConflictException(generateError(response.body));
      case 404:
        throw NotFoundException(generateError(response.body));
      case 500:
        throw InternalServerErrorException(generateError(response.body));
      default:
        throw FetchDataException(
            'Error occurred while communication with Server with StatusCode : ${response.body}');
    }
  }

  static dynamic generateError(String responseBody) {
    Map<String, dynamic> errorBody = json.decode(responseBody);
    if (errorBody.containsKey('failed')) {
      return errorBody['failed'];
    }
    if (errorBody.containsKey('error')) {
      return "${errorBody['error']["header"]} - ${errorBody['error']["message"]}";
    }
    if (errorBody.containsKey('message')) {
      return errorBody['message'];
    }
    final errorKeys = errorBody.keys.toList();
    if (errorKeys.isNotEmpty) {
      return errorBody[errorKeys[0]][0];
    }
    return errorBody['message'];
  }

  static Future<dynamic> get(
    String baseUrl,
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    bool withToken = false,
    bool isHttps = true,
  }) async {
    final uri = isHttps
        ? Uri.https(baseUrl, url, queryParameters)
        : Uri.http(baseUrl, url, queryParameters);
    log("$uri", name: "urlMade");
    try {
      headers ??= {};
      if (withToken) {
        final token = await LocalStorage.getBearerToken();
        headers!.addAll({'Authorization': 'Bearer $token'});
      }
      headers.addAll({'Accept': 'application/json'});
      log('GET: ${uri.toString()}', name: 'NETWORK SERVICE');
      log('PARAMS: ${queryParameters.toString()}', name: 'NETWORK SERVICE');
      log('HEADERS: ${headers.toString()}', name: 'NETWORK SERVICE');
      final response = await http.get(uri, headers: headers);
      return compileResponse(response);
    } on SocketException {
      throw FetchDataException('Tidak ada koneksi internet');
    } on FormatException {
      throw const FormatException('unauthorized');
    } catch (e) {
      log(e.toString(), name: 'NETWORK SERVICE');
      rethrow;
    }
  }

  static Future<dynamic> post(
    String baseUrl,
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? data,
    bool withToken = false,
    bool isHttps = true,
  }) async {
    var uri = isHttps ? Uri.https(baseUrl, url) : Uri.http(baseUrl, url);
    headers ??= {};
    try {
      headers.addAll({
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });

      if (withToken) {
        final token = await LocalStorage.getBearerToken();
        headers!.addAll({'Authorization': 'Bearer $token'});
      }

      final body = json.encode(data);

      log('POST: ${uri.toString()}', name: 'NETWORK SERVICE');
      log('PARAMS: ${data.toString()}', name: 'NETWORK SERVICE');
      log('HEADERS: ${headers.toString()}', name: 'NETWORK SERVICE');

      final response = await http.post(uri, body: body, headers: headers);
      return compileResponse(response);
    } on SocketException catch (e) {
      log(e.toString(), name: 'NETWORK SERVICE');
      throw FetchDataException('Tidak ada koneksi internet');
    } on NotFoundException catch (e) {
      log(e.toString(), name: 'NETWORK SERVICE');
      throw NotFoundException('Akun tidak terdaftar');
    } catch (e) {
      log(e.toString(), name: 'NETWORK SERVICE');
      rethrow;
    }
  }

  static Future<dynamic> delete(
    String baseUrl,
    String url, {
    Map<String, String> headers = const {},
    Map<String, String> data = const {},
    bool withToken = false,
    bool isHttps = true,
  }) async {
    var uri = isHttps ? Uri.https(baseUrl, url) : Uri.http(baseUrl, url);
    try {
      headers = {...headers};
      headers.addAll({'Accept': 'application/json'});
      if (withToken) {
        final token = await LocalStorage.getBearerToken();
        headers.addAll({'Authorization': 'Bearer $token'});
      }
      log('DELETE: ${uri.toString()}', name: 'NETWORK SERVICE');
      log('PARAMS: ${data.toString()}', name: 'NETWORK SERVICE');
      log('HEADERS: ${headers.toString()}', name: 'NETWORK SERVICE');
      final response = await http.delete(uri, body: data, headers: headers);
      return compileResponse(response);
    } on SocketException {
      throw FetchDataException('Tidak ada koneksi internet');
    } on NotFoundException {
      throw NotFoundException('Akun tidak terdaftar');
    } catch (e) {
      log(e.toString(), name: 'NETWORK SERVICE');
      rethrow;
    }
  }

  static Future<dynamic> put(
    String baseUrl,
    String url, {
    bool withToken = false,
    bool isHttps = true,
    Map<String, String>? headers,
    Map<String, String>? data,
  }) async {
    var uri = isHttps ? Uri.https(baseUrl, url) : Uri.http(baseUrl, url);
    headers ??= {};
    try {
      headers.addAll({'Accept': 'application/json'});
      if (withToken) {
        final token = await LocalStorage.getBearerToken();
        headers!.addAll({'Authorization': 'Bearer $token'});
      }
      log('PUT: ${uri.toString()}', name: 'NETWORK SERVICE');
      log('PARAMS: ${data.toString()}', name: 'NETWORK SERVICE');
      log('HEADERS: ${headers.toString()}', name: 'NETWORK SERVICE');
      final response = await http.put(uri, body: data, headers: headers);
      return compileResponse(response);
    } on SocketException {
      throw FetchDataException('Tidak ada koneksi internet');
    } on NotFoundException {
      throw NotFoundException('Akun tidak terdaftar');
    } catch (e) {
      log(e.toString(), name: 'NETWORK SERVICE');
      rethrow;
    }
  }

  static Future<dynamic> postWithImage(
    String baseUrl,
    String url, {
    bool isHttps = false,
    bool withToken = true,
    bool isResponseJson = true,
    Map<String, File> images = const {},
    Map<String, String> data = const {},
    Map<String, String> headers = const {},
  }) async {
    try {
      var uri = isHttps ? Uri.https(baseUrl, url) : Uri.http(baseUrl, url);
      var request = http.MultipartRequest('POST', uri);
      Map<String, String> contentType = {"Content-type": "multipart/form-data"};
      request.headers.addAll(contentType);
      request.headers.addAll({'Accept': 'application/json'});
      if (withToken) {
        final token = await LocalStorage.getBearerToken();
        headers = {...headers, 'Authorization': 'Bearer $token'};
      }
      log(uri.toString(), name: 'POST WITH IMAGES');
      log(request.headers.toString(), name: 'POST WITH IMAGES');
      log(data.toString(), name: 'POST WITH IMAGES');
      log(images.values.toString(), name: 'POST WITH IMAGES');
      images.forEach((key, image) {
        request.files.add(
          http.MultipartFile(
            key,
            image.readAsBytes().asStream(),
            image.lengthSync(),
            filename: image.uri.pathSegments.last,
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      });
      request.headers.addAll(headers);
      request.fields.addAll(data);
      var res = await request.send();
      final response = await http.Response.fromStream(res);
      if (isResponseJson) {
        return compileResponse(response);
      }
      return response;
    } on SocketException {
      throw FetchDataException('Tidak ada koneksi internet');
    }
  }

  static Future<dynamic> putWithImage(
    String baseUrl,
    String url, {
    bool isHttps = false,
    bool withToken = true,
    bool isResponseJson = true,
    Map<String, File> images = const {},
    Map<String, String> data = const {},
    Map<String, String> headers = const {},
  }) async {
    try {
      var uri = isHttps ? Uri.https(baseUrl, url) : Uri.http(baseUrl, url);
      var request = http.MultipartRequest('POST', uri);
      request.headers['Accept'] = 'application/json';
      if (withToken) {
        final token = await LocalStorage.getBearerToken();
        headers = {...headers, 'Authorization': 'Bearer $token'};
      }
      request.headers.addAll(headers);
      log(uri.toString(), name: 'PUT WITH IMAGES');
      log(request.headers.toString(), name: 'PUT WITH IMAGES');
      log(data.toString(), name: 'PUT WITH IMAGES');
      log(images.values.toString(), name: 'PUT WITH IMAGES');
      images.forEach((key, image) {
        request.files.add(
          http.MultipartFile(
            key,
            image.readAsBytes().asStream(),
            image.lengthSync(),
            filename: image.uri.pathSegments.last,
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      });
      request.fields.addAll(data);
      var res = await request.send();
      final response = await http.Response.fromStream(res);
      if (isResponseJson) {
        return compileResponse(response);
      }
      return response;
    } on SocketException {
      throw FetchDataException('Tidak ada koneksi internet');
    }
  }
}
