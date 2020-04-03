import 'package:covico/constants/appColors.dart';
import 'package:covico/constants/spaces.dart';
import 'package:covico/data/models/state_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CasesTimeSeriesWidget extends StatefulWidget{
  final List<CasesTimeSeries> casesTimeSeries;
  const CasesTimeSeriesWidget({Key key, this.casesTimeSeries})
      : assert(casesTimeSeries != null),
        super(key: key);

  @override
  _CasesTimeSeriesWidgetState createState() {
    return _CasesTimeSeriesWidgetState();
  }
}

class _CasesTimeSeriesWidgetState extends State<CasesTimeSeriesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Table(children: [
            TableRow(children: [
              Text(
                'Daily Confirmed',
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                'Daily Deceased',
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                'Total Confirmed',
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                'Total Recovered',
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                'Date',
                style: Theme.of(context).textTheme.caption,
              ),
            ])
          ]),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.casesTimeSeries.length,
            itemBuilder: (context, index) {
              return _buildCasesTimeSeriesItem(
                casesTimeSeries: widget.casesTimeSeries[index],
              );
            },
            primary: true,
            shrinkWrap: true,
          ),
        ),
      ],
    );
  }
}

class _buildCasesTimeSeriesItem extends StatelessWidget {
  final CasesTimeSeries casesTimeSeries;

  const _buildCasesTimeSeriesItem({Key key, this.casesTimeSeries})
      : assert(casesTimeSeries != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Table(
          children: [
            TableRow(
              children: <Widget>[
                Text('${casesTimeSeries.dailyconfirmed}'),
                Text(
                  '${casesTimeSeries.dailydeceased}',
                  style: TextStyle(
                      color: AppColors.red, fontWeight: FontWeight.bold),
                ),
                Text('${casesTimeSeries.totalconfirmed}'),
                Text(
                  '${casesTimeSeries.totalrecovered}',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
                Text('${casesTimeSeries.date}',style: Theme.of(context).textTheme.caption,),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoulmn(
      BuildContext context, String title, String subtitle, Icon icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              icon,
              Spaces.h8,
              Text(
                '$subtitle',
                style: Theme.of(context).textTheme.headline4,
              ),
              Spaces.h8,
              Text(
                "$title",
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
