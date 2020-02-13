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

import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'page.dart';

class MapScreen extends Page {
  MapScreen() : super(const Icon(Icons.place), 'Place marker');

  @override
  Widget build(BuildContext context) {
    return const PlaceMarkerBody();
  }
}

class PlaceMarkerBody extends StatefulWidget {
  const PlaceMarkerBody();

  @override
  State<StatefulWidget> createState() => PlaceMarkerBodyState();
}

typedef Marker MarkerUpdateAction(Marker marker);

class PlaceMarkerBodyState extends State<PlaceMarkerBody> {
  PlaceMarkerBodyState();
  static final LatLng center = const LatLng(-33.86711, 151.1947171);

  GoogleMapController controller;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId selectedMarker;
  int _markerIdCounter = 1;

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onMarkerTapped(MarkerId markerId) {
    final Marker tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      setState(() {
        if (markers.containsKey(selectedMarker)) {
          final Marker resetOld = markers[selectedMarker]
              .copyWith(iconParam: BitmapDescriptor.defaultMarker);
          markers[selectedMarker] = resetOld;
        }
        selectedMarker = markerId;
        final Marker newMarker = tappedMarker.copyWith(
          iconParam: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        );
        markers[markerId] = newMarker;
      });
    }
  }

  void _onMarkerDragEnd(MarkerId markerId, LatLng newPosition) async {
    final Marker tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                actions: <Widget>[
                  FlatButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
                content: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 66),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Old position: ${tappedMarker.position}'),
                        Text('New position: $newPosition'),
                      ],
                    )));
          });
    }
  }

  void _add() {
    final int markerCount = markers.length;

    if (markerCount == 12) {
      return;
    }

    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        center.latitude + sin(_markerIdCounter * pi / 6.0) / 20.0,
        center.longitude + cos(_markerIdCounter * pi / 6.0) / 20.0,
      ),
      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      onTap: () {
        _onMarkerTapped(markerId);
      },
      onDragEnd: (LatLng position) {
        _onMarkerDragEnd(markerId, position);
      },
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  void _remove() {
    setState(() {
      if (markers.containsKey(selectedMarker)) {
        markers.remove(selectedMarker);
      }
    });
  }

  void _changePosition() {
    final Marker marker = markers[selectedMarker];
    final LatLng current = marker.position;
    final Offset offset = Offset(
      center.latitude - current.latitude,
      center.longitude - current.longitude,
    );
    setState(() {
      markers[selectedMarker] = marker.copyWith(
        positionParam: LatLng(
          center.latitude + offset.dy,
          center.longitude + offset.dx,
        ),
      );
    });
  }

  void _changeAnchor() {
    final Marker marker = markers[selectedMarker];
    final Offset currentAnchor = marker.anchor;
    final Offset newAnchor = Offset(1.0 - currentAnchor.dy, currentAnchor.dx);
    setState(() {
      markers[selectedMarker] = marker.copyWith(
        anchorParam: newAnchor,
      );
    });
  }

  Future<void> _changeInfoAnchor() async {
    final Marker marker = markers[selectedMarker];
    final Offset currentAnchor = marker.infoWindow.anchor;
    final Offset newAnchor = Offset(1.0 - currentAnchor.dy, currentAnchor.dx);
    setState(() {
      markers[selectedMarker] = marker.copyWith(
        infoWindowParam: marker.infoWindow.copyWith(
          anchorParam: newAnchor,
        ),
      );
    });
  }

  Future<void> _toggleDraggable() async {
    final Marker marker = markers[selectedMarker];
    setState(() {
      markers[selectedMarker] = marker.copyWith(
        draggableParam: !marker.draggable,
      );
    });
  }

  Future<void> _toggleFlat() async {
    final Marker marker = markers[selectedMarker];
    setState(() {
      markers[selectedMarker] = marker.copyWith(
        flatParam: !marker.flat,
      );
    });
  }

  Future<void> _changeInfo() async {
    final Marker marker = markers[selectedMarker];
    final String newSnippet = marker.infoWindow.snippet + '*';
    setState(() {
      markers[selectedMarker] = marker.copyWith(
        infoWindowParam: marker.infoWindow.copyWith(
          snippetParam: newSnippet,
        ),
      );
    });
  }

  Future<void> _changeAlpha() async {
    final Marker marker = markers[selectedMarker];
    final double current = marker.alpha;
    setState(() {
      markers[selectedMarker] = marker.copyWith(
        alphaParam: current < 0.1 ? 1.0 : current * 0.75,
      );
    });
  }

  Future<void> _changeRotation() async {
    final Marker marker = markers[selectedMarker];
    final double current = marker.rotation;
    setState(() {
      markers[selectedMarker] = marker.copyWith(
        rotationParam: current == 330.0 ? 0.0 : current + 30.0,
      );
    });
  }

  Future<void> _toggleVisible() async {
    final Marker marker = markers[selectedMarker];
    setState(() {
      markers[selectedMarker] = marker.copyWith(
        visibleParam: !marker.visible,
      );
    });
  }

  Future<void> _changeZIndex() async {
    final Marker marker = markers[selectedMarker];
    final double current = marker.zIndex;
    setState(() {
      markers[selectedMarker] = marker.copyWith(
        zIndexParam: current == 12.0 ? 0.0 : current + 1.0,
      );
    });
  }

