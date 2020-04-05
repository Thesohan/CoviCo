import 'package:covico/data/models/district_wise_model.dart';
import 'package:covico/data/models/state_model.dart';
import 'package:covico/data/network/network_service.dart';
import 'package:covico/data/repository/state_data_repository/state_data_repository.dart';
import 'package:covico/data/resource.dart';

class StateDataRepositoryImpl extends StateDataRepository {
  final NetworkService networkService;

  StateDataRepositoryImpl(this.networkService) : assert(networkService != null);

  @override
  Stream<Resource<StateModel>> fetchStateData() async* {
    yield Resource.loading();
    yield await networkService.stateDataApi.fetchStateData();
  }

  @override
  Stream<Resource<List<DistrictWiseModel>>> fetchDistrictData() async*{
    yield Resource.loading();
    yield await networkService.stateDataApi.fetchDistrictData();
  }
}
