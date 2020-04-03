//import 'package:dio/dio.dart';
//import 'package:new_artist_project/data/resource.dart';
//
///// Handle all cases of [DioError].
//Resource<T> handleDioError<T>(DioError error) {
//  switch (error.type) {
//    case DioErrorType.CONNECT_TIMEOUT:
//      {
//        return Resource.failure(
//          message: "Network problem. Something went wrong.",
//        );
//      }
//    case DioErrorType.DEFAULT:
//      {
//        return Resource.failure(
//          message:
//              "No internet connection. Make sure wi-fi or cellular data is turned on then try again",
//          isNetworkError: true,
//        );
//      }
//    case DioErrorType.RESPONSE:
//      {
//        return Resource.failure(message: error.response.data['message']);
//      }
//    default:
//      {
//        return Resource.failure(message: error.toString());
//      }
//  }
//}
