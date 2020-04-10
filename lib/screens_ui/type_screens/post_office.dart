import 'package:flutter/material.dart';
import 'package:moves/model/location_loaded_model.dart';
import 'dart:convert';

class PostOffice extends StatefulWidget {
  PostOffice({this.location});

  final LocationLoadedModel location;

  @override
  _PostOfficeState createState() => _PostOfficeState();
}

class _PostOfficeState extends State<PostOffice> {
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
              child: Text('Post Office Info'),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.local_post_office,
              color: Colors.blueAccent,
            ),
            title: Text('Accepting parcels inside'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["post_update_info"]
                            ["post_parcel_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["post_update_info"]["post_parcel_percent_day"]}% reported Yes (Last Hour)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["post_update_info"]
                            ["post_parcel_percent"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["post_update_info"]["post_parcel_percent"]}% reported Yes (Last Day)')
                    : Text('No users reported in last day'),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.arrow_downward,
              color: Colors.redAccent,
            ),
            title: Text('Outside parcel drop-off'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["post_update_info"]
                            ["post_outside_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["post_update_info"]["post_outside_percent_day"]}% reported Yes (Last Hour)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["post_update_info"]
                            ["post_outside_percent"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["post_update_info"]["post_outside_percent"]}% reported Yes (Last Day)')
                    : Text('No users reported in last day'),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.crop_square,
              color: Colors.purpleAccent,
            ),
            title: Text('PO boxes available'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["post_update_info"]
                            ["post_po_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["post_update_info"]["post_po_percent_day"]}% reported Yes (Last Hour)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["post_update_info"]
                            ["post_po_percent"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["post_update_info"]["post_po_percent"]}% reported Yes (Last Day)')
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
