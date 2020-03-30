import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:moves/app_theme.dart';
import 'package:moves/model/location_loaded_model.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:moves/store/store.dart';

// types
import 'package:moves/widgets/bottom_sheet_types/location_bottom_sheet.dart';
import 'package:moves/widgets/bottom_sheet_types/bar_bottom_sheet.dart';
import 'package:moves/widgets/bottom_sheet_types/bank_bottom_sheet.dart';
import 'package:moves/widgets/bottom_sheet_types/cafe_bottom_sheet.dart';
import 'package:moves/widgets/bottom_sheet_types/gas_station_bottom_sheet.dart';
import 'package:moves/widgets/bottom_sheet_types/grocery_bottom_sheet.dart';
import 'package:moves/widgets/bottom_sheet_types/hospital_bottom_sheet.dart';
import 'package:moves/widgets/bottom_sheet_types/hotel_bottom_sheet.dart';
import 'package:moves/widgets/bottom_sheet_types/music_venue_bottom_sheet.dart';
import 'package:moves/widgets/bottom_sheet_types/post_office_bottom_sheet.dart';
import 'package:moves/widgets/bottom_sheet_types/restaurant_bottom_sheet.dart';
import 'package:moves/widgets/bottom_sheet_types/pharmacy_bottom_sheet.dart';

class BottomSheetWidget extends StatelessWidget {
  BottomSheetWidget({this.location});

  final LocationLoadedModel location;

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    Future makePostRequest(dynamic body) async {
      String url = 'http://' +
          Provider.of<Store>(context, listen: false).getApi() +
          '/api/locations/update';

      Dio dio = new Dio();

      //print(jsonEncode(body).toString());

      print(jsonEncode(body));

      var response = await dio.post(url, data: jsonEncode(body));

      //print(response.statusMessage);
      // if you want to print, add 'var response =' before the await
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      // print(await http.read('https://creekmore.io/api/locations'));
    }

    void selectedIndex(int index) async {
      if (index == 0) {
        // Submit
        if (_fbKey.currentState.saveAndValidate()) {
          //print(_fbKey.currentState.value);
          await makePostRequest(_fbKey.currentState.value);
          SnackBar snackBar = SnackBar(
            content: Text('Location Update was sent successfully'),
          );

          Scaffold.of(_fbKey.currentContext).showSnackBar(snackBar);
          // Alert(
          //   context: context,
          //   title: "Thank you!",
          //   desc: "Your suggested place has been successfully sent.",
          //   image: Image.asset("assets/images/good-job.png"),
          // ).show();

        }
      } else if (index == 1) {
        // Reset
        _fbKey.currentState.reset();
      } else if (index == 2) {
        // Close
        Navigator.pop(context);
      }
    }

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppTheme.nearlyWhite,
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
                Icons.send,
                color: Colors.blueAccent,
              ),
              title: Text(
                "Submit",
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.clear_all),
              title: Text('Reset'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.close, color: Colors.redAccent),
              title: Text(
                'Close',
                style: TextStyle(color: Colors.redAccent),
              ),
            )
          ]),
      body: SingleChildScrollView(
        child: Container(
          color: AppTheme.nearlyWhite,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 42, bottom: 16),
                    child: Text(
                      'Update Info',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  FormBuilder(
                    key: _fbKey,
                    initialValue: {
                      'date': DateTime.now().toIso8601String(),
                      'locationID': location.id.toString(),
                    },
                    autovalidate: true,
                    child: Column(
                      children: <Widget>[
                        // types
                        location.types.contains('Bar')
                            ? BarBottomSheet()
                            : Container(),
                        location.types.contains('Restaurant')
                            ? RestaurantBottomSheet()
                            : Container(),
                        location.types.contains('Cafe')
                            ? CafeBottomSheet()
                            : Container(),
                        location.types.contains('Music Venue')
                            ? MusicVenueBottomSheet()
                            : Container(),
                        location.types.contains('Hotel')
                            ? HotelBottomSheet()
                            : Container(),
                        location.types.contains('Grocery')
                            ? GroceryBottomSheet()
                            : Container(),
                        location.types.contains('Gas Station')
                            ? GasStationBottomSheet()
                            : Container(),
                        location.types.contains('Bank')
                            ? BankBottomSheet()
                            : Container(),
                        location.types.contains('Post Office')
                            ? PostOfficeBottomSheet()
                            : Container(),
                        location.types.contains('Hospital')
                            ? HospitalBottomSheet()
                            : Container(),
                        location.types.contains('Pharmacy')
                            ? PharmacyBottomSheet()
                            : Container(),

                        // basic location info
                        LocationBottomSheet(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
