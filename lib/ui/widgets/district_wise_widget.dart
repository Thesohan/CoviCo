import 'package:covico/data/models/district_wise_model.dart';
import 'package:covico/ui/widgets/build_district_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DistrictWiseWidget extends StatelessWidget {
  final List<DistrictWiseModel> districtWiseData;

  const DistrictWiseWidget({Key key, this.districtWiseData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Widget> tabBarView = [];
    for (int i = 0; i < districtWiseData.length; i++) {
      tabBarView.add(BuildDistrictList(districtDataList: districtWiseData[i].districtData,));
    }
    return DefaultTabController(
      length: districtWiseData.length,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: SafeArea(
            child: TabBar(
              isScrollable: true,
              tabs: List<Widget>.generate(
                districtWiseData.length,
                (index) => Tab(
                  text: '${districtWiseData[index].state}',
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: tabBarView,
        ),
      ),
    );
  }
}