// A breaking change to the ImageStreamListener API affects this sample.
// I've updates the sample to use the new API, but as we cannot use the new
// API before it makes it to stable I'm commenting out this sample for now
// sTODO(amirh): uncomment this one the ImageStream API change makes it to stable.
// https://github.com/flutter/flutter/issues/33438
//
//  void _setMarkerIcon(BitmapDescriptor assetIcon) {
//    if (selectedMarker == null) {
//      return;
//    }
//
//    final Marker marker = markers[selectedMarker];
//    setState(() {
//      markers[selectedMarker] = marker.copyWith(
//        iconParam: assetIcon,
//      );
//    });
//  }
//
//  Future<BitmapDescriptor> _getAssetIcon(BuildContext context) async {
//    final Completer<BitmapDescriptor> bitmapIcon =
//        Completer<BitmapDescriptor>();
//    final ImageConfiguration config = createLocalImageConfiguration(context);
//
//    const AssetImage('assets/red_square.png')
//        .resolve(config)
//        .addListener(ImageStreamListener((ImageInfo image, bool sync) async {
//      final ByteData bytes =
//          await image.image.toByteData(format: ImageByteFormat.png);
//      final BitmapDescriptor bitmap =
//          BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
//      bitmapIcon.complete(bitmap);
//    }));
//
//    return await bitmapIcon.future;
//  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Center(
          child: SizedBox(
            //width: 300.0,'
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 200.0,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: const CameraPosition(
                target: LatLng(-33.852, 151.211),
                zoom: 11.0,
              ),
              // sTODO(iskakaushik): Remove this when collection literals makes it to stable.
              // https://github.com/flutter/flutter/issues/28312
              // ignore: prefer_collection_literals
              markers: Set<Marker>.of(markers.values),
            ),
          ),
        ),
        SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FlatButton(
                        child: const Text('add'),
                        onPressed: _add,
                      ),
                      FlatButton(
                        child: const Text('remove'),
                        onPressed: _remove,
                      ),
                      FlatButton(
                        child: const Text('change info'),
                        onPressed: _changeInfo,
                      ),
                      FlatButton(
                        child: const Text('change info anchor'),
                        onPressed: _changeInfoAnchor,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      FlatButton(
                        child: const Text('change alpha'),
                        onPressed: _changeAlpha,
                      ),
                      FlatButton(
                        child: const Text('change anchor'),
                        onPressed: _changeAnchor,
                      ),
                      FlatButton(
                        child: const Text('toggle draggable'),
                        onPressed: _toggleDraggable,
                      ),
                      FlatButton(
                        child: const Text('toggle flat'),
                        onPressed: _toggleFlat,
                      ),
                      FlatButton(
                        child: const Text('change position'),
                        onPressed: _changePosition,
                      ),
                      FlatButton(
                        child: const Text('change rotation'),
                        onPressed: _changeRotation,
                      ),
                      FlatButton(
                        child: const Text('toggle visible'),
                        onPressed: _toggleVisible,
                      ),
                      FlatButton(
                        child: const Text('change zIndex'),
                        onPressed: _changeZIndex,
                      ),
                      // A breaking change to the ImageStreamListener API affects this sample.
                      // I've updates the sample to use the new API, but as we cannot use the new
                      // API before it makes it to stable I'm commenting out this sample for now
                      // sTODO(amirh): uncomment this one the ImageStream API change makes it to stable.
                      // https://github.com/flutter/flutter/issues/33438
                      //
                      // FlatButton(
                      //   child: const Text('set marker icon'),
                      //   onPressed: () {
                      //     _getAssetIcon(context).then(
                      //       (BitmapDescriptor icon) {
                      //         _setMarkerIcon(icon);
                      //       },
                      //     );
                      //   },
                      // ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
