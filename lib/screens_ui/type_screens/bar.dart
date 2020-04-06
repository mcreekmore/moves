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

  List<Widget> _getBarStyles() {
    List<Widget> stylesList = List();
    List<dynamic> stylesJSON = List.from(
        widget.location.updateInfo["bar_update_info"]["bar_styles_list"]);

    stylesJSON.sort((a, b) => b["percent"].compareTo(a["percent"]));

    //TODO finish bar styles

    for (var styleType in stylesJSON) {
      if (double.parse(styleType["percent"]) != 0.0) {
        styleType["percent"] = (double.parse(styleType["percent"])).toString();
        stylesList.add(
          Text(
            '${styleType["percent"]}%: ${styleType["style"]}',
          ),
        );
      }
    }
    return stylesList;
  }

  List<Widget> _createSpecialsList() {
    List<String> specialsList = widget.location.updateInfo["bar_update_info"]
                ["bar_specials_list"] !=
            null
        ? List.from(
            widget.location.updateInfo["bar_update_info"]["bar_specials_list"])
        : null;

    var specialsTextList = List<Widget>();

    for (var special in specialsList) {
      specialsTextList.add(Text(special.toString()));
    }

    return specialsTextList;
  }

  @override
  Widget build(BuildContext context) {
    dynamic barUpdate = widget.location.updateInfo["bar_update_info"];
    //createSpecialsList();

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
            leading: Icon(
              Icons.loop,
              color: Colors.blue,
            ),
            title: Text('Wait'),
            subtitle: barUpdate["bar_wait_average"] != null
                ? Text(
                    '${barUpdate["bar_wait_average"]} minute wait reported (average)')
                : Text('No reported wait times (Last Hour)'),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.attach_money,
              color: Colors.green,
            ),
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
            leading: Icon(
              Icons.store_mall_directory,
              color: Colors.deepPurpleAccent,
            ),
            title: Text('Specials'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _createSpecialsList(),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.store_mall_directory,
              color: Colors.deepPurpleAccent,
            ),
            title: Text('Bar Styles'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _getBarStyles(),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
