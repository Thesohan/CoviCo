import 'package:covico/constants/appColors.dart';
import 'package:covico/constants/spaces.dart';
import 'package:covico/data/models/state_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StateWiseWidget extends StatefulWidget {
  final List<Statewise> statewise;

  const StateWiseWidget({Key key, this.statewise})
      : assert(statewise != null),
        super(key: key);

  @override
  _StateWiseWidgetState createState() {
    return _StateWiseWidgetState();
  }
}

class _StateWiseWidgetState extends State<StateWiseWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Table(children: [
            TableRow(children: [
              Text(
                'Active',
                style: Theme.of(context).textTheme.caption,
              ),
              Text('Confirmed', style: Theme.of(context).textTheme.caption),
              Text(
                'Recovered',
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                'Deaths',
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                'State',
                style: Theme.of(context).textTheme.caption,
              ),
            ])
          ]),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.statewise.length,
            itemBuilder: (context, index) {
              return _buildStatewiseItem(
                statewise: widget.statewise[index],
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

class _buildStatewiseItem extends StatelessWidget {
  final Statewise statewise;

  const _buildStatewiseItem({Key key, this.statewise})
      : assert(statewise != null),
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
                Text(
                  '${statewise.active}',
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ),
                Text('${statewise.confirmed}'),
                Text('${statewise.recovered}'),
                Text(
                  '${statewise.deaths}',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                Text(
                  '${statewise.state}',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
