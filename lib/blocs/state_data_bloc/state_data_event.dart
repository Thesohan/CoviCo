import 'package:covico/blocs/base/baseEvent.dart';
import 'package:covico/data/models/state_model.dart';
import 'package:flutter/cupertino.dart';

class StateDataEvent extends BaseEvent {}

class GetSeriesDataEvent extends BaseEvent {
  final List<CasesTimeSeries> casesTimeSeries;

  GetSeriesDataEvent({@required this.casesTimeSeries})
      : assert(casesTimeSeries != null);
}
