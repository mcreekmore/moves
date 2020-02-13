import '../app_theme.dart';
//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
//import 'package:http/http.dart' as http;
import 'package:geocoder/geocoder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moves/widgets/multi_select_dialogue.dart';
import 'package:dio/dio.dart';
//import 'dart:convert';

//import 'package:http/http.dart' as http;

class SuggestLocationScreen extends StatefulWidget {
  @override
  _SuggestLocationScreenState createState() => _SuggestLocationScreenState();
}

class _SuggestLocationScreenState extends State<SuggestLocationScreen> {
  @override
  void initState() {
    super.initState();
  }

  Color textInputColor = Color(0xFFb5cdfc);

  List<String> typesOfLocations = [
    'Restaurant',
    'Hotel',
    'Bar',
    'Cafe',
    'Music Venue',
    'Grocery',
    'Gas Station',
    'Bank',
    'Post Office',
    'Hospital',
  ];

  bool secondType = false;
  bool thirdType = false;

  DropdownButtonFormField androidDropDown(int index) {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String typeOfLocation in typesOfLocations) {
      var newItem = DropdownMenuItem(
        child: Text(typeOfLocation),
        value: typeOfLocation,
      );

      dropdownItems.add(newItem);
    }

    return DropdownButtonFormField(
      // decoration: const InputDecoration(
      //   labelText: '*Type',
      //   border: OutlineInputBorder(),
      // ),
      decoration: AppTheme().getInputDecorationTheme(
          labelText: "*Type", fillColor: Color(0xFFb5cdfc)),
      value: selectedType,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedTypeList[index] = value.toString();
          selectedTypeList.add(value.toString());
        });
      },
    );
    // return DropdownButton<String>(
    //   value: selectedType,
    //   items: dropdownItems,
    //   onChanged: (value) {
    //     setState(() {
    //       selectedType = value.toString();
    //     });
    //   },
    // );
  }

  CupertinoPicker iOSPicker(int index) {
    List<Text> pickerItems = [];

    for (String typeOfLocation in typesOfLocations) {
      pickerItems.add(Text(typeOfLocation));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (int selectedIndex) {
        //print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  Map<int, String> types = Map();
  List<String> selectedTypes = [];

  void _showMultiSelect(BuildContext context) async {
    final items = <MultiSelectDialogItem<int>>[
      MultiSelectDialogItem(1, 'Restaurant'),
      MultiSelectDialogItem(2, 'Hotel'),
      MultiSelectDialogItem(3, 'Bar'),
      MultiSelectDialogItem(4, 'Cafe'),
      MultiSelectDialogItem(5, 'Music Venue'),
      MultiSelectDialogItem(6, 'Grocery'),
      MultiSelectDialogItem(7, 'Gas Station'),
      MultiSelectDialogItem(8, 'Bank'),
      MultiSelectDialogItem(9, 'Post Office'),
      MultiSelectDialogItem(10, 'Hospital'),
    ];

    final selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: items,
          initialSelectedValues: [1].toSet(),
        );
      },
    );

    List<int> selectedValVarList = selectedValues.toList();

    for (var i = 0; i < selectedValVarList.length; i++) {
      if (selectedValVarList[i] == 1) {
        selectedTypes.add('Restaurant');
      } else if (selectedValVarList[i] == 2) {
        selectedTypes.add('Hotel');
      } else if (selectedValVarList[i] == 3) {
        selectedTypes.add('Bar');
      } else if (selectedValVarList[i] == 4) {
        selectedTypes.add('Cafe');
      } else if (selectedValVarList[i] == 5) {
        selectedTypes.add('Music Venue');
      } else if (selectedValVarList[i] == 6) {
        selectedTypes.add('Grocery');
      } else if (selectedValVarList[i] == 7) {
        selectedTypes.add('Gas Station');
      } else if (selectedValVarList[i] == 8) {
        selectedTypes.add('Bank');
      } else if (selectedValVarList[i] == 9) {
        selectedTypes.add('Post Office');
      } else if (selectedValVarList[i] == 10) {
        selectedTypes.add('Hospital');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(systemNavigationBarColor: Color(0xFFAAC6FC)));
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          //backgroundColor: AppTheme.nearlyWhite,
          backgroundColor: Color(0xFFAAC6FC),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                  ),
                  child:
                      Image.asset('assets/images/abstract-location-access.png'),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Suggest a New Location',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                /* Inputs start here */
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  child: const Text(
                    'Place',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                // Location Name
                Container(
                  padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
                  child: TextFormField(
                    controller: _locationController,
                    onChanged: (String name) {
                      locationName = name;
                    },
                    // decoration: const InputDecoration(
                    //   labelText: '*Location Name',
                    //   border: OutlineInputBorder(),
                    // ),
                    decoration: AppTheme().getInputDecorationTheme(
                      labelText: "*Location Name",
                      fillColor: textInputColor,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a';
                      }
                      return null;
                    },
                  ),
                ),
                // Description
                Container(
                  padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
                  child: TextField(
                    controller: _descriptionController,
                    maxLines: null,
                    onChanged: (String desc) {
                      description = desc;
                    },
                    // decoration: InputDecoration(
                    //   border: OutlineInputBorder(),
                    //   labelText: 'Description',
                    // ),
                    decoration: AppTheme().getInputDecorationTheme(
                      labelText: "Description",
                      fillColor: textInputColor,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              offset: const Offset(4, 4),
                              blurRadius: 8.0),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            _showMultiSelect(context);
                          },
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                // Icon(
                                //   Icons.share,
                                //   color: Colors.white,
                                //   size: 22,
                                // ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    'Add Type',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Contact Information
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  child: const Text(
                    'Location',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                // Country
                Container(
                  padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
                  child: TextFormField(
                    controller: _countryController,
                    onChanged: (String countryTyped) {
                      country = countryTyped;
                    },
                    // decoration: const InputDecoration(
                    //   labelText: '*Country',
                    //   border: OutlineInputBorder(),
                    // ),
                    decoration: AppTheme().getInputDecorationTheme(
                      labelText: "*Country",
                      fillColor: textInputColor,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                // Region
                Container(
                  padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
                  child: TextFormField(
                    controller: _regionController,
                    onChanged: (String regionTyped) {
                      region = regionTyped;
                    },
                    // decoration: const InputDecoration(
                    //   labelText: '*Region (State)',
                    //   border: OutlineInputBorder(),
                    // ),
                    decoration: AppTheme().getInputDecorationTheme(
                      labelText: "*Region (State)",
                      fillColor: textInputColor,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                // city
                Container(
                  padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
                  child: TextFormField(
                    controller: _cityController,
                    onChanged: (String cityTyped) {
                      city = cityTyped;
                    },
                    // decoration: const InputDecoration(
                    //   labelText: '*City',
                    //   border: OutlineInputBorder(),
                    // ),
                    decoration: AppTheme().getInputDecorationTheme(
                      labelText: "*City",
                      fillColor: textInputColor,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                // street
                Container(
                  padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
                  child: TextFormField(
                    controller: _streetController,
                    onChanged: (String streetTyped) {
                      street = streetTyped;
                    },
                    // decoration: const InputDecoration(
                    //   labelText: '*Street',
                    //   border: OutlineInputBorder(),
                    // ),
                    decoration: AppTheme().getInputDecorationTheme(
                      labelText: "*Street",
                      fillColor: textInputColor,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                // zip
                Container(
                  padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _zipController,
                    onChanged: (String zipTyped) {
                      zip = zipTyped;
                    },
                    // decoration: const InputDecoration(
                    //   labelText: '*Zip',
                    //   border: OutlineInputBorder(),
                    // ),
                    decoration: AppTheme().getInputDecorationTheme(
                      labelText: "*Zip",
                      fillColor: textInputColor,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),

                // Contact Line
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  child: const Text(
                    'Contact',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                // E-mail
                Container(
                  padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    onChanged: (String emailTyped) {
                      email = emailTyped;
                    },
                    // decoration: const InputDecoration(
                    //   labelText: '*E-mail',
                    //   border: OutlineInputBorder(),
                    // ),
                    decoration: AppTheme().getInputDecorationTheme(
                      labelText: "*Email",
                      fillColor: textInputColor,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                // Phone
                Container(
                  padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: _phoneController,
                    onChanged: (String phoneTyped) {
                      phone = phoneTyped;
                    },
                    // decoration: const InputDecoration(
                    //   labelText: '*Phone',
                    //   border: OutlineInputBorder(),
                    // ),
                    decoration: AppTheme().getInputDecorationTheme(
                      labelText: "*Phone",
                      fillColor: textInputColor,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                // Website
                Container(
                  padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.url,
                    controller: _websiteController,
                    onChanged: (String websiteTyped) {
                      website = websiteTyped;
                    },
                    // decoration: const InputDecoration(
                    //   labelText: 'Website',
                    //   border: OutlineInputBorder(),
                    // ),
                    decoration: AppTheme().getInputDecorationTheme(
                      labelText: "Website",
                      fillColor: textInputColor,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),

                // Buttons start here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  offset: const Offset(4, 4),
                                  blurRadius: 8.0),
                            ],
                          ),
                          // suggest button
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () async {
                                if (locationName == '' ||
                                    //selectedType == '' ||
                                    selectedTypeList == [] ||
                                    country == '' ||
                                    region == '' ||
                                    city == '' ||
                                    street == '' ||
                                    zip == '' ||
                                    email == '' ||
                                    phone == '') {
                                  setState(() {
                                    Alert(
                                      context: context,
                                      title: "Neccessary Fields Required",
                                      desc:
                                          "All fields marked with a * are required",
                                      image: Image.asset(
                                          "assets/images/error.png"),
                                    ).show();
                                  });
                                } else {
                                  //var res = await makePostRequest();

                                  setState(() {
                                    // cant tell if this works or not
                                    SpinKitDoubleBounce(
                                      color: Colors.blue,
                                      size: 30.0,
                                    );
                                  });

                                  await makePostRequest();
                                  //print(res);
                                  clearTextFields();

                                  setState(() {
                                    Alert(
                                      context: context,
                                      title: "Thank you!",
                                      desc:
                                          "Your suggested place has been successfully sent.",
                                      image: Image.asset(
                                          "assets/images/good-job.png"),
                                    ).show();
                                  });
                                }
                              },
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.send,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        'Suggest',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  offset: const Offset(4, 4),
                                  blurRadius: 8.0),
                            ],
                          ),
                          // clear button
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  clearTextFields();
                                });
                              },
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.cancel,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        'Clear',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  var _locationController = TextEditingController();
  var _descriptionController = TextEditingController();
  var _countryController = TextEditingController();
  var _regionController = TextEditingController();
  var _cityController = TextEditingController();
  var _streetController = TextEditingController();
  var _zipController = TextEditingController();
  var _emailController = TextEditingController();
  var _phoneController = TextEditingController();
  var _websiteController = TextEditingController();

  List<String> selectedTypeList = [];
  Set<int> selectedTypeSetInt = {};
  String selectedType = "Restaurant";
  String selectedType2 = '';
  String selectedType3 = '';
  String locationName = '';
  String description = '';
  String country = '';
  String region = '';
  String city = '';
  String street = '';
  String zip = '';
  String email = '';
  String phone = '';
  String website = '';

  void clearTextFields() {
    _locationController.clear();
    _descriptionController.clear();
    _countryController.clear();
    _regionController.clear();
    _cityController.clear();
    _streetController.clear();
    _zipController.clear();
    _emailController.clear();
    _phoneController.clear();
    _websiteController.clear();
  }

  dynamic calcLatLon() async {
    final query = "$street, $region $city";
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    //print("${first.featureName} : ${first.coordinates}");
    return first.coordinates;
  }

  Future makePostRequest() async {
    Coordinates coordinates = await calcLatLon();
    //print(coordinates.runtimeType);

    //var typesJson = json.encode({"types:", types});

    //var url = 'https://creekmore.io/api/locations';
    var url = 'http://10.0.2.2:3000/api/locations';
    // var response = await http.post(url, body: {
    //   'name': locationName,
    //   'description': description,
    //   //'types': types.toString(),
    //   'types': selectedTypeSetInt.toList(),
    //   'country': country,
    //   'region': region,
    //   'city': city,
    //   'street': street,
    //   'zip': zip,
    //   'lat': coordinates.latitude.toString(),
    //   'lon': coordinates.longitude.toString(),
    //   'email': email,
    //   'phone': phone,
    //   'website': website,
    // });

    Dio dio = new Dio();

    print(selectedTypeSetInt.toList());

    await dio.post(url, data: {
      'name': locationName,
      'description': description,
      //'types': types.toString(),
      //'types': selectedTypeSetInt.toList(),
      'types': selectedTypes,
      'country': country,
      'region': region,
      'city': city,
      'street': street,
      'zip': zip,
      'lat': coordinates.latitude.toString(),
      'lon': coordinates.longitude.toString(),
      'email': email,
      'phone': phone,
      'website': website,
    });

    //print(response.statusMessage);
    // if you want to print, add 'var response =' before the await
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    // print(await http.read('https://creekmore.io/api/locations'));
  }
}
