//import 'package:dio/dio.dart';
//
//class TokenInterceptor implements Interceptor {
//  String _token;
//
//  TokenInterceptor(String token) {
//    _token = token;
//  }
//
//  void updateToken(String token) {
//    this._token = token;
//  }
//
//  @override
//  onError(DioError err) {
//    return err;
//  }
//
//  @override
//  onRequest(RequestOptions options) {
//    if (_token != null) {
//      options.headers["authorization"] = "Bearer $_token";
//    }
//    return options;
//  }
//
//  @override
//  onResponse(Response response) {
//    return response;
//  }
//}
