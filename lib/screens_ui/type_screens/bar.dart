import 'package:flutter/material.dart';
import 'package:moves/model/location_loaded_model.dart';
import 'dart:convert';

class Bar extends StatefulWidget {
  Bar({this.location});

  final LocationLoadedModel location;

  @override
  _BarState createState() => _BarState();
}

class _BarState extends State<Bar> {
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
            title: Text('Wait'),
            subtitle: barUpdate["bar_wait_average"] != null
                ? Text(
                    '${barUpdate["bar_wait_average"]} minute wait reported (average)')
                : Text('No reported wait times (Last Hour)'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('Cover'),
            subtitle: barUpdate["bar_cover_charge_percent"] != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          '${barUpdate["bar_cover_charge_percent"]}% reported Yes (Last 24 Hours)'),
                      Text(
                          "${barUpdate["bar_cover_charge_average"]} USD Reported Cover Average"),
                    ],
                  )
                : Text('No reports (Last Day)'),
          ),
          // Divider(),
          // ListTile(
          //   leading: Icon(Icons.local_bar),
          //   title: Text('Specials (Last 24 Hours)'),
          //   subtitle: Text('sup'),
          // ),
          Divider(),
          ListTile(
            leading: Icon(Icons.store_mall_directory),
            title: Text('Bar Styles'),
            subtitle: Text("College Bar, Irish Pub"),
          ),
          Divider(),
        ],
      ),
    );
  }
}
