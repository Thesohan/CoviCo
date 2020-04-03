//import 'dart:convert';
//
//import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:logging/logging.dart';
//import 'package:new_artist_project/blocs/base/base_bloc.dart';
//import 'package:new_artist_project/blocs/base/baseEvent.dart';
//import 'package:new_artist_project/blocs/loginBloc/authentication_bloc_event.dart';
//import 'package:new_artist_project/data/cache/in_memory_cache/shared_pref_handler.dart';
//import 'package:new_artist_project/data/models/api/request/login_model.dart';
//import 'package:new_artist_project/data/models/api/request/logout_request.dart';
//import 'package:new_artist_project/data/models/api/response/all_artist_info_response.dart';
//import 'package:new_artist_project/data/models/api/response/artist_profile_response.dart';
//import 'package:new_artist_project/data/models/api/response/simple_message_response.dart';
//import 'package:new_artist_project/data/models/category_model.dart';
//import 'package:new_artist_project/data/repository/loginRepository/state_data_repository.dart';
//import 'package:new_artist_project/data/resource.dart';
//import 'package:new_artist_project/util/id_name_converter.dart';
//import 'package:rxdart/rxdart.dart';
//import 'package:kiwi/kiwi.dart' as kiwi;
//import 'package:shared_preferences/shared_preferences.dart';
//
//class AuthenticationBloc extends BaseBloc<AuthenticationEvent> {
//  AuthenticationBloc({AuthenticationRepository authenticationRepository})
//      : _authenticationRepository = authenticationRepository ??
//            kiwi.Container().resolve<AuthenticationRepository>();
//
//  final Logger _logger = Logger("AuthenticationBloc");
//  final AuthenticationRepository _authenticationRepository;
//
//  BehaviorSubject<bool> _isAlreadyLoginBehaviourSubject =
//      BehaviorSubject<bool>();
//  Observable<bool> get isAlreadyLoginObservable =>
//      _isAlreadyLoginBehaviourSubject.stream;
//  @override
//  void handleEvent(AuthenticationEvent event) {
//    if (event is LoginBlocEvent) {
//      _userLogin(event);
//    } else if (event is ForgotPasswordEvent) {
//      _forgotPassword(event);
//    } else if (event is RegisterArtistEvent) {
//      _registerArtist(event);
//    } else if (event is LogoutEvent) {
//      _logoutArtist(event);
//    }
//  }
//
//  @override
//  void dispose() {
//    _isAlreadyLoginBehaviourSubject.close();
//    super.dispose();
//  }
//
//  void _userLogin(LoginBlocEvent event) async {
//
//    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
//    String token =await sharedPrefHandler.getDeviceToken();
//    LoginModel loginModel = LoginModel(
//      email: event.email,
//      password: event.password,
//      device_token: token,
//    );
//
//    Resource<AllArtistInfoResponse> res =
//    await _authenticationRepository.loginWithCredential(loginModel).last;
//    if (res.data != null) {
//      await _saveArtistProfile(res.data.data[0]);
//      event.completer.complete(res.data?.message);
//    } else {
//      event.completer.complete(res.message);
//    }
//  }
//
//  Future _saveArtistProfile(ArtistProfileResponse artistProfileResponse) async {
//    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
//    List<CategoryModel> categories = await sharedPrefHandler.getCategoryList();
//    artistProfileResponse = artistProfileResponse.copyWith(
//      is_subscribed: '0',
//      is_addedtowishlist: '0',
//      category: IdNameConverter(categoryList: categories).getCategoryNameFromId(
//        categoryId: artistProfileResponse.category,
//      ),
//    );
//    await sharedPrefHandler.setArtistBio(artistProfileResponse);
//    await sharedPrefHandler.setOAuthToken(artistProfileResponse.oauth_token);
//  }
//
//  void _forgotPassword(ForgotPasswordEvent event) async {
//    Resource<SimpleMessageResponse> res = await _authenticationRepository
//        .forgotPassword(event.forgotPasswordRequest)
//        .last;
//    if (res != null && res.data != null) {
//      event.completer.complete(res.data.success);
//    } else {
//      event.completer.complete(res.message);
//    }
//  }
//
//  void _registerArtist(RegisterArtistEvent event) async {
//    Resource<SimpleMessageResponse> res = await _authenticationRepository
//        .registerArtist(event.registerArtistRequest)
//        .last;
//    if (res != null && res.data != null) {
//      event.completer.complete(res.data.success);
//    } else {
//      event.completer.complete(res.message);
//    }
//  }
//
//  void _logoutArtist(LogoutEvent event) async {
//    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
//    ArtistProfileResponse artistProfileResponse =
//        await sharedPrefHandler.getArtistBio();
//    if (artistProfileResponse != null && artistProfileResponse.email != null) {
//      Resource<SimpleMessageResponse> res = await _authenticationRepository
//          .logoutArtist(
//            LogoutRequest(email: artistProfileResponse.email),
//          )
//          .last;
//      if (res != null && res.data != null) {
//        await sharedPrefHandler.deleteAuthToken();
//        await sharedPrefHandler.deleteArtistBio();
//        event.completer.complete(res.data.message);
//      }
//    } else {
//      event.completer.complete("Something Went Wrong!!!");
//    }
//  }
//}
