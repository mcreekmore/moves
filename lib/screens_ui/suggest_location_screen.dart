import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:moves/store/store.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'dart:convert';
import 'package:moves/theme_notifier.dart';

class SuggestLocationScreen extends StatefulWidget {
  @override
  _SuggestLocationScreenState createState() => _SuggestLocationScreenState();
}

class _SuggestLocationScreenState extends State<SuggestLocationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormBuilderState> _suggestKey =
        GlobalKey<FormBuilderState>();

    dynamic calcLatLon() async {
      print('street: ' + _suggestKey.currentState.value["street"]);
      String street = _suggestKey.currentState.value["street"].toString();
      //String region = _suggestKey.currentState.value["region"].toString();
      String city = _suggestKey.currentState.value["city"].toString();
      final query = "$street, $city";
      try {
        var addresses = await Geocoder.local.findAddressesFromQuery(
            query); //TODO fix geocoder null error (possibly fixed)
        var first = addresses.first;
        return first.coordinates;
      } catch (e) {
        return null;
      }
    }

    Future makePostRequest(dynamic body) async {
      String url = Provider.of<Store>(context, listen: false).getHttp() +
          Provider.of<Store>(context, listen: false).getApi() +
          '/api/locations';
      //TODO http for dev and https for server

      Coordinates coordinates = await calcLatLon();
      print("coordinates: " + coordinates.toString());
      double lat = coordinates.latitude;
      double lon = coordinates.longitude;

      Dio dio = new Dio();

      body.putIfAbsent('lat', () => lat);
      body.putIfAbsent('lon', () => lon);

      print(body.toString());

      try {
        var response = await dio.post(
          url,
          data: jsonEncode(body),
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            },
          ),
        );
        if (response.statusCode == 400) {
          SnackBar snackBar = SnackBar(
            content: Row(
              children: <Widget>[
                Text(
                  'ERROR: ',
                  style: TextStyle(color: Colors.redAccent),
                ),
                Text('Location Already Registered'),
              ],
            ),
          );

          Scaffold.of(_suggestKey.currentContext).showSnackBar(snackBar);
          return;
        }
        SnackBar snackBar = SnackBar(
          content: Row(
            children: <Widget>[
              Text(
                'SUCCESS: ',
                style: TextStyle(color: Colors.greenAccent),
              ),
              Text('Location Suggestion Sent'),
            ],
          ),
        );

        Scaffold.of(_suggestKey.currentContext).showSnackBar(snackBar);
      } catch (e) {
        print(e);
      }
    }

    void selectedIndex(int index) async {
      print("index: " + index.toString());
      if (index == 0) {
        print(_suggestKey.currentState.value);
        // Submit
        if (_suggestKey.currentState.saveAndValidate()) {
          await makePostRequest(_suggestKey.currentState.value);
        }
      } else if (index == 1) {
        // Reset
        _suggestKey.currentState.reset();
      } else if (index == 2) {
        // Close
        Navigator.pop(context);
      }
    }

    return Scaffold(
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
          ],
        ),
      ),
      //backgroundColor: AppTheme.nearlyWhite,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 42),
              child: Text(
                'Suggest a New Location',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            /* FORM */

            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
              child: FormBuilder(
                key: _suggestKey,
                autovalidate: true,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 16),
                      child: const Text(
                        'Place Info',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    FormBuilderTextField(
                      attribute: "name",
                      decoration: InputDecoration(labelText: "*Location Name"),
                      validators: [
                        FormBuilderValidators.maxLength(100),
                        FormBuilderValidators.required(),
                      ],
                    ),
                    FormBuilderTextField(
                      attribute: "description",
                      decoration: InputDecoration(labelText: "Description"),
                      validators: [
                        FormBuilderValidators.maxLength(300),
                      ],
                    ),
                    FormBuilderFilterChip(
                      decoration:
                          InputDecoration(labelText: "*Location Type(s)"),
                      attribute: "types",
                      validators: [FormBuilderValidators.required()],
                      options: [
                        FormBuilderFieldOption(
                          child: Text("Restaurant"),
                          value: "Restaurant",
                        ),
                        FormBuilderFieldOption(
                          child: Text("Hotel"),
                          value: "Hotel",
                        ),
                        FormBuilderFieldOption(
                          child: Text("Bar"),
                          value: "Bar",
                        ),
                        FormBuilderFieldOption(
                          child: Text("Cafe"),
                          value: "Cafe",
                        ),
                        FormBuilderFieldOption(
                          child: Text("Music Venue"),
                          value: "Music Venue",
                        ),
                        FormBuilderFieldOption(
                          child: Text("Grocery"),
                          value: "Grocery",
                        ),
                        FormBuilderFieldOption(
                          child: Text("Gas Station"),
                          value: "Gas Station",
                        ),
                        FormBuilderFieldOption(
                          child: Text("Bank"),
                          value: "Bank",
                        ),
                        FormBuilderFieldOption(
                          child: Text("Post Office"),
                          value: "Post Office",
                        ),
                        FormBuilderFieldOption(
                          child: Text("Pharmacy"),
                          value: "Pharmacy",
                        ),
                        FormBuilderFieldOption(
                          child: Text("Retail"),
                          value: "Retail",
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 16),
                      child: const Text(
                        'Location Info',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    FormBuilderTextField(
                      attribute: "country",
                      decoration: InputDecoration(labelText: "*Country"),
                      validators: [
                        FormBuilderValidators.maxLength(50),
                        FormBuilderValidators.required(),
                      ],
                    ),
                    FormBuilderTextField(
                      attribute: "region",
                      decoration: InputDecoration(labelText: "*Region (State)"),
                      validators: [
                        FormBuilderValidators.maxLength(300),
                        FormBuilderValidators.required(),
                      ],
                    ),
                    FormBuilderTextField(
                      attribute: "city",
                      decoration: InputDecoration(labelText: "*City"),
                      validators: [
                        FormBuilderValidators.maxLength(300),
                        FormBuilderValidators.required(),
                      ],
                    ),
                    FormBuilderTextField(
                      attribute: "street",
                      decoration: InputDecoration(labelText: "*Street"),
                      validators: [
                        FormBuilderValidators.maxLength(300),
                        FormBuilderValidators.required(),
                      ],
                    ),
                    FormBuilderTextField(
                      attribute: "zip",
                      decoration: InputDecoration(labelText: "*Zipcode"),
                      validators: [
                        FormBuilderValidators.maxLength(300),
                        FormBuilderValidators.required(),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 16),
                      child: const Text(
                        'Contact Info',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    FormBuilderTextField(
                      attribute: "email",
                      decoration: InputDecoration(labelText: "*Email"),
                      validators: [
                        FormBuilderValidators.maxLength(300),
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ],
                    ),
                    FormBuilderTextField(
                      attribute: "phone",
                      decoration: InputDecoration(labelText: "*Phone"),
                      validators: [
                        FormBuilderValidators.maxLength(18),
                        FormBuilderValidators.required(),
                      ],
                    ),
                    FormBuilderTextField(
                      attribute: "website",
                      decoration: InputDecoration(labelText: "Website"),
                      validators: [
                        FormBuilderValidators.maxLength(300),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            /* END FORM */
          ],
        ),
      ),
    );
  }

  // Future makePostRequestOld() async {
  //   Coordinates coordinates = await calcLatLon();
  //   // String url = 'https://' +
  //   //     Provider.of<Store>(context, listen: false).getApi() +
  //   //     '/api/locations';

  //   Dio dio = new Dio();

  //   // var uri = Uri.http(Provider.of<Store>(context, listen: false).getApi(),
  //   //         '/api/locations/')
  //   //     .toString();

  //   var url = Provider.of<Store>(context, listen: false).uri.toString() +
  //       '/locations';

  //   print(url);
  //   //print(selectedTypeSetInt.toList());

  //   await dio.post(url, data: {
  //     'name': locationName,
  //     'description': description,
  //     'types': selectedTypes,
  //     'country': country,
  //     'region': region,
  //     'city': city,
  //     'street': street,
  //     'zip': zip,
  //     'lat': coordinates.latitude.toString(),
  //     'lon': coordinates.longitude.toString(),
  //     'email': email,
  //     'phone': phone,
  //     'website': website,
  //   });

  //   //print(response.statusMessage);
  //   // if you want to print, add 'var response =' before the await
  //   // print('Response status: ${response.statusCode}');
  //   // print('Response body: ${response.body}');
  //   // print(await http.read('https://creekmore.io/api/locations'));
  // }
}
