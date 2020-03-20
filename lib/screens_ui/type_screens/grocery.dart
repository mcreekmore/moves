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
            leading: Icon(Icons.local_drink),
            title: Text('Water in stock:'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["grocery_update_info"]
                            ["grocery_water_percent_hour"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["grocery_update_info"]["grocery_water_percent_hour"]}% reported Yes (Last Hour)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["grocery_update_info"]
                            ["grocery_water_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["grocery_update_info"]["grocery_water_percent_day"]}% reported Yes (Last Day)')
                    : Text('No users reported in last day')
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.fastfood),
            title: Text('Perishable foods in stock:'),
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
            leading: Icon(Icons.schedule),
            title: Text('Non-perishable foods in stock:'),
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
            leading: Icon(Icons.wc),
            title: Text('Toilet paper in stock:'),
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
            leading: Icon(Icons.bubble_chart),
            title: Text('Disinfectants in stock:'),
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
            leading: Icon(Icons.pregnant_woman),
            title: Text('Feminine hygiene products in stock:'),
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
