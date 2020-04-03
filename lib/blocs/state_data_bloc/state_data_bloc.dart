import 'package:covico/blocs/base/base_bloc.dart';
import 'package:covico/blocs/state_data_bloc/state_data_event.dart';
import 'package:covico/data/models/state_model.dart';
import 'package:covico/data/repository/state_data_repository/state_data_repository.dart';
import 'package:covico/data/resource.dart';

import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:rxdart/rxdart.dart';

class StateDataBloc extends BaseBloc<StateDataEvent> {
  StateDataBloc({StateDataRepository stateDataRepository})
      : _stateDataRepository = stateDataRepository ??
            kiwi.Container().resolve<StateDataRepository>();
  final StateDataRepository _stateDataRepository;

  BehaviorSubject<Resource<StateModel>> _stateModelBehaviorSubject = BehaviorSubject<Resource<StateModel>>();
  Observable<Resource<StateModel>> get stateDataObservable => _stateModelBehaviorSubject.stream;

  @override
  void handleEvent(StateDataEvent event) {
    if (event is StateDataEvent) {
      _fetchStateData();
    }
  }

  void _fetchStateData() async{
   Resource<StateModel> res = await _stateDataRepository.fetchStateData().last;
   if(res!=null && res.data!=null){
     List<CasesTimeSeries> cases = res?.data?.casesTimeSeries?.reversed?.toList();
     List<Statewise> states = res.data.statewise;
     Statewise temp = states[0];
     states.removeAt(0);
     states.add(temp);
     res = res.copyWithNewData(data: StateModel(casesTimeSeries: cases,statewise: states,keyValues: res.data.keyValues,tested: res.data.tested));
     _stateModelBehaviorSubject.add(res);
   }
  }

  @override
  void dispose() {
    _stateModelBehaviorSubject.close();
    super.dispose();
  }
}
