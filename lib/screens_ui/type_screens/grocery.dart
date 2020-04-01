import 'package:flutter/material.dart';
import 'package:moves/model/location_loaded_model.dart';
import 'dart:convert';

class Grocery extends StatefulWidget {
  Grocery({this.location});

  final LocationLoadedModel location;

  @override
  _GroceryState createState() => _GroceryState();
}

class _GroceryState extends State<Grocery> {
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text('Grocery Info'),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.local_drink,
              color: Colors.blueAccent,
            ),
            title: Text('Water in stock'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["grocery_update_info"]
                            ["grocery_water_percent_hour"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["grocery_update_info"]["grocery_water_percent_hour"]}% reported Yes (Last Hour)')
                    : Text('No users reported in last hour'),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 4.0),
                //   child: Row(
                //     children: <Widget>[
                //       Flexible(
                //         flex: widget.location.updateInfo["grocery_update_info"]
                //             ["grocery_water_percent_hour"],
                //         child: Container(
                //           height: 6,
                //           //width: double.infinity,
                //           color: Colors.greenAccent,
                //         ),
                //       ),
                //       Flexible(
                //         flex: 100 -
                //             widget.location.updateInfo["grocery_update_info"]
                //                 ["grocery_water_percent_hour"],
                //         child: Container(
                //           height: 6,
                //           color: Colors.redAccent,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                widget.location.updateInfo["grocery_update_info"]
                            ["grocery_water_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["grocery_update_info"]["grocery_water_percent_day"]}% reported Yes (Last Day)')
                    : Text('No users reported in last day'),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 4.0),
                //   child: Row(
                //     children: <Widget>[
                //       Flexible(
                //         flex: widget.location.updateInfo["grocery_update_info"]
                //             ["grocery_water_percent_day"],
                //         child: Container(
                //           height: 6,
                //           //width: double.infinity,
                //           color: Colors.greenAccent,
                //         ),
                //       ),
                //       Flexible(
                //         flex: 100 -
                //             widget.location.updateInfo["grocery_update_info"]
                //                 ["grocery_water_percent_day"],
                //         child: Container(
                //           height: 6,
                //           color: Colors.redAccent,
                //         ),
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.fastfood,
              color: Colors.amber,
            ),
            title: Text('Perishable foods in stock'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["grocery_update_info"]
                            ["grocery_perishable_percent_hour"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["grocery_update_info"]["grocery_perishable_percent_hour"]}% reported Yes (Last Hour)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["grocery_update_info"]
                            ["grocery_perishable_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["grocery_update_info"]["grocery_perishable_percent_day"]}% reported Yes (Last Day)')
                    : Text('No users reported in last day')
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.schedule,
              color: Colors.blueGrey,
            ),
            title: Text('Non-perishable foods in stock'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["grocery_update_info"]
                            ["grocery_non_perishable_percent_hour"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["grocery_update_info"]["grocery_non_perishable_percent_hour"]}% reported Yes (Last Hour)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["grocery_update_info"]
                            ["grocery_non_perishable_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["grocery_update_info"]["grocery_non_perishable_percent_day"]}% reported Yes (Last Day)')
                    : Text('No users reported in last day')
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.wc,
              color: Colors.deepOrangeAccent,
            ),
            title: Text('Toilet paper in stock'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["grocery_update_info"]
                            ["grocery_toilet_paper_percent_hour"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["grocery_update_info"]["grocery_toilet_paper_percent_hour"]}% reported Yes (Last Hour)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["grocery_update_info"]
                            ["grocery_toilet_paper_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["grocery_update_info"]["grocery_toilet_paper_percent_day"]}% reported Yes (Last Day)')
                    : Text('No users reported in last day')
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.bubble_chart,
              color: Colors.tealAccent,
            ),
            title: Text('Disinfectants in stock'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["grocery_update_info"]
                            ["grocery_disinfectants_percent_hour"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["grocery_update_info"]["grocery_disinfectants_percent_hour"]}% reported Yes (Last Hour)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["grocery_update_info"]
                            ["grocery_disinfectants_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["grocery_update_info"]["grocery_disinfectants_percent_day"]}% reported Yes (Last Day)')
                    : Text('No users reported in last day')
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.pregnant_woman,
              color: Colors.pinkAccent,
            ),
            title: Text('Feminine hygiene products in stock'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["grocery_update_info"]
                            ["grocery_feminine_percent_hour"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["grocery_update_info"]["grocery_feminine_percent_hour"]}% reported Yes (Last Hour)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["grocery_update_info"]
                            ["grocery_feminine_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["grocery_update_info"]["grocery_feminine_percent_day"]}% reported Yes (Last Day)')
                    : Text('No users reported in last day')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
