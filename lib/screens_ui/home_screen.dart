import 'package:flutter/material.dart';
import 'package:moves/widgets/messaging.dart';
import '../model/homelist.dart';
import 'package:provider/provider.dart';
import 'package:moves/store/store.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moves/screens_ui/suggest_location_screen.dart';
import 'package:moves/widgets/home_filter_bottom_sheet.dart';
import 'package:moves/theme_notifier.dart';
//import 'package:moves/screens/map_screen.dart';
import 'package:moves/screens_ui/manual_location.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

// coach
import 'package:tutorial_coach_mark/animated_focus_light.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:moves/screens/map_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController animationController;
  bool multiple = false;
  bool favoriteSelected = false;

  List<TargetFocus> targets = List();
  GlobalKey keyButton = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();
  GlobalKey keyButton3 = GlobalKey();
  GlobalKey keyButton4 = GlobalKey();
  GlobalKey keyButton5 = GlobalKey();

  @override
  void initState() {
    initTargets();
    firstLaunch();
    // calls API for list of locations
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  List<String> selectedCountList = [];

  bool visible = true;
  int bottomNavBarIndex = 0;

  // DONT TOUCH. this is a workaround for a delayed perimssion issue with iOS
  void firstLaunch() async {
    if (Platform.isIOS) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('firstLaunch')) {
        prefs.setBool('firstLaunch', false);
        setState(() {
          bottomNavBarIndex = 1;
          visible = false;
        });
      }
    }
  }

  void getPermission() async {
    PermissionStatus permission =
        await LocationPermissions().requestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    var kek = 1;
    // if (Provider.of<Store>(context, listen: false).firstLaunch) {
    //   bottomNavBarIndex = 1;
    // }
    //getPermission();
    void selectedIndex(int index) async {
      if (index == 0) {
        setState(() {
          bottomNavBarIndex = 0;
          visible = true;
        });
        bottomNavBarIndex = 0;
      } else if (index == 1) {
        setState(() {
          bottomNavBarIndex = 1;
          visible = false;
        });
      } else if (index == 2) {
        setState(() {
          bottomNavBarIndex = 2;
          visible = false;
        });
      }
    }

    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Padding(
                padding: const EdgeInsets.only(
                  left: 40.0,
                ),
                child: Text('Moves'),
              ),
              actions: <Widget>[
                // location
                InkWell(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height),
                  child: IconButton(
                    key: keyButton,
                    icon: Icon(
                      Icons.place,
                    ),
                    onPressed: () {
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                ManualLocation()),
                      ).then(
                        (val) async {
                          setState(() {
                            Provider.of<Store>(context, listen: false)
                                .getData();
                          });
                        },
                      );
                    },
                    tooltip: 'Manually change location',
                  ),
                ),
                // favorites
                InkWell(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height),
                  child: IconButton(
                    key: keyButton2,
                    icon: Icon(
                      favoriteSelected ? Icons.favorite : Icons.favorite_border,
                    ),
                    onPressed: () {
                      setState(() {
                        favoriteSelected = !favoriteSelected;
                      });
                    },
                    tooltip: 'Favorites',
                  ),
                ),
                // add
                InkWell(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height),
                  child: IconButton(
                    key: keyButton3,
                    icon: Icon(
                      Icons.add_circle_outline,
                      //color: AppTheme().getIconColor(),
                    ),
                    onPressed: () {
                      if (Provider.of<Store>(context, listen: false).userID !=
                          null) {
                        Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                SuggestLocationScreen(),
                          ),
                        );
                      } else {
                        if (Platform.isIOS) {
                          setState(
                            () {
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
                                        style:
                                            TextStyle(color: Colors.blueAccent),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          setState(
                            () {
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
                            },
                          );
                        }
                      }
                    },
                    tooltip: 'Add new location',
                  ),
                ),
                // tutorial
                InkWell(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height),
                  child: IconButton(
                    icon: Icon(
                      Icons.help_outline,
                    ),
                    onPressed: () {
                      showTutorial();
                    },
                    tooltip: 'Manually change location',
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                canvasColor:
                    Provider.of<ThemeNotifier>(context).getTheme() == darkTheme
                        ? Colors.black
                        : Colors.white,
              ),
              child: BottomNavigationBar(
                  //backgroundColor: AppTheme.nearlyWhite,
                  selectedItemColor: Colors.blueAccent,
                  selectedFontSize: 14,
                  //unselectedItemColor: Colors.grey.shade800,
                  unselectedFontSize: 12,
                  currentIndex: bottomNavBarIndex,
                  onTap: (int index) {
                    setState(() {
                      selectedIndex(index);
                    });
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.list,
                      ),
                      title: Text(
                        "List",
                      ),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.map),
                      title: Text('Map'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      title: Text(
                        'Profile',
                      ),
                    )
                  ]),
            ),
            floatingActionButton: Visibility(
              visible: visible,
              child: FloatingActionButton(
                  key: keyButton4,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.filter_list),
                  onPressed: () async {
                    setState(() async {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                HomeFilterBottomSheet()),
                      );
                    });
                    if (bottomNavBarIndex == 1) {
                      setState(() {
                        kek = 2;
                      });
                    }
                  }),
            ),
            body: bottomNavBarIndex == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16.0, left: 8, right: 8),
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(15),
                              hintText: 'Search'),
                          onChanged: (string) {
                            try {
                              setState(() {
                                Provider.of<Store>(context, listen: false)
                                    .filterLocations(string);
                              });
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder<bool>(
                          future: getData(),
                          builder: (BuildContext context,
                              AsyncSnapshot<bool> snapshot) {
                            if (!snapshot.hasData ||
                                Provider.of<Store>(context)
                                        .filteredLocations
                                        .length ==
                                    0) {
                              return SpinKitDoubleBounce(
                                color: Colors.blue,
                                size: 30.0,
                              );
                            } else {
                              return RefreshIndicator(
                                onRefresh: () async {
                                  setState(() {
                                    Provider.of<Store>(context, listen: false)
                                        .getData();
                                  });
                                },
                                child: ListView(
                                  padding: const EdgeInsets.only(
                                      top: 0, left: 12, right: 12),
                                  scrollDirection: Axis.vertical,
                                  children: List<Widget>.generate(
                                    Provider.of<Store>(context)
                                        .filteredLocations
                                        .length,
                                    (int index) {
                                      final int count =
                                          Provider.of<Store>(context)
                                              .filteredLocations
                                              .length;
                                      final Animation<double> animation =
                                          Tween<double>(begin: 0.0, end: 1.0)
                                              .animate(
                                        CurvedAnimation(
                                          parent: animationController,
                                          curve: Interval(
                                              (1 / count) * index, 1.0,
                                              curve: Curves.fastOutSlowIn),
                                        ),
                                      );
                                      animationController.forward();
                                      return HomeListView(
                                        animation: animation,
                                        animationController:
                                            animationController,
                                        listData: Provider.of<Store>(context)
                                            .filteredLocations[index],
                                        callBack: () {
                                          setState(() {
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                          });

                                          Navigator.push<dynamic>(
                                            context,
                                            MaterialPageRoute<dynamic>(
                                              builder: (BuildContext context) =>
                                                  Provider.of<Store>(context)
                                                      .filteredLocations[index]
                                                      .navigateScreen,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  )
                : bottomNavBarIndex == 1
                    ? MapScreen(
                        kek: kek,
                      )
                    // ? Container()
                    : MessagingWidget(),
            // Container(
            //     child: Center(
            //       child: Text('Profile Coming Soon'),
            //     ),
            //   ),
          );
        }
      },
    );
    //);
  }

  void initTargets() {
    targets.add(TargetFocus(
      identify: "Target 1",
      keyTarget: keyButton,
      contents: [
        ContentTarget(
            align: AlignContent.bottom,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Manually set your own location",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Don't want to grant us access to your location? No problem! Set your location manually wherever you want.",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.RRect,
    ));
    targets.add(TargetFocus(
      identify: "Target 2",
      keyTarget: keyButton2,
      contents: [
        ContentTarget(
            align: AlignContent.bottom,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Favorited places",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Toggle between all locations and only your favorites (requires sign in)",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.RRect,
    ));
    targets.add(TargetFocus(
      identify: "Target 3",
      keyTarget: keyButton3,
      contents: [
        ContentTarget(
            align: AlignContent.bottom,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Suggest a new place",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Are we missing somewhere? Here is where you can suggest a new place to be added (requries sign in)",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.RRect,
    ));
    targets.add(TargetFocus(
      identify: "Target 4",
      keyTarget: keyButton4,
      contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "Filter places by type",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.Circle,
    ));
  }

  void showTutorial() {
    TutorialCoachMark(context,
        targets: targets,
        colorShadow: Colors.blue[900],
        textSkip: "SKIP",
        paddingFocus: 10,
        opacityShadow: 0.8, finish: () {
      //print("finish");
    }, clickTarget: (target) {
      //print(target);
    }, clickSkip: () {
      //print("skip");
    })
      ..show();
  }

  void _afterLayout(_) {
    Future.delayed(Duration(milliseconds: 100), () {
      showTutorial();
    });
  }
}

class HomeListView extends StatelessWidget {
  const HomeListView(
      {Key key,
      this.listData,
      this.callBack,
      this.animationController,
      this.animation})
      : super(key: key);

  final HomeListItem listData;
  final VoidCallback callBack;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  Widget iconTypeGetter(String type) {
    if (type == 'Restaurant') {
      return CircleAvatar(
        backgroundColor: Colors.blueAccent,
        child: Icon(
          Icons.local_dining,
          color: Colors.white,
        ),
      );
    } else if (type == 'Hotel') {
      return CircleAvatar(
        backgroundColor: Colors.indigo,
        child: Icon(
          Icons.local_hotel,
          color: Colors.white,
        ),
      );
    } else if (type == 'Bar') {
      return CircleAvatar(
        backgroundColor: Colors.orange,
        child: Icon(
          Icons.local_bar,
          color: Colors.white,
        ),
      ); // orange
    } else if (type == 'Cafe') {
      return CircleAvatar(
        backgroundColor: Colors.teal,
        child: Icon(
          Icons.local_cafe,
          color: Colors.white,
        ),
      );
    } else if (type == 'Music Venue') {
      return CircleAvatar(
        backgroundColor: Colors.purple,
        child: Icon(
          Icons.music_note,
          color: Colors.white,
        ),
      );
    } else if (type == 'Grocery') {
      return CircleAvatar(
        backgroundColor: Colors.green,
        child: Icon(
          Icons.local_grocery_store,
          color: Colors.white,
        ),
      );
    } else if (type == 'Gas Station') {
      return CircleAvatar(
        backgroundColor: Colors.brown,
        child: Icon(
          Icons.local_gas_station,
          color: Colors.white,
        ),
      ); // brown
    } else if (type == 'Bank') {
      return CircleAvatar(
        backgroundColor: Colors.deepOrangeAccent,
        child: Icon(
          Icons.attach_money,
          color: Colors.white,
        ),
      );
    } else if (type == 'Post Office') {
      return CircleAvatar(
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.local_post_office,
          color: Colors.white,
        ),
      );
    } else if (type == 'Hospital') {
      return CircleAvatar(
        backgroundColor: Colors.redAccent,
        child: Icon(
          Icons.local_hospital,
          color: Colors.white,
        ),
      );
    } else if (type == 'Pharmacy') {
      return CircleAvatar(
        backgroundColor: Colors.redAccent,
        child: Icon(
          Icons.local_pharmacy,
          color: Colors.white,
        ),
      ); // red
    } else {
      return CircleAvatar(
        backgroundColor: Colors.blueAccent,
        child: Icon(
          Icons.location_on,
          color: Colors.white,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  onTap: callBack,
                  leading: iconTypeGetter(
                    listData.location.types[0],
                  ),
                  title: Text("${listData.location.name}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        //TODO add country selector
                        '${listData.location.street}, ${listData.location.region}, ${listData.location.country}',
                        // style: TextStyle(
                        //     color: Colors.black.withOpacity(.4), fontSize: 13),
                        maxLines: 1,
                      ),
                      Text(
                        '${listData.location.distance.round()} mi',
                        // style: TextStyle(
                        //     color: Colors.black.withOpacity(.4), fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Divider(),
              ],
            ),
          ),
        );
      },
    );
  }
}
