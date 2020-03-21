import 'package:flutter/material.dart';
import 'package:moves/model/location_loaded_model.dart';
import 'dart:convert';

class GasStation extends StatefulWidget {
  GasStation({this.location});

  final LocationLoadedModel location;

  @override
  _GasStationState createState() => _GasStationState();
}

class _GasStationState extends State<GasStation> {
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
              child: Text('Gas Station Info'),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.local_gas_station),
            title: Text('Regular Gas (87) in stock'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["gas_update_info"]
                            ["gas_regular_percent_hour"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["gas_update_info"]["gas_regular_percent_hour"]}% reported Yes (Last Hour)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["gas_update_info"]
                            ["gas_regular_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["gas_update_info"]["gas_regular_percent_day"]}% reported Yes (Last Day)')
                    : Text('No users reported in last day'),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.local_gas_station),
            title: Text('Plus Gas (89) in stock'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["gas_update_info"]
                            ["gas_plus_percent_hour"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["gas_update_info"]["gas_plus_percent_hour"]}% reported Yes (Last Hour)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["gas_update_info"]
                            ["gas_plus_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["gas_update_info"]["gas_plus_percent_day"]}% reported Yes (Last Day)')
                    : Text('No users reported in last day'),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.local_gas_station),
            title: Text('Premium Gas (91) in stock'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["gas_update_info"]
                            ["gas_premium_percent_hour"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["gas_update_info"]["gas_premium_percent_hour"]}% reported Yes (Last Hour)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["gas_update_info"]
                            ["gas_premium_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["gas_update_info"]["gas_premium_percent_day"]}% reported Yes (Last Day)')
                    : Text('No users reported in last day'),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.local_gas_station),
            title: Text('Diesel in stock'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["gas_update_info"]
                            ["gas_diesel_percent_hour"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["gas_update_info"]["gas_diesel_percent_hour"]}% reported Yes (Last Hour)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["gas_update_info"]
                            ["gas_diesel_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["gas_update_info"]["gas_diesel_percent_day"]}% reported Yes (Last Day)')
                    : Text('No users reported in last day'),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.bubble_chart),
            title: Text('Air Pump'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["gas_update_info"]
                            ["gas_air_percent"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["gas_update_info"]["gas_air_percent"]}% reported Yes')
                    : Text('No users reported'),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
