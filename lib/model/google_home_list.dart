// import 'package:best_flutter_ui_templates/design_course/home_design_course.dart';
// import 'package:best_flutter_ui_templates/fitness_app/fitness_app_home_screen.dart';
// import 'package:best_flutter_ui_templates/hotel_booking/hotel_home_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';

class GoogleHomeList {
  GoogleHomeList({
    this.navigateScreen,
    this.imagePath = '',
    this.location,
  });

  Widget navigateScreen;
  String imagePath;
  PlacesSearchResult location;
}
