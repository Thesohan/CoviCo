import 'package:covico/data/models/district_wise_model.dart';
import 'package:covico/data/models/state_model.dart';

abstract class StatewiseDao {
  /// Get statewise data;
  ///
  Future<StateModel> getStateModel();
  void setStateModel(StateModel stateModel);

  Future<List<DistrictWiseModel>> getDistrictWiseModel();
  void setDistrictWiseModel(List<DistrictWiseModel> districtWiseModelList);
}
