import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:moves/model/location_loaded_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:moves/theme_notifier.dart';
import 'package:provider/provider.dart';

class LocationActionBar extends StatelessWidget {
  LocationActionBar({this.location});

  final LocationLoadedModel location;

  _launchUber() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    String url = 'https://m.uber.com/ul/?' +
        'client_id=j1ZjsNQ24l2nrYYkvEeYMm76M7MSkTUq' +
        '&action=setPickup' +
        '&pickup[latitude]=${position.latitude}' +
        '&pickup[longitude]=${position.longitude}' +
        '&pickup[nickname]=Current Location' +
        '&dropoff[latitude]=${location.lat}' +
        '&dropoff[longitude]=${location.lon}' +
        '&dropoff[nickname]=${location.name}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchLyft() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    String url = 'lyft://ridetype?id=lyft' +
        '&pickup[latitude]=${position.latitude}' +
        '&pickup[longitude]=${position.longitude}' +
        '&destination[latitude]=${location.lat}' +
        '&destination[longitude]=${location.lon}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      children: <Widget>[
        FlatButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          onPressed: () {
            _launchUber();
          },
          color: Provider.of<ThemeNotifier>(context).getTheme() == darkTheme
              ? Colors.white
              : Colors.black,
          // child: Text(
          //   'UBER',
          //   style: TextStyle(
          //     color: Provider.of<ThemeNotifier>(context).getTheme() == darkTheme
          //         ? Colors.black
          //         : Colors.white,
          //   ),
          // ),
          child: SizedBox(
            height: 30,
            child: Provider.of<ThemeNotifier>(context).getTheme() == darkTheme
                ? Image.asset(
                    'assets/images/Uber_Logo_Black_RGB.png',
                    fit: BoxFit.fitHeight,
                  )
                : Image.asset(
                    'assets/images/Uber_Logo_White_RGB.png',
                    fit: BoxFit.fitHeight,
                  ),
          ),
        ),
        FlatButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          onPressed: () {
            _launchLyft();
          },
          child: SizedBox(
            height: 30,
            child: Image.asset(
              'assets/images/lyft.png',
              fit: BoxFit.fitHeight,
            ),
          ),
          color: Provider.of<ThemeNotifier>(context).getTheme() == darkTheme
              ? Colors.white
              : Colors.black,
        ),
      ],
    );
  }
}
