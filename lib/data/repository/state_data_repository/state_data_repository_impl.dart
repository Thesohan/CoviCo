
import 'package:covico/data/models/state_model.dart';
import 'package:covico/data/network/network_service.dart';
import 'package:covico/data/repository/state_data_repository/state_data_repository.dart';
import 'package:covico/data/resource.dart';

class StateDataRepositoryImpl extends StateDataRepository {
  final NetworkService networkService;

  StateDataRepositoryImpl(this.networkService):assert(networkService!=null);

  @override
  Stream<Resource<StateModel>> fetchStateData() async*{
    yield Resource.loading();
    yield await networkService.stateDataApi.fetchStateData();
  }
//
//  LoginRepositoryImpl({@required this.networkService})
//      : assert(networkService != null);
//
//  @override
//  Stream<Resource<AllArtistInfoResponse>> loginWithCredential(
//      LoginModel credential) async* {
//    assert(credential != null);
//    yield Resource.loading();
//    yield await networkService.loginApi.userLogin(credential: credential);
//  }

}
