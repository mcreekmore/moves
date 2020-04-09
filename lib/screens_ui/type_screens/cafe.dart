import 'package:flutter/material.dart';
import 'package:moves/model/location_loaded_model.dart';
import 'dart:convert';

class Cafe extends StatefulWidget {
  Cafe({this.location});

  final LocationLoadedModel location;

  @override
  _CafeState createState() => _CafeState();
}

class _CafeState extends State<Cafe> {
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
              child: Text('Cafe Info'),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.local_cafe,
              color: Colors.lightGreen,
            ),
            title: Text('Tea available'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["cafe_update_info"]
                            ["cafe_tea_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["cafe_update_info"]["cafe_tea_percent_day"]}% reported Yes (Last Day)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["cafe_update_info"]
                            ["cafe_tea_percent"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["cafe_update_info"]["cafe_tea_percent"]}% reported Yes (All Time)')
                    : Text('No users reported ever'),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.local_cafe,
              color: Colors.brown,
            ),
            title: Text('Coffee available'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["cafe_update_info"]
                            ["cafe_coffee_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["cafe_update_info"]["cafe_coffee_percent_day"]}% reported Yes (Last Day)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["cafe_update_info"]
                            ["cafe_coffee_percent"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["cafe_update_info"]["cafe_coffee_percent"]}% reported Yes (All Time)')
                    : Text('No users reported ever'),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.local_drink,
              color: Colors.blueAccent,
            ),
            title: Text('Uncaffeinated bevrages available'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["cafe_update_info"]
                            ["cafe_uncaffeinated_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["cafe_update_info"]["cafe_uncaffeinated_percent_day"]}% reported Yes (Last Day)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["cafe_update_info"]
                            ["cafe_uncaffeinated_percent"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["cafe_update_info"]["cafe_uncaffeinated_percent"]}% reported Yes (All Time)')
                    : Text('No users reported ever'),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.restaurant,
              color: Colors.redAccent,
            ),
            title: Text('Breakfast items sold'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["cafe_update_info"]
                            ["cafe_breakfast_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["cafe_update_info"]["cafe_breakfast_percent_day"]}% reported Yes (Last Day)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["cafe_update_info"]
                            ["cafe_breakfast_percent"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["cafe_update_info"]["cafe_breakfast_percent"]}% reported Yes (All Time)')
                    : Text('No users reported ever'),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.restaurant, color: Colors.amber),
            title: Text('Lunch items sold'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["cafe_update_info"]
                            ["cafe_lunch_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["cafe_update_info"]["cafe_lunch_percent_day"]}% reported Yes (Last Day)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["cafe_update_info"]
                            ["cafe_lunch_percent"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["cafe_update_info"]["cafe_lunch_percent"]}% reported Yes (All Time)')
                    : Text('No users reported ever'),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.place,
              color: Colors.green,
            ),
            title: Text('Inside seating available / open'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["cafe_update_info"]
                            ["cafe_inside_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["cafe_update_info"]["cafe_inside_percent_day"]}% reported Yes (Last Day)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["cafe_update_info"]
                            ["cafe_inside_percent"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["cafe_update_info"]["cafe_inside_percent"]}% reported Yes (All Time)')
                    : Text('No users reported ever'),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.flag,
              color: Colors.deepPurpleAccent,
            ),
            title: Text('Outside seating available / open'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["cafe_update_info"]
                            ["cafe_outside_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["cafe_update_info"]["cafe_outside_percent_day"]}% reported Yes (Last Day)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["cafe_update_info"]
                            ["cafe_outside_percent"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["cafe_update_info"]["cafe_outside_percent"]}% reported Yes (All Time)')
                    : Text('No users reported ever'),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.drive_eta,
              color: Colors.blueAccent,
            ),
            title: Text('Drive through available'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["cafe_update_info"]
                            ["cafe_drive_through_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["cafe_update_info"]["cafe_drive_through_percent_day"]}% reported Yes (Last Day)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["cafe_update_info"]
                            ["cafe_drive_through_percent"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["cafe_update_info"]["cafe_drive_through_percent"]}% reported Yes (All Time)')
                    : Text('No users reported ever'),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.web,
              color: Colors.deepOrangeAccent,
            ),
            title: Text('Online ordering supported'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["cafe_update_info"]
                            ["cafe_online_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["cafe_update_info"]["cafe_online_percent_day"]}% reported Yes (Last Day)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["cafe_update_info"]
                            ["cafe_online_percent"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["cafe_update_info"]["cafe_online_percent"]}% reported Yes (All Time)')
                    : Text('No users reported ever'),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
