import 'package:covico/blocs/state_data_bloc/state_data_bloc.dart';
import 'package:covico/blocs/state_data_bloc/state_data_event.dart';
import 'package:covico/data/models/state_model.dart';
import 'package:covico/data/models/time_count_model.dart';
import 'package:covico/data/resource.dart';
import 'package:covico/ui/widgets/cases_time_series.dart';
import 'package:covico/ui/widgets/chart_widget.dart';
import 'package:covico/ui/widgets/primary_error_widget.dart';
import 'package:covico/ui/widgets/statewise_widget.dart';
import 'package:covico/ui/widgets/stream_task_builder.dart';
import 'package:covico/ui/widgets/theme_inherited_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  StateDataBloc stateDataBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    stateDataBloc = Provider.of<StateDataBloc>(context);
    stateDataBloc.dispatch(StateDataEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CoviCo"),
        actions: <Widget>[
          IconButton(
            icon: ThemeSwitcher.of(context).isDarkModeOn
                ? Icon(Icons.wb_sunny)
                : Icon(
                    Icons.brightness_3,
                    color: Colors.grey,
                  ),
            onPressed: (){
              _selectedIndex=0;
              ThemeSwitcher.of(context).switchDarkMode();
            }
          ),
        ],
      ),
      body: _buildDailyTimeSeries(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildDailyTimeSeries() {
    return StreamTaskBuilder(
      stream: stateDataBloc.stateDataObservable,
      successBuilder: (BuildContext context, StateModel data,
          Resource<StateModel> resource) {
        List<CasesTimeSeries> cases = data.casesTimeSeries;
        List<Statewise> statewise = data.statewise;
        if (_selectedIndex == 0) {
          return CasesTimeSeriesWidget(
            casesTimeSeries: cases,
          );
        }
        if (_selectedIndex == 1) {
          return StateWiseWidget(
            statewise: statewise,
          );
        }
        if (_selectedIndex == 2) {
          return StreamBuilder<List<charts.Series<TimeCountModel, DateTime>>>(
              stream: stateDataBloc.chartSeriesDataObservable,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!=null) {
                  return ChartWidget(series: snapshot.data);
                } else {
                  return SpinKitChasingDots(
                    color: Theme.of(context).accentColor,
                  );
                }
              });
        }
        return Container();
      },
      loadingBuilder:
          (BuildContext context, StateModel data, Resource resource) =>
              SpinKitChasingDots(
        color: Theme.of(context).accentColor,
      ),
      failureBuilder:
          (BuildContext context, StateModel data, Resource resource) {
        return PrimaryErrorWidget.networkErrorOrNot(
          context: context,
          isNetworkError: resource.isNetworkError,
          message: 'Something went wrong.',
          onRetry: () {
            stateDataBloc.dispatch(StateDataEvent());
          },
        );
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.dialpad),
          title: Text("CasesTimeSeries"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          title: Text('State Data'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.show_chart),
          title: Text('Chart'),
        )
      ],
      currentIndex: _selectedIndex,
      onTap: (index) {
        if (_selectedIndex != index) {
          print('selectedindex$_selectedIndex');

          setState(() {
            _selectedIndex = index;
          });
        }
      },
      selectedItemColor: Theme.of(context).accentColor,
    );
  }
}
