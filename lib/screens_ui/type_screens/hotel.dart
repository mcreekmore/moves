import 'package:flutter/material.dart';
import 'package:moves/model/location_loaded_model.dart';
import 'dart:convert';

class Hotel extends StatefulWidget {
  Hotel({this.location});

  final LocationLoadedModel location;

  @override
  _HotelState createState() => _HotelState();
}

class _HotelState extends State<Hotel> {
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
              child: Text('Hotel Info'),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.local_hotel,
              color: Colors.indigo,
            ),
            title: Text('Vacancies'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.location.updateInfo["hotel_update_info"]
                            ["hotel_vacancies_bool_percent_hour"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["hotel_update_info"]["hotel_vacancies_bool_percent_hour"]}% reported Yes (Last Hour)')
                    : Text('No users reported in last hour'),
                widget.location.updateInfo["hotel_update_info"]
                            ["hotel_vacancies_bool_percent_day"] !=
                        null
                    ? Text(
                        '${widget.location.updateInfo["hotel_update_info"]["hotel_vacancies_bool_percent_day"]}% reported Yes (Last Day)')
                    : Text('No users reported in last day'),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.wifi,
              color: Colors.blueAccent,
            ),
            title: Text('Free Wifi'),
            subtitle: widget.location.updateInfo["hotel_update_info"]
                        ["hotel_wifi_percent"] !=
                    null
                ? Text(
                    '${widget.location.updateInfo["hotel_update_info"]["hotel_wifi_percent"]}% reported Yes (Last Hour)')
                : Text('No users reported ever'),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.restaurant,
              color: Colors.deepOrangeAccent,
            ),
            title: Text('Free Breakfast'),
            subtitle: widget.location.updateInfo["hotel_update_info"]
                        ["hotel_breakfast_percent"] !=
                    null
                ? Text(
                    '${widget.location.updateInfo["hotel_update_info"]["hotel_breakfast_percent"]}% reported Yes (Last Hour)')
                : Text('No users reported ever'),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.pool,
              color: Colors.blueAccent,
            ),
            title: Text('Pool available'),
            subtitle: widget.location.updateInfo["hotel_update_info"]
                        ["hotel_pool_percent"] !=
                    null
                ? Text(
                    '${widget.location.updateInfo["hotel_update_info"]["hotel_pool_percent"]}% reported Yes (Last Hour)')
                : Text('No users reported ever'),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.cloud,
              color: Colors.indigoAccent,
            ),
            title: Text('Air conditioning'),
            subtitle: widget.location.updateInfo["hotel_update_info"]
                        ["hotel_air_percent"] !=
                    null
                ? Text(
                    '${widget.location.updateInfo["hotel_update_info"]["hotel_air_percent"]}% reported Yes (Last Hour)')
                : Text('No users reported ever'),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.local_bar,
              color: Colors.purple,
            ),
            title: Text('Hotel Bar'),
            subtitle: widget.location.updateInfo["hotel_update_info"]
                        ["hotel_bar_percent"] !=
                    null
                ? Text(
                    '${widget.location.updateInfo["hotel_update_info"]["hotel_bar_percent"]}% reported Yes (Last Hour)')
                : Text('No users reported ever'),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.pets,
              color: Colors.brown,
            ),
            title: Text('Pet friendly'),
            subtitle: widget.location.updateInfo["hotel_update_info"]
                        ["hotel_pets_percent"] !=
                    null
                ? Text(
                    '${widget.location.updateInfo["hotel_update_info"]["hotel_pets_percent"]}% reported Yes (Last Hour)')
                : Text('No users reported ever'),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.green,
            ),
            title: Text('Wellness center available'),
            subtitle: widget.location.updateInfo["hotel_update_info"]
                        ["hotel_wellness_percent"] !=
                    null
                ? Text(
                    '${widget.location.updateInfo["hotel_update_info"]["hotel_wellness_percent"]}% reported Yes (Last Hour)')
                : Text('No users reported ever'),
          ),
          Divider(),
        ],
      ),
    );
  }
}
