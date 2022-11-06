import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:quotes/core/api/api_service.dart';
import 'package:quotes/core/api/app_interceptors.dart';
import 'package:quotes/core/api/end_points.dart';
import 'package:quotes/core/api/status_code.dart';
import 'package:quotes/core/error/exceptions.dart';
import 'package:quotes/injection_container.dart';

class DioConsumer implements ApiService {
  final Dio dio;

  DioConsumer(this.dio) {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      return client;
    };
    dio.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < StatusCode.internalServerError;
      };

    dio.interceptors.add(sl<AppInterceptors>());

    if (kDebugMode) {
      dio.interceptors.add(sl<LogInterceptor>());
    }
  }

  @override
  Future get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      return _mapResponseToJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future post(String path,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters,
      bool formDataIsEnabled = false}) async {
    try {
      final response = await dio.post(path,
          data: formDataIsEnabled ? FormData.fromMap(body!) : body,
          queryParameters: queryParameters);
      return _mapResponseToJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future put(String path,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await dio.put(path, data: body, queryParameters: queryParameters);
      return _mapResponseToJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  dynamic _mapResponseToJson(Response<dynamic> response) {
    final responseJson = jsonDecode(response.data.toString());
    return responseJson;
  }

  dynamic _handleDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw const FetchDataException();
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case StatusCode.badRequest:
            throw const BadRequestException();
          case StatusCode.unauthorized:
          case StatusCode.forbidden:
            throw const UnauthorizedException();
          case StatusCode.notFound:
            throw const NotFoundException();
          case StatusCode.confilct:
            throw const ConflictException();
          case StatusCode.internalServerError:
            throw const InternalServerErrorException();
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        throw const NoInternetConnectionException();
    }
  }
}
