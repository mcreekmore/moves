// import 'package:flutter/material.dart';
// //import 'dart:async';

// import 'package:google_maps_flutter/google_maps_flutter.dart';
// //import 'package:floating_search_bar/floating_search_bar.dart';

// class MapScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: FireMap(),
//     );
//   }
// }

// class FireMap extends StatefulWidget {
//   @override
//   _FireMapState createState() => _FireMapState();
// }

// class _FireMapState extends State<FireMap> {
//   GoogleMapController mapController;
//   LatLng _lastMapPosition = LatLng(35.78, -78.64);
//   Set<Marker> markers = Set();

//   _onMapCreated(GoogleMapController controller) {
//     setState(() {
//       mapController = controller;
//     });
//   }

//   void _onCameraMove(CameraPosition position) {
//     print(position);
//     _lastMapPosition = position.target;
//   }

//   _addMarker() {
//     var marker = Marker(
//       position: _lastMapPosition,
//       icon: BitmapDescriptor.defaultMarker,
//       infoWindow: InfoWindow(title: 'Magic Marker'),
//       markerId: MarkerId('kek'),
//     );

//     setState(() {
//       markers.add(marker);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         GoogleMap(
//           initialCameraPosition: CameraPosition(
//             target: LatLng(35.78, -78.64),
//             zoom: 15,
//           ),
//           onMapCreated: _onMapCreated,
//           myLocationButtonEnabled: true,
//           compassEnabled: true,
//           onCameraMove: _onCameraMove,
//           markers: markers,
//         ),
//         Positioned(
//           bottom: 20,
//           right: 20,
//           child: FlatButton(
//             child: Icon(
//               Icons.pin_drop,
//               color: Colors.white,
//             ),
//             color: Colors.green,
//             onPressed: _addMarker,
//           ),
//         ),
//       ],
//     );
//   }
// }

// // class MapScreen extends StatefulWidget {
// //   @override
// //   State<MapScreen> createState() => MapSampleState();
// // }

// // class MapSampleState extends State<MapScreen> {
// //   Completer<GoogleMapController> _controller = Completer();

// //   static final CameraPosition _kGooglePlex = CameraPosition(
// //     target: LatLng(37.42796133580664, -122.085749655962),
// //     zoom: 14.4746,
// //   );

// //   static final CameraPosition _kLake = CameraPosition(
// //       bearing: 192.8334901395799,
// //       target: LatLng(37.43296265331129, -122.08832357078792),
// //       tilt: 59.440717697143555,
// //       zoom: 19.151926040649414);

// //   @override
// //   Widget build(BuildContext context) {
// //     return new Scaffold(
// //       body: GoogleMap(
// //         mapType: MapType.hybrid,
// //         initialCameraPosition: _kGooglePlex,
// //         onMapCreated: (GoogleMapController controller) {
// //           _controller.complete(controller);
// //         },
// //       ),
// //       floatingActionButton: FloatingActionButton.extended(
// //         onPressed: _goToTheLake,
// //         label: Text('To the lake!'),
// //         icon: Icon(Icons.directions_boat),
// //       ),
// //     );
// //   }

// //   Future<void> _goToTheLake() async {
// //     final GoogleMapController controller = await _controller.future;
// //     controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
// //   }
// // }

// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs
