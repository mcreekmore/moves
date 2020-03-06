import 'package:flutter/material.dart';
import 'package:moves/model/location_loaded_model.dart';
import 'package:moves/widgets/charts/bar_wait_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:convert';

class Bar extends StatefulWidget {
  Bar({this.location});

  final LocationLoadedModel location;

  @override
  _BarState createState() => _BarState();
}

class _BarState extends State<Bar> {
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');

  void createSpecialsList() {
    List<String> specialsList = widget.location.updateInfo["bar_update_info"]
                ["bar_specials_list"] !=
            null
        ? List.from(
            widget.location.updateInfo["bar_update_info"]["bar_specials_list"])
        : null;

    print(specialsList);

    var specialsTextList = List<Text>();

    for (var special in specialsList) {
      specialsTextList.add(Text(special.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    dynamic barUpdate = widget.location.updateInfo["bar_update_info"];
    createSpecialsList();

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text('Bar Info'),
            ),
          ),
          Divider(),
          //BarWaitChart(),
          ListTile(
            leading: Icon(Icons.loop),
            title: Text('Wait (Last Hour):'),
            subtitle: Text(
                '${barUpdate["bar_wait_average"]} minute wait reported (average)'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('Cover (Last 24 Hours): '),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${barUpdate["bar_cover_charge_percent"]}% reported Yes'),
                Text(
                    "${barUpdate["bar_cover_charge_average"]} USD Reported Cover Average"),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.local_bar),
            title: Text('Specials (Last 24 Hours)'),
            subtitle: Text('sup'),
            // subtitle: Column(
            //   children: specialsTextList,
            // ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.store_mall_directory),
            title: Text('Bar Style(s)'),
            subtitle: Text("College Bar, Irish Pub"),
          ),
          Divider(),
          //Card(
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: <Widget>[
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: ListTile(
          //           leading: Icon(Icons.local_bar),
          //           title: Text('Specials'),
          //           subtitle: widget.location.description != ""
          //               ? Text('${widget.location.description}')
          //               : Text('No Specials'),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Card(
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: <Widget>[
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: ListTile(
          //           leading: Icon(Icons.loop),
          //           title: Text('Wait'),
          //           subtitle: widget.location.description != ""
          //               ? Text('Currently there is a 30 min wait')
          //               : Text('Currently no wait'),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
