import '../app_theme.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SuggestLocationScreen extends StatefulWidget {
  @override
  _SuggestLocationScreenState createState() => _SuggestLocationScreenState();
}

class _SuggestLocationScreenState extends State<SuggestLocationScreen> {
  @override
  void initState() {
    super.initState();
  }

  List<String> typesOfLocations = [
    'Restaurant',
    'Hotel',
    'Bar',
    'Coffee',
    'Bank',
    'Post Office',
    'Gas Station',
    'Grocery',
    'Hospital',
  ];

  DropdownButtonFormField androidDropDown() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String typeOfLocation in typesOfLocations) {
      var newItem = DropdownMenuItem(
        child: Text(typeOfLocation),
        value: typeOfLocation,
      );

      dropdownItems.add(newItem);
    }

    return DropdownButtonFormField(
      decoration: const InputDecoration(
        labelText: '*Type',
        border: OutlineInputBorder(),
      ),
      value: selectedType,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedType = value.toString();
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

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];

    for (String typeOfLocation in typesOfLocations) {
      pickerItems.add(Text(typeOfLocation));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (int selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItems,
    );
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
                    decoration: const InputDecoration(
                      labelText: '*Location Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
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
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description',
                    ),
                  ),
                ),
                // Type
                Container(
                  padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
                  child: Platform.isIOS ? iOSPicker() : androidDropDown(),
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
                    decoration: const InputDecoration(
                      labelText: '*Country',
                      border: OutlineInputBorder(),
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
                    decoration: const InputDecoration(
                      labelText: '*Region (State)',
                      border: OutlineInputBorder(),
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
                    decoration: const InputDecoration(
                      labelText: '*City',
                      border: OutlineInputBorder(),
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
                    decoration: const InputDecoration(
                      labelText: '*Street',
                      border: OutlineInputBorder(),
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
                    controller: _zipController,
                    onChanged: (String zipTyped) {
                      zip = zipTyped;
                    },
                    decoration: const InputDecoration(
                      labelText: '*Zip',
                      border: OutlineInputBorder(),
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
                    controller: _emailController,
                    onChanged: (String emailTyped) {
                      email = emailTyped;
                    },
                    decoration: const InputDecoration(
                      labelText: '*E-mail',
                      border: OutlineInputBorder(),
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
                    controller: _phoneController,
                    onChanged: (String phoneTyped) {
                      phone = phoneTyped;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(),
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
                    controller: _websiteController,
                    onChanged: (String websiteTyped) {
                      website = websiteTyped;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Website',
                      border: OutlineInputBorder(),
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
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                setState(() {
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
                                  Alert(
                                    context: context,
                                    title: "Thank you!",
                                    desc:
                                        "Your suggested place has been successfully sent.",
                                    image: Image.asset(
                                        "assets/images/good-job.png"),
                                  ).show();
                                });
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
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                setState(() {
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

  String selectedType = "Restaurant";
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
}
