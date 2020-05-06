import 'package:flutter/material.dart';
//import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:moves/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:moves/store/store.dart';

class ManualLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FireMap(),
    );
  }
}

class FireMap extends StatefulWidget {
  @override
  _FireMapState createState() => _FireMapState();
}

class _FireMapState extends State<FireMap> {
  GoogleMapController mapController;
  LatLng _lastMapPosition = LatLng(35.78, -78.64);
  LatLng manualLocation = LatLng(35.78, -78.64);
  Set<Marker> markers = Set();
  var marker;

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onCameraMove(CameraPosition position) {
    //print(position);
    _lastMapPosition = position.target;
  }

  _updateMarker() {
    marker = Marker(
      position: _lastMapPosition,
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(title: 'Magic Marker'),
      markerId: MarkerId('kek'),
    );

    manualLocation = _lastMapPosition;

    setState(() {
      markers.add(marker);
    });
  }

  void selectedIndex(int index) async {
    print("index: " + index.toString());
    if (index == 0) {
      // Submit
      Provider.of<Store>(context, listen: false).setUsersManualLocation(
          manualLocation.latitude, manualLocation.longitude);
      Navigator.pop(context);
    } else if (index == 1) {
      // Reset (close)
      Navigator.pop(context);
    }
    // else if (index == 2) {
    //   // Close
    //   Navigator.pop(context);
    // }
  }

  @override
  Widget build(BuildContext context) {
    marker = Marker(
      position: LatLng(
          Provider.of<Store>(context, listen: false)
              .usersManualLocation
              .latitude,
          Provider.of<Store>(context, listen: false)
              .usersManualLocation
              .longitude),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(title: 'Your Location'),
      markerId: MarkerId('kek'),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a location'),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor:
              Provider.of<ThemeNotifier>(context).getTheme() == darkTheme
                  ? Colors.black
                  : Colors.white,
        ),
        child: BottomNavigationBar(
          //backgroundColor: AppTheme.nearlyWhite,
          selectedItemColor: Colors.grey.shade800,
          selectedFontSize: 12,
          unselectedItemColor: Colors.grey.shade800,
          unselectedFontSize: 12,
          currentIndex: 0,
          onTap: (int index) {
            selectedIndex(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.check_circle,
                color: Colors.blueAccent,
              ),
              title: Text(
                "Accept",
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.clear_all),
            //   title: Text('Reset'),
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.close, color: Colors.redAccent),
              title: Text(
                'Close',
                style: TextStyle(color: Colors.redAccent),
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(35.78, -78.64),
              zoom: 15,
            ),
            onMapCreated: _onMapCreated,
            myLocationButtonEnabled: true,
            compassEnabled: true,
            onCameraMove: _onCameraMove,
            markers: markers,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Provider.of<Store>(context).manualLocationSelected
                      ? Row(
                          children: <Widget>[
                            Text(
                              'USE MANUAL LOCATION',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.check_box,
                              color: Colors.white,
                            ),
                          ],
                        )
                      : Row(
                          children: <Widget>[
                            Text(
                              'USE MANUAL LOCATION',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.check_box_outline_blank,
                              color: Colors.white,
                            ),
                          ],
                        ),
                  color: Provider.of<Store>(context).manualLocationSelected
                      ? Colors.green
                      : Colors.grey,
                  onPressed: () {
                    Provider.of<Store>(context, listen: false)
                        .toggleManualLocation();
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                child: Icon(
                  Icons.pin_drop,
                  color: Colors.white,
                ),
                color: Colors.green,
                onPressed: _updateMarker,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class MapScreen extends StatefulWidget {
//   @override
//   State<MapScreen> createState() => MapSampleState();
// }

// class MapSampleState extends State<MapScreen> {
//   Completer<GoogleMapController> _controller = Completer();

//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );

//   static final CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(37.43296265331129, -122.08832357078792),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: GoogleMap(
//         mapType: MapType.hybrid,
//         initialCameraPosition: _kGooglePlex,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _goToTheLake,
//         label: Text('To the lake!'),
//         icon: Icon(Icons.directions_boat),
//       ),
//     );
//   }

//   Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }
// }
