//import 'dart:async';
//import 'dart:math';
//
//import 'package:flutter/cupertino.dart';
//import 'package:new_artist_project/blocs/base/baseEvent.dart';
//import 'package:new_artist_project/data/models/api/request/forgot_password_request.dart';
//import 'package:new_artist_project/data/models/api/request/logout_request.dart';
//import 'package:new_artist_project/data/models/api/request/register_artist_request.dart';
//
//class AuthenticationEvent extends BaseEvent {}
//
//class LoginBlocEvent extends AuthenticationEvent {
//  final String email;
//  final String password;
//  final Completer completer;
//
//  LoginBlocEvent(
//      {@required this.email, @required this.password, @required this.completer})
//      : assert(
//          email != null && password != null && completer != null,
//        );
//
//  @override
//  String toString() {
//    return "LoginBlocEvent {email:$email,password:$password";
//  }
//}
//
//class ForgotPasswordEvent extends AuthenticationEvent {
//  final ForgotPasswordRequest forgotPasswordRequest;
//  final Completer completer;
//
//  ForgotPasswordEvent({
//    @required this.forgotPasswordRequest,
//    @required this.completer,
//  });
//
//  @override
//  String toString() {
//    return 'ForgotPasswordEvent{email:${forgotPasswordRequest.email},completer:$completer}';
//  }
//}
//
//
//class RegisterArtistEvent extends AuthenticationEvent {
//  final RegisterArtistRequest registerArtistRequest;
//  final Completer completer;
//
//  RegisterArtistEvent({
//    @required this.registerArtistRequest,
//    @required this.completer,
//  });
//
//  @override
//  String toString() {
//    return 'RegisterArtistEvent{registerArtistRequest:${registerArtistRequest.toString()},completer:$completer}';
//  }
//}
//
//class LogoutEvent extends AuthenticationEvent {
//  final Completer completer;
//
//  LogoutEvent({this.completer}):assert( completer!=null);
//
//  @override
//  String toString() {
//    return 'LogoutEvent{completer:$completer}';
//  }
//}
//
