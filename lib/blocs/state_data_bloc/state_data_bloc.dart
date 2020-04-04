import 'package:covico/blocs/base/baseEvent.dart';
import 'package:covico/blocs/base/base_bloc.dart';
import 'package:covico/blocs/state_data_bloc/state_data_event.dart';
import 'package:covico/data/models/state_model.dart';
import 'package:covico/data/models/time_count_model.dart';
import 'package:covico/data/repository/state_data_repository/state_data_repository.dart';
import 'package:covico/data/resource.dart';

import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:rxdart/rxdart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StateDataBloc extends BaseBloc<BaseEvent> {
  StateDataBloc({StateDataRepository stateDataRepository})
      : _stateDataRepository = stateDataRepository ??
            kiwi.Container().resolve<StateDataRepository>();
  final StateDataRepository _stateDataRepository;

  BehaviorSubject<List<charts.Series<TimeCountModel, DateTime>>>
      _chartSeriesBehaviorSubject =
      BehaviorSubject<List<charts.Series<TimeCountModel, DateTime>>>();
  Observable<List<charts.Series<TimeCountModel, DateTime>>>
      get chartSeriesDataObservable => _chartSeriesBehaviorSubject.stream;

  BehaviorSubject<Resource<StateModel>> _stateModelBehaviorSubject =
      BehaviorSubject<Resource<StateModel>>();
  Observable<Resource<StateModel>> get stateDataObservable =>
      _stateModelBehaviorSubject.stream;

  @override
  void handleEvent(BaseEvent event) {
    if (event is StateDataEvent) {
      _fetchStateData();
    } else if (event is GetSeriesDataEvent) {
      _getChartSeries(event.casesTimeSeries);
    }
  }

  void _fetchStateData() async {
    /// Always listen to the stream. Using stream.first || stream.last will give you only single result.
    _stateDataRepository.fetchStateData().listen((Resource<StateModel> res) {
      if (res.data != null) {
        List<CasesTimeSeries> cases =
            res?.data?.casesTimeSeries?.reversed?.toList();
        List<Statewise> states = res.data.statewise;
        Statewise temp = states[0];
        states.removeAt(0);
        states.add(temp);
        res = res.copyWithNewData(
            data: StateModel(
                casesTimeSeries: cases,
                statewise: states,
                keyValues: res.data.keyValues,
                tested: res.data.tested));
        dispatch(
          GetSeriesDataEvent(casesTimeSeries: cases),
        );
      }
      _stateModelBehaviorSubject.add(res);
    });
  }

  @override
  void dispose() {
    _stateModelBehaviorSubject.close();
    _chartSeriesBehaviorSubject.close();
    super.dispose();
  }

  void _getChartSeries(List<CasesTimeSeries> cases) {
    final List<TimeCountModel> dailyConfirmedCases = [];
    final List<TimeCountModel> dailyDeceasedCases = [];
    final List<TimeCountModel> dailyRecovered = [];
    Map<String, String> monthMap = {
      'January': '1',
      'February': '2',
      'March': '3',
      'April': '4',
      'May': '5',
      'June': '6',
      'July': '7',
      'August': '8',
      'September': '9',
      'October': '10',
      'November': '11',
      'December': '12',
    };
    cases?.forEach((CasesTimeSeries element) {
      List<String> date = element.date.split(' ');
      if (date.length > 1) {
        String month = monthMap['${date[1]}'];
        String day = date[0];
        dailyConfirmedCases.add(
          TimeCountModel(
            DateTime(2020, int.parse(month), int.parse(day)),
            int.parse(
              element.dailyconfirmed,
            ),
          ),
        );
        dailyDeceasedCases.add(
          TimeCountModel(
            DateTime(2020, int.parse(month), int.parse(day)),
            int.parse(
              element.dailydeceased,
            ),
          ),
        );
        dailyRecovered.add(
          TimeCountModel(
            DateTime(2020, int.parse(month), int.parse(day)),
            int.parse(
              element.dailyrecovered,
            ),
          ),
        );
      }
    });
    List<charts.Series<TimeCountModel, DateTime>> charSeriesList = [
      new charts.Series<TimeCountModel, DateTime>(
        id: 'Daily Confirmed',
        displayName: 'Daily Confirmed',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeCountModel sales, _) => sales.time,
        measureFn: (TimeCountModel sales, _) => sales.count,
        data: dailyConfirmedCases,
      ),
      new charts.Series<TimeCountModel, DateTime>(
        id: 'Daily Deceased',
        displayName: 'Daily Deceased',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TimeCountModel sales, _) => sales.time,
        measureFn: (TimeCountModel sales, _) => sales.count,
        data: dailyDeceasedCases,
      ),
      new charts.Series<TimeCountModel, DateTime>(
        id: 'Daily Recovered',
        displayName: 'Daily Recovered',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (TimeCountModel sales, _) => sales.time,
        measureFn: (TimeCountModel sales, _) => sales.count,
        data: dailyRecovered,
      ),
    ];

    _chartSeriesBehaviorSubject.add(charSeriesList);
  }
}
