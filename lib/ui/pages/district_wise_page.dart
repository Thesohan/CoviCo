import 'package:covico/data/models/district_wise_model.dart';
import 'package:covico/ui/widgets/build_district_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DistrictWisePage extends StatelessWidget {
  final DistrictWiseModel districtWiseModel;
  final String confirmed;

  const DistrictWisePage({Key key, this.districtWiseModel, this.confirmed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '${districtWiseModel.state}',
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              'Confirmed: $confirmed',
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Colors.red),
            ),
          ],
        ),
      ),
      body: SafeArea(child: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BuildDistrictList(
      districtDataList: districtWiseModel.districtData,
    );
  }
}
