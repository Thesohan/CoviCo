import 'dart:async';
import 'dart:io';
import 'package:covico/data/resource.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

enum Method { get, post, delete, put }
/// Singleton class
class RequestHandler {
  static RequestHandler _instance;
  final Dio _dio;
  final Logger _logger = Logger("RequestHandler");
  RequestHandler._internal(this._dio);
  static void init(Dio dio) {
    _instance = RequestHandler._internal(dio);
  }

  static RequestHandler get instance {
    if (_instance == null) {
      throw Error();
    }
    return _instance;
  }

  Future<Resource<Response>> sendRequest<Response>({
    @required Method method,
    @required String path,
    Map<String, dynamic> queryParameters,
    dynamic body,
    ContentType contentType,
    @required Response Function(dynamic response) responseMapper,
  }) async {
    assert(method != null);
    assert(path != null);
    assert(responseMapper != null);
    try {
//      Map<String,dynamic>headers={};
//      String rawCookie =await _getRawCookie();
//      if(rawCookie!=null){
//        headers.addAll({
//          "cookie":rawCookie
//        });
//      }

      final response = await _dio.request(
        path,
        options: Options(
//          headers: headers,
          method: method.toString().split(".")[1],
        ),
        data: body,
        queryParameters: queryParameters,
      );
      _logger.info('response$response');
//      _saveCookies(response.headers);
      return Resource.success(data: responseMapper(response));
    } catch (error, stackTrace) {
      if (error is DioError) {
        _logger.info('error: $error');
        return handleDioError(error);
      }
      return Resource.failure(message: error.toString());
    }
  }

  /// Handle all cases of [DioError].
  Resource<T> handleDioError<T>(DioError error) {
    // TODO(leen-nobbas): Wrap this in a try catch
    switch (error.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        {
          return Resource.failure(
            message: "Network problem. Something went wrong.",
//            statusCode: error.response.statusCode,
          );
        }
      case DioErrorType.DEFAULT:
        {
          return Resource.failure(
            message:
                "No internet connection. Make sure wi-fi or cellular data is turned on then try again",
            isNetworkError: true,
            statusCode: -1,
          );
        }
      case DioErrorType.RESPONSE:
        {
          return Resource.failure(
            message: "Something Went Wrong",
//            statusCode: error.response.statusCode,
          );
        }
      default:
        {
          return Resource.failure(message: error.toString());
        }
    }
  }
//
//  Future _saveCookies(Headers headers) async{
//    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
//   await sharedPrefHandler.updateCookies(headers);
//  }
//
//  Future<String> _getRawCookie() async{
//    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
//    String rawCookie =await sharedPrefHandler.getCookies();
//    return rawCookie;
//  }
}
