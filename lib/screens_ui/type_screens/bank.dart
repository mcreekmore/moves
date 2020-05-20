import 'package:flutter/material.dart';
import 'package:moves/model/location_loaded_model.dart';
import 'dart:convert';

class Bank extends StatefulWidget {
  Bank({this.location});

  final LocationLoadedModel location;

  @override
  _BankState createState() => _BankState();
}

class _BankState extends State<Bank> {
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
              child: Text('Bank Info'),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.drive_eta,
              color: Colors.blueAccent,
            ),
            title: Text('Drive-through available?'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["bank_update_info"]
                            ["bank_drive_through_percent_hour"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["bank_update_info"]["bank_drive_through_percent_hour"]}% reported Yes (Last Hour)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["bank_update_info"]
                            ["bank_drive_through_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["bank_update_info"]["bank_drive_through_percent_day"]}% reported Yes (Last Day)')
                    : Text('No users reported in last day'),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.attach_money,
              color: Colors.green,
            ),
            title: Text('ATM available?'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["bank_update_info"]
                            ["bank_atm_percent_hour"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["bank_update_info"]["bank_atm_percent_hour"]}% reported Yes (Last Hour)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["bank_update_info"]
                            ["bank_atm_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["bank_update_info"]["bank_atm_percent_day"]}% reported Yes (Last Day)')
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
