import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:moves/store/store.dart';
import 'package:moves/model/homelist.dart';

class MapScreen extends StatelessWidget {
  MapScreen({this.kek}) : super();

  final kek;

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
  static final LatLng center = const LatLng(35.7796, -78.6382);

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

  @override
  void dispose() {
    super.dispose();
  }

  void createMarkers() {
    List<HomeListItem> locations =
        Provider.of<Store>(context, listen: false).filteredLocations;

    for (var place in locations) {
      final String markerIdVal = place.location.id;
      final MarkerId markerId = MarkerId(markerIdVal);

      final Marker marker = Marker(
        markerId: markerId,
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
      });
    }
  }

  // navigate to location screen
  void _onInfoWindowTap(MarkerId markerId) {
    setState(() {
      List<HomeListItem> locations =
          Provider.of<Store>(context, listen: false).filteredLocations;

      print('hey');

      for (var place in locations) {
        if (place.location.id.toString() == markerId.value.toString()) {
          print(place.location.id.toString());
          print(markerId.value);
          print('match!');
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
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: GoogleMap(
            mapToolbarEnabled: false,
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: Provider.of<Store>(context).manualLocationSelected
                  ? LatLng(
                      Provider.of<Store>(context).usersManualLocation.latitude,
                      Provider.of<Store>(context).usersManualLocation.longitude)
                  : LatLng(Provider.of<Store>(context).usersLocation.latitude,
                      Provider.of<Store>(context).usersLocation.longitude),
              zoom: 14.0,
            ),
            markers: Set<Marker>.of(markers.values),
          ),
        ),
      ),
    );
  }
}
