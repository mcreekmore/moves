import '../app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:moves/store/store.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'dart:convert';

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
    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

    SnackBar snackBar = SnackBar(
      content: Text('Location Suggestion Sent Successfully'),
    );

    dynamic calcLatLon() async {
      print('street: ' + _fbKey.currentState.value["street"]);
      String street = _fbKey.currentState.value["street"].toString();
      String region = _fbKey.currentState.value["region"].toString();
      String city = _fbKey.currentState.value["city"].toString();
      final query = "$street, $city $region ";
      var addresses = await Geocoder.local
          .findAddressesFromQuery(query); //TODO fix geocoder null error
      var first = addresses.first;
      return first.coordinates;
    }

    Future makePostRequest(dynamic body) async {
      String url = Provider.of<Store>(context, listen: false).getApi() +
          '/api/locations';

      Coordinates coordinates = await calcLatLon();
      print("coordinates: " + coordinates.toString());

      Dio dio = new Dio();

      print(body.toString());

      var response = await dio.post(url, data: jsonEncode(body));

      print(response.statusMessage);
    }

    void selectedIndex(int index) async {
      if (index == 0) {
        // Submit
        if (_fbKey.currentState.saveAndValidate()) {
          await makePostRequest(_fbKey.currentState.value);

          Scaffold.of(_fbKey.currentContext).showSnackBar(snackBar);
        }
      } else if (index == 1) {
        // Reset
        _fbKey.currentState.reset();
      } else if (index == 2) {
        // Close
        Navigator.pop(context);
      }
    }

    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
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
            ],
          ),
          backgroundColor: AppTheme.nearlyWhite,
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 32),
                  child: FormBuilder(
                    key: _fbKey,
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
                          decoration:
                              InputDecoration(labelText: "*Location Name"),
                          validators: [
                            FormBuilderValidators.maxLength(100),
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
                          ],
                        ),
                        FormBuilderTextField(
                          attribute: "region",
                          decoration:
                              InputDecoration(labelText: "*Region (State)"),
                          validators: [
                            FormBuilderValidators.maxLength(300),
                          ],
                        ),
                        FormBuilderTextField(
                          attribute: "city",
                          decoration: InputDecoration(labelText: "*City"),
                          validators: [
                            FormBuilderValidators.maxLength(300),
                          ],
                        ),
                        FormBuilderTextField(
                          attribute: "street",
                          decoration: InputDecoration(labelText: "*Street"),
                          validators: [
                            FormBuilderValidators.maxLength(300),
                          ],
                        ),
                        FormBuilderTextField(
                          attribute: "zip",
                          decoration: InputDecoration(labelText: "*Zipcode"),
                          validators: [
                            FormBuilderValidators.maxLength(300),
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
                          ],
                        ),
                        FormBuilderTextField(
                          attribute: "phone",
                          decoration: InputDecoration(labelText: "*Phone"),
                          validators: [
                            FormBuilderValidators.maxLength(18),
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
