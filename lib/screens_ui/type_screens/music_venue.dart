import 'package:flutter/material.dart';
import 'package:moves/model/location_loaded_model.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class MusicVenue extends StatefulWidget {
  MusicVenue({this.location});

  final LocationLoadedModel location;

  @override
  _MusicVenueState createState() => _MusicVenueState();
}

class _MusicVenueState extends State<MusicVenue> {
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');

  @override
  Widget build(BuildContext context) {
    List<Widget> getPerformances() {
      List<Widget> performances = List();

      List<dynamic> performancesData = widget
          .location.updateInfo["music_update_info"]["music_performances"]
          .toList();

      performancesData.sort((a, b) {
        return a["music_performance_date"]
            .compareTo(b["music_performance_date"]);
      });

      for (var performance in performancesData) {
        DateTime date = DateTime.parse(performance["music_performance_date"]);
        var formatter = new DateFormat('yMMMd');
        String formattedDate = formatter.format(date);
        performances.add(
          Text('$formattedDate: ${performance["music_performer_name"]}'),
        );
      }
      return performances;
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text('Music Venue Info'),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.music_note,
              color: Colors.deepPurpleAccent,
            ),
            title: Text('Upcoming Performances'),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: LimitedBox(
                maxHeight: 120,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: getPerformances(),
                  ),
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.local_bar,
              color: Colors.deepOrangeAccent,
            ),
            title: Text('Alcohol sold'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["music_update_info"]
                            ["music_alcohol_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["music_update_info"]["music_alcohol_percent"]}% reported Yes (Last Day)')
                    : Text('No users reported in last dat'),
                widget.location.updateInfo["music_update_info"]
                            ["music_alcohol_percent"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["music_update_info"]["music_alcohol_percent_day"]}% reported Yes (All Time)')
                    : Text('No users reported ever'),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.perm_identity,
              color: Colors.blueAccent,
            ),
            title: Text('18+'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["music_update_info"]
                            ["music_18_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["music_update_info"]["music_18_percent"]}% reported Yes (Last Day)')
                    : Text('No users reported in last dat'),
                widget.location.updateInfo["music_update_info"]
                            ["music_18_percent"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["music_update_info"]["music_18_percent_day"]}% reported Yes (All Time)')
                    : Text('No users reported ever'),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.perm_identity,
              color: Colors.redAccent,
            ),
            title: Text('21+'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["music_update_info"]
                            ["music_21_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["music_update_info"]["music_21_percent"]}% reported Yes (Last Day)')
                    : Text('No users reported in last dat'),
                widget.location.updateInfo["music_update_info"]
                            ["music_21_percent"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["music_update_info"]["music_21_percent_day"]}% reported Yes (All Time)')
                    : Text('No users reported ever'),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.atm,
              color: Colors.green,
            ),
            title: Text('ATM available'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["music_update_info"]
                            ["music_atm_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["music_update_info"]["music_atm_percent"]}% reported Yes (Last Day)')
                    : Text('No users reported in last dat'),
                widget.location.updateInfo["music_update_info"]
                            ["music_atm_percent"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["music_update_info"]["music_atm_percent_day"]}% reported Yes (All Time)')
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
