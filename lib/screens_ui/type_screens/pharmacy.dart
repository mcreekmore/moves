import 'package:flutter/material.dart';
import 'package:moves/model/location_loaded_model.dart';
import 'dart:convert';

class Pharmacy extends StatefulWidget {
  Pharmacy({this.location});

  final LocationLoadedModel location;

  @override
  _PharmacyState createState() => _PharmacyState();
}

class _PharmacyState extends State<Pharmacy> {
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
              child: Text('Pharmacy Info'),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.local_pharmacy,
              color: Colors.redAccent,
            ),
            title: Text('Filling Perscriptions'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["pharmacy_update_info"]
                            ["pharmacy_prescription_fill_percent_hour"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["pharmacy_update_info"]["pharmacy_prescription_fill_percent_hour"]}% reported Yes (Last Hour)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["pharmacy_update_info"]
                            ["pharmacy_prescription_fill_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["pharmacy_update_info"]["pharmacy_prescription_fill_percent_day"]}% reported Yes (Last Day)')
                    : Text('No users reported in last day'),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.arrow_downward,
              color: Colors.deepPurpleAccent,
            ),
            title: Text('Administering vaccinations'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["pharmacy_update_info"]
                            ["pharmacy_vaccinations_percent_hour"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["pharmacy_update_info"]["pharmacy_vaccinations_percent_hour"]}% reported Yes (Last Hour)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["pharmacy_update_info"]
                            ["pharmacy_vaccinations_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["pharmacy_update_info"]["pharmacy_vaccinations_percent_day"]}% reported Yes (Last Day)')
                    : Text('No users reported in last day'),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.people,
              color: Colors.blueGrey,
            ),
            title: Text('Providing pharmaceutical counseling'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["pharmacy_update_info"]
                            ["pharmacy_counseling_percent_hour"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["pharmacy_update_info"]["pharmacy_counseling_percent_hour"]}% reported Yes (Last Hour)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["pharmacy_update_info"]
                            ["pharmacy_counseling_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["pharmacy_update_info"]["pharmacy_counseling_percent_day"]}% reported Yes (Last Day)')
                    : Text('No users reported in last day'),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.drive_eta,
              color: Colors.blueAccent,
            ),
            title: Text('Drive-through pharmacy pick-up'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["pharmacy_update_info"]
                            ["pharmacy_drive_through_percent"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["pharmacy_update_info"]["pharmacy_drive_through_percent"]}% reported Yes (All Time)')
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
