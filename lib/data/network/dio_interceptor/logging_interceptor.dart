//import 'package:logging/logging.dart';
//import 'package:meta/meta.dart';
//import 'package:dio/dio.dart';
//
//final Logger _logger = Logger("LoggingInterceptor");
//
//enum LogLevel { full, none }
//
///// Intercept/Log all requests, responses and errors from DIO.
//class LoggingInterceptor implements Interceptor {
//  final LogLevel logLevel;
//
//  LoggingInterceptor({
//    @required this.logLevel,
//  }) : assert(logLevel != null);
//
//  @override
//  onError(DioError error) {
//    if (this.logLevel == LogLevel.none) {
//      return error;
//    }
//
//    _logger.severe('<-- ${error?.response?.request?.method} '
//        '${error?.response?.request?.uri}');
//
//    _logger.severe("⚠️⚠️⚠️ Error ⚠️⚠️⚠️");
//
//    _logger.severe(
//        'Query Parameters: ${error?.response?.request?.queryParameters}');
//
//    _logger.severe('Headers: ${error?.response?.request?.headers}');
//
//    if (error?.response?.data == null) {
//      _logger.severe('Data: Response has no data');
//    } else {
//      _logger.severe('Data: ${error?.response?.data}');
//    }
//
//    _logger.severe("<-- End ${error?.response?.request?.method}");
//    return error;
//  }
//
//  @override
//  onRequest(RequestOptions options) {
//    if (this.logLevel == LogLevel.none) {
//      return options;
//    }
//
//    _logger.info('--> ${options.method} '
//        '${options.uri}');
//
//    _logger.info('Query Parameters: ${options.queryParameters}');
//
//    _logger.info('Headers: ${options.headers}');
//
//    if (options.data == null) {
//      _logger.info('Data: Request has no data');
//    } else {
//      _logger.info('Data: ${options.data}');
//    }
//
//    _logger.info("--> End ${options.method}");
//
//    return options;
//  }
//
//  @override
//  onResponse(Response response) {
//    if (this.logLevel == LogLevel.none) {
//      return response;
//    }
//
//    _logger.info('<-- ${response.request.method} '
//        '${response.request.uri}');
//
//    _logger.info('Query Parameters: ${response.request.queryParameters}');
//
//    _logger.info('Headers: ${response.request.headers}');
//
//    if (response.data == null) {
//      _logger.info('Data: Response has no data');
//    } else {
//      _logger.info('Data: ${response.data}');
//    }
//
//    _logger.info("<-- End ${response.request.method}");
//
//    return response;
//  }
//}
