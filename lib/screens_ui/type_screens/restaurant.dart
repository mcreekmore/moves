import 'package:flutter/material.dart';
import 'package:moves/model/location_loaded_model.dart';
import 'dart:convert';

class Restaurant extends StatefulWidget {
  Restaurant({this.location});

  final LocationLoadedModel location;

  @override
  _RestaurantState createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
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
              child: Text('Restaurant Info'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.restaurant),
            title: Text('Wait'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["restaurant_update_info"]
                            ["restaurant_wait_average"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["restaurant_update_info"]["restaurant_wait_average"]} minutes reported average (Last Hour)')
                    : Text('No users reported in last hour'),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.restaurant),
            title: Text('Inside seating'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["restaurant_update_info"]
                            ["restaurant_inside_seating_percent_hour"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["restaurant_update_info"]["restaurant_inside_seating_percent_hour"]}% reported Yes (Last Hour)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["restaurant_update_info"]
                            ["restaurant_inside_seating_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["restaurant_update_info"]["restaurant_inside_seating_percent_day"]}% reported Yes (Last Day)')
                    : Text('No users reported in last day'),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.restaurant),
            title: Text('Outside seating'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["restaurant_update_info"]
                            ["restaurant_outside_seating_percent_hour"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["restaurant_update_info"]["restaurant_outside_seating_percent_hour"]}% reported Yes (Last Hour)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["restaurant_update_info"]
                            ["restaurant_outside_seating_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["restaurant_update_info"]["restaurant_outside_seating_percent_day"]}% reported Yes (Last Day)')
                    : Text('No users reported in last day'),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.restaurant),
            title: Text('Take-out available'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["restaurant_update_info"]
                            ["restaurant_take_out_percent_hour"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["restaurant_update_info"]["restaurant_take_out_percent_hour"]}% reported Yes (Last Hour)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["restaurant_update_info"]
                            ["restaurant_take_out_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["restaurant_update_info"]["restaurant_take_out_percent_day"]}% reported Yes (Last Day)')
                    : Text('No users reported in last day'),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.restaurant),
            title: Text('Curb-side pickup available'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["restaurant_update_info"]
                            ["restaurant_curb_side_percent_hour"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["restaurant_update_info"]["restaurant_curb_side_percent_hour"]}% reported Yes (Last Hour)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["restaurant_update_info"]
                            ["restaurant_curb_side_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["restaurant_update_info"]["restaurant_curb_side_percent_day"]}% reported Yes (Last Day)')
                    : Text('No users reported in last day'),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
