import 'package:flutter/material.dart';
import 'package:moves/model/location_loaded_model.dart';
import 'package:moves/themes/location_theme.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:moves/screens_ui/type_screens/bar.dart';
import 'package:moves/screens_ui/type_screens/grocery.dart';
import 'package:moves/screens_ui/type_screens/gas_station.dart';
import 'package:moves/screens_ui/type_screens/pharmacy.dart';
import 'package:moves/screens_ui/type_screens/restaurant.dart';
import 'package:moves/screens_ui/type_screens/bank.dart';
import 'package:moves/screens_ui/type_screens/cafe.dart';
import 'package:moves/screens_ui/type_screens/hotel.dart';
import 'package:moves/screens_ui/type_screens/music_venue.dart';
import 'package:moves/screens_ui/type_screens/post_office.dart';
import 'package:provider/provider.dart';
import 'package:moves/store/store.dart';
import 'package:moves/widgets/bottom_sheet.dart';
import 'package:moves/theme_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:moves/model/favorite.dart';
//import 'package:flutter/cupertino.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({@required this.location});

  final LocationLoadedModel location;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  static LocationLoadedModel location = location;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  bool favoriteSelected = false;
  @override
  void initState() {
    setData();
    super.initState();
  }

  Future<void> setData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  bool multiple = false;
  //bool favoriteSelected = false;

  // GOOGLE MAPS URL LAUNCHING
  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  Future reportLocation() async {
    print('Reporting Location: ${widget.location.id}');

    String url = Provider.of<Store>(context, listen: false).getHttp() +
        Provider.of<Store>(context, listen: false).getApi() +
        '/api/locations/report';

    Dio dio = new Dio();

    Object body = {"id": widget.location.id};

    print(body);
    body = jsonEncode(body);

    await dio.post(url, data: body);
  }

  @override
  Widget build(BuildContext context) {
    for (Favorite favorite in Provider.of<Store>(context).favorites) {
      //print(favorite.getPlaceID());

      if (favorite.getPlaceID() == widget.location.id) {
        setState(() {
          favoriteSelected = true;
        });
        break;
      }
      setState(() {
        favoriteSelected = false;
      });
    }

    //print(favoriteSelected);
    var expandedHeight = 128.0;
    final GlobalKey<State> _key = GlobalKey<State>();

    void toggleFavorite() async {
      if (!favoriteSelected) {
        await Provider.of<Store>(context, listen: false)
            .addToFavorites(
              widget.location.id,
            )
            .then(
              (value) => setState(() {
                favoriteSelected = !favoriteSelected;
              }),
            );
      } else {
        Provider.of<Store>(context, listen: false)
            .deleteFromFavorites(
              widget.location.id,
            )
            .then(
              (value) => setState(() {
                favoriteSelected = !favoriteSelected;
              }),
            );
      }
    }

    // void showSnackBar(context) {
    //   SnackBar snackBar = SnackBar(
    //     content: Row(
    //       children: <Widget>[
    //         Text('SUCCESS: ', style: TextStyle(color: Colors.greenAccent)),
    //         Text('Report was sent'),
    //       ],
    //     ),
    //   );
    //   //Scaffold.of(_key.currentContext).showSnackBar(snackBar);
    // }

    return Container(
      color: Provider.of<ThemeNotifier>(context, listen: false).getTheme() ==
              darkTheme
          ? Colors.black
          : Colors.white,
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: Builder(
            builder: (BuildContext context) {
              return FloatingActionButton(
                onPressed: () {
                  if (Provider.of<Store>(context, listen: false).userID !=
                      null) {
                    showBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return BottomSheetWidget(location: widget.location);
                      },
                    );
                  } else {
                    if (Platform.isIOS) {
                      setState(() {
                        showCupertinoDialog(
                          context: context,
                          builder: (_) => CupertinoAlertDialog(
                            title: Text('Not Signed In'),
                            content: Text(
                              'You must be signed in to use this feature',
                            ),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Okay',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      });
                    } else {
                      setState(() {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text('Not Signed In'),
                            content: Text(
                              'You must be signed in to use this feature',
                            ),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Okay'),
                              ),
                            ],
                          ),
                        );
                      });
                    }
                  }

                  // Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => BottomSheetWidget(location: widget.location),),);
                },
                //backgroundColor: LocationTheme.nearlyBlue,
                backgroundColor: Colors.blueAccent,
                child: Icon((Icons.add)),
              );
            },
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              setState(() {
                Provider.of<Store>(context, listen: false)
                    .getData(favorite: false, filterBarEnum: null);
              });
            },
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  brightness: Brightness.light,
                  pinned: true,
                  expandedHeight: expandedHeight,
                  //backgroundColor: AppTheme.nearlyWhite,
                  //iconTheme: IconThemeData(color: AppTheme.darkText),
                  flexibleSpace: FlexibleSpaceBar(
                    title: Container(
                      constraints: BoxConstraints(
                        //minWidth: 100,
                        maxWidth: MediaQuery.of(context).size.width * .85,
                      ),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          '${widget.location.name}',
                          style: TextStyle(
                            //fontSize: 22,
                            //color: AppTheme.darkText,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: favoriteSelected
                          ? Icon(Icons.favorite)
                          : Icon(Icons.favorite_border),
                      tooltip: 'Add to favorites',
                      //color: AppTheme.darkText,
                      onPressed: () {
                        toggleFavorite();
                      },
                    ),
                  ],
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, i) {
                      return Container(
                        decoration: BoxDecoration(
                            //color: AppTheme.nearlyWhite,
                            ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: SingleChildScrollView(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        bottom: 8,
                                        top: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[],
                                    ),
                                  ),
                                  Card(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListTile(
                                            leading: Icon(
                                              Icons.my_location,
                                              color: Colors.blueAccent,
                                            ),
                                            title:
                                                Text('${widget.location.name}'),
                                            subtitle: Text(
                                                '${widget.location.street}, ${widget.location.region}, ${widget.location.country}, ${widget.location.zip}'),
                                          ),
                                        ),
                                        ButtonBar(
                                          children: <Widget>[
                                            Container(
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 20,
                                                            left: 20),
                                                    child: Text(
                                                      '${widget.location.distance} mi',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w200,
                                                        fontSize: 22,
                                                        letterSpacing: 0.27,
                                                        // color: LocationTheme
                                                        //     .nearlyBlue,
                                                        color:
                                                            Colors.blueAccent,
                                                      ),
                                                    ),
                                                  ),
                                                  FlatButton(
                                                    shape:
                                                        new RoundedRectangleBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                        .circular(
                                                                    30.0)),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5),
                                                      child: Text(
                                                        'NAVIGATE',
                                                        style: TextStyle(
                                                            //color: Colors.white,
                                                            ),
                                                      ),
                                                    ),
                                                    //color: LocationTheme.nearlyBlue,
                                                    color: Colors.blueAccent,
                                                    // splashColor: Colors.white
                                                    //     .withOpacity(0.3),
                                                    onPressed: () {
                                                      openMap(
                                                          widget.location.lat,
                                                          widget.location.lon);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.people,
                                      //color: Colors.blueGrey,
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                              "${widget.location.updateInfo["location_update_info"]["update_count_hour"] ?? 0} user updates in the last hour"),
                                          Text(
                                              "${widget.location.updateInfo["location_update_info"]["update_count_day"] ?? 0} user updates in the last day")
                                        ],
                                      ),
                                    ),
                                  ),

                                  /* optional pages toggle here based on type */
                                  widget.location.types.contains('Bar')
                                      ? Bar(
                                          location: widget.location,
                                        )
                                      : Container(),
                                  widget.location.types.contains('Restaurant')
                                      ? Restaurant(
                                          location: widget.location,
                                        )
                                      : Container(),
                                  widget.location.types.contains('Cafe')
                                      ? Cafe(
                                          location: widget.location,
                                        )
                                      : Container(),
                                  widget.location.types.contains('Hotel')
                                      ? Hotel(
                                          location: widget.location,
                                        )
                                      : Container(),
                                  widget.location.types.contains('Music Venue')
                                      ? MusicVenue(
                                          location: widget.location,
                                        )
                                      : Container(),
                                  widget.location.types.contains('Grocery')
                                      ? Grocery(
                                          location: widget.location,
                                        )
                                      : Container(),
                                  widget.location.types.contains('Gas Station')
                                      ? GasStation(
                                          location: widget.location,
                                        )
                                      : Container(),
                                  widget.location.types.contains('Bank')
                                      ? Bank(
                                          location: widget.location,
                                        )
                                      : Container(),
                                  widget.location.types.contains('Post Office')
                                      ? PostOffice(
                                          location: widget.location,
                                        )
                                      : Container(),
                                  widget.location.types.contains('Hospital')
                                      ? Bar(
                                          location: widget.location,
                                        )
                                      : Container(),
                                  widget.location.types.contains('Pharmacy')
                                      ? Pharmacy(
                                          location: widget.location,
                                        )
                                      : Container(),

                                  /* basic info */
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16.0, bottom: 8),
                                    child: Center(
                                      child: Text('Basic Info'),
                                    ),
                                  ),
                                  Divider(),
                                  ListTile(
                                    leading: Icon(
                                      Icons.event_available,
                                      color: Colors.green,
                                    ),
                                    title: Text('Open'),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        widget.location.updateInfo[
                                                        "location_update_info"]
                                                    ["open_hour_percent"] !=
                                                null
                                            ? Text(
                                                '${widget.location.updateInfo["location_update_info"]["open_hour_percent"]}% reported Yes (Last Hour)')
                                            : Text(
                                                'No users reported in last hour'),
                                        widget.location.updateInfo[
                                                        "location_update_info"]
                                                    ["open_day_percent"] !=
                                                null
                                            ? Text(
                                                '${widget.location.updateInfo["location_update_info"]["open_day_percent"]}% reported Yes (Last Day)')
                                            : Text(
                                                'No users reported in last day'),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  ListTile(
                                    leading: Icon(
                                      Icons.description,
                                      color: Colors.indigoAccent,
                                    ),
                                    title: Text('Description'),
                                    subtitle: widget.location.description !=
                                            null
                                        ? Text('${widget.location.description}')
                                        : Text('No description'),
                                  ),
                                  Divider(),
                                  ListTile(
                                    leading: Icon(
                                      Icons.web,
                                      color: Colors.redAccent,
                                    ),
                                    title: Text('Website'),
                                    onTap: () => {
                                      if (widget.location.website != null)
                                        {launch('${widget.location.website}')}
                                    },
                                    subtitle: widget.location.website != null
                                        ? Text('${widget.location.website}')
                                        : Text('No Website Added'),
                                  ),
                                  Divider(),
                                  ListTile(
                                    leading: Icon(
                                      Icons.phone,
                                      color: Colors.blue,
                                    ),
                                    title: Text('Phone'),
                                    onTap: () =>
                                        launch('tel:${widget.location.phone}'),
                                    subtitle: widget.location.phone != null
                                        ? Text('${widget.location.phone}')
                                        : Text('No Phone Added'),
                                  ),
                                  Divider(),
                                  ListTile(
                                    leading: Icon(
                                      Icons.email,
                                      color: Colors.amber,
                                    ),
                                    onTap: () => launch(
                                        'mailto:${widget.location.email}?subject=Email From Moves App&body='),
                                    title: Text('Email'),
                                    subtitle: widget.location.email != ""
                                        ? Text('${widget.location.email}')
                                        : Text('No Email Added'),
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: Platform.isIOS
                                        ? CupertinoButton(
                                            key: _key,
                                            color: Colors.redAccent,
                                            onPressed: () {
                                              setState(
                                                () {
                                                  showCupertinoDialog(
                                                    context: context,
                                                    builder: (_) =>
                                                        CupertinoAlertDialog(
                                                      title: Text(
                                                          'Report Location'),
                                                      content: Text(
                                                          'Are you sure you would like to report this location for innapropriate content?'),
                                                      actions: <Widget>[
                                                        CupertinoDialogAction(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text(
                                                            'No',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .redAccent),
                                                          ),
                                                        ),
                                                        CupertinoDialogAction(
                                                          onPressed: () {
                                                            reportLocation();
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            setState(
                                                              () {
                                                                showCupertinoDialog(
                                                                  context:
                                                                      context,
                                                                  builder: (_) =>
                                                                      CupertinoAlertDialog(
                                                                    title: Text(
                                                                        'Successfully Reported'),
                                                                    content: Text(
                                                                        'This location has been reported for innapropriate content.'),
                                                                    actions: <
                                                                        Widget>[
                                                                      CupertinoDialogAction(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'Okay',
                                                                          style:
                                                                              TextStyle(color: Colors.blueAccent),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child: Text(
                                                            'Yes',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blueAccent),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Text('REPORT THIS LOCATION'))
                                        : FlatButton(
                                            color: Colors.redAccent,
                                            onPressed: () {
                                              setState(
                                                () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (_) => AlertDialog(
                                                      title: Text(
                                                          'Report Location'),
                                                      content: Text(
                                                          'Are you sure you would like to report this location for innapropriate content?'),
                                                      actions: <Widget>[
                                                        FlatButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text(
                                                            'No',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .redAccent),
                                                          ),
                                                        ),
                                                        FlatButton(
                                                          onPressed: () {
                                                            reportLocation();
                                                            // showSnackBar(
                                                            //     context);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();

                                                            setState(() {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder: (_) =>
                                                                    AlertDialog(
                                                                  title: Text(
                                                                      'Sucessfully Reported'),
                                                                  content: Text(
                                                                      'This location has been reported for innapropriate content.'),
                                                                  actions: <
                                                                      Widget>[
                                                                    FlatButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        'Okay',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.blueAccent),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            });
                                                          },
                                                          child: Text(
                                                            'Yes',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blueAccent),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child:
                                                Text('REPORT THIS LOCATION')),
                                  ),
                                  SizedBox(
                                    height: 75,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
