import 'dart:async';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../di/service_locator.dart';
import '../log/log.dart';
import 'api_exception.dart';
import 'dio_module.dart';
import 'result.dart';

abstract class NetworkModule {
  Dio get _dio => DioModule.getInstance();

  Log get log => getIt<Log>();

  BaseOptions? options;

  Future<Result<T>> _safeCallApi<T>(Future<Response<T>> call) async {
    try {
      var response = await call;
      return Result.success(
        response.data!,
        response.statusMessage,
      );
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        return Result.error(
          e.response!.statusCode ?? 400,
          e.response!.data,
        );
      } else {
        return Result.timeout(
          '' as dynamic,
          'Network Failure',
        );
      }
    } catch (ex) {
      return Result.timeout(
        '' as dynamic,
        'Network Failure',
      );
    }
  }

  Future<Result<dynamic>> getMethod(
    String endpoint, {
    Map<String, dynamic>? param,
    Map<String, String>? headers,
    bool cache = false,
  }) async {
    late Options _options;

    _options = Options(headers: headers);

    var response = await _safeCallApi(
      _dio.get(
        endpoint,
        queryParameters: param,
        options: _options,
      ),
    );

    return response;
  }

  Future<Result<dynamic>> postMethod(
    String endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  }) async {
    var _options = Options(headers: headers);

    var response = await _safeCallApi(
      _dio.post(
        endpoint,
        data: body,
        options: _options,
      ),
    );

    log.console('BODY: ${response.body}');
    log.console('RESPONSE : $body');
    log.console('POST: ${response.message}');
    return response;
  }

  Future<Result<dynamic>> putMethod(
    String endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  }) async {
    var _options = Options(headers: headers);

    var response = await _safeCallApi(
      _dio.put(
        endpoint,
        data: body,
        options: _options,
      ),
    );

    return response;
  }

  Future<Result> postUploadDocument(
    String endpoint,
    String url, {
    Map<String, String>? headers,
    FormData? body,
  }) async {
    var _options = Options(headers: headers);
    var dio = DioModule.getInstance(
      options: BaseOptions(
        baseUrl: url,
        connectTimeout: 10000,
        sendTimeout: 10000,
        receiveTimeout: 10000,
      ),
    );
    log.console(dio.options.baseUrl);

    var response = await _safeCallApi(
      dio.post(
        endpoint,
        data: body,
        options: _options,
      ),
    );

    return response;
  }

  Future<Result<dynamic>?> deleteMethod(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    var _options = Options(headers: headers);

    var response = await _safeCallApi(
      _dio.delete(
        endpoint,
        data: body,
        options: _options,
      ),
    );

    return response;
  }

  /// [dynamic] this method is return response from [Result<dynamic>]
  dynamic responseHandler(Result<dynamic> result) {
    switch (result.status) {
      case Status.success:
        return result.body;
      case Status.error:
        if (result.code == 401) {
          throw UnAuthorizedExceptions(result.body);
        } else {
          throw ErrorRequestException(result.code, result.body);
        }
      case Status.unreachable:
        throw NetworkException(result.message);
      default:
        throw ArgumentError();
    }
  }
}

@LazySingleton(as: NetworkModule)
class NetworkModuleImpl extends NetworkModule {}
