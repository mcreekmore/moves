import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:moves/store/store.dart';
import 'package:moves/model/homelist.dart';

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
  //int _markerIdCounter = 1;

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
  }

  @override
  void initState() {
    createMarkers();
    super.initState();
  }

  void createMarkers() {
    List<HomeListItem> locations =
        Provider.of<Store>(context, listen: false).filteredLocations;

    for (var place in locations) {
      final String markerIdVal = place.location.id;
      //_markerIdCounter++;
      final MarkerId markerId = MarkerId(markerIdVal);

      final Marker marker = Marker(
        markerId: markerId,
        // position: LatLng(
        //   center.latitude + sin(_markerIdCounter * pi / 6.0) / 20.0,
        //   center.longitude + cos(_markerIdCounter * pi / 6.0) / 20.0,
        // ),
        position: LatLng(place.location.lat, place.location.lon),
        infoWindow: InfoWindow(
          onTap: () {
            _onInfoWindowTap(markerId);
          },
          title: place.location.name,
        ),
        onTap: () {
          _onMarkerTapped(markerId);
        },
      );

      setState(() {
        markers[markerId] = marker;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  // highlight and move camera on tap
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
            BitmapDescriptor.hueAzure,
          ),
        );
        markers[markerId] = newMarker;

        // showModalBottomSheet(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return Container();
        //     });
      });
    }
  }

  // navigate to location screen
  void _onInfoWindowTap(MarkerId markerId) {
    setState(() {
      List<HomeListItem> locations =
          Provider.of<Store>(context, listen: false).filteredLocations;

      for (var place in locations) {
        if (place.location.id.toString() == markerId.value.toString()) {
          // print(place.location.id.toString());
          // print(markerId.value);
          Navigator.push<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => place.navigateScreen,
            ),
          );
          return;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Center(
          child: SizedBox(
            //width: 300.0,'
            //width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: GoogleMap(
              myLocationEnabled: true,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    Provider.of<Store>(context).usersLocation.latitude,
                    Provider.of<Store>(context).usersLocation.longitude),
                zoom: 14.0,
              ),
              markers: Set<Marker>.of(markers.values),
            ),
          ),
        ),
        // SingleChildScrollView(
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: <Widget>[
        //       Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: <Widget>[
        //           FlatButton(
        //             child: const Text('add'),
        //             onPressed: _add,
        //           ),
        //         ],
        //       )
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
