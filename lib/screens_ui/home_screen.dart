import 'package:moves/app_theme.dart';
import 'package:flutter/material.dart';
import '../model/homelist.dart';
import 'package:provider/provider.dart';
import 'package:moves/store/store.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moves/screens_ui/suggest_location_screen.dart';
import 'package:moves/widgets/home_filter_bottom_sheet.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController animationController;
  bool multiple = false;
  bool favoriteSelected = false;

  @override
  void initState() {
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
  int bottomNavBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    void selectedIndex(int index) async {
      if (index == 0) {
        bottomNavBarIndex = 0;
      } else if (index == 1) {
        bottomNavBarIndex = 1;
      } else if (index == 2) {
        bottomNavBarIndex = 2;
      }
    }

    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
                backgroundColor: AppTheme.nearlyWhite,
                selectedItemColor: Colors.blueAccent,
                selectedFontSize: 14,
                unselectedItemColor: Colors.grey.shade800,
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
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.filter_list),
                onPressed: () {
                  setState(() {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    showBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return HomeFilterBottomSheet();
                        });
                  });
                }),
            body: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  appBar(),
                  // search bar
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 16.0, left: 8, right: 8),
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
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
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
                            child: GridView(
                              padding: const EdgeInsets.only(
                                  top: 0, left: 12, right: 12),
                              //physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              children: List<Widget>.generate(
                                Provider.of<Store>(context)
                                    .filteredLocations
                                    .length,
                                (int index) {
                                  final int count = Provider.of<Store>(context)
                                      .filteredLocations
                                      .length;
                                  final Animation<double> animation =
                                      Tween<double>(begin: 0.0, end: 1.0)
                                          .animate(
                                    CurvedAnimation(
                                      parent: animationController,
                                      curve: Interval((1 / count) * index, 1.0,
                                          curve: Curves.fastOutSlowIn),
                                    ),
                                  );
                                  animationController.forward();
                                  return HomeListView(
                                    animation: animation,
                                    animationController: animationController,
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
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                //crossAxisCount: multiple ? 2 : 1,
                                crossAxisCount: 1,
                                //mainAxisSpacing: 12.0,
                                crossAxisSpacing: 12.0,
                                childAspectRatio:
                                    5, // this changes the card size
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
    //);
  }

  Widget appBar() {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Expanded(
            child: Padding(
              // add center here to return to original
              padding: const EdgeInsets.only(top: 8, left: 16),
              child: Text(
                'Moves',
                style: TextStyle(
                  fontSize: 22,
                  color: AppTheme().getTextColor(),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Container(
              //width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  // favorites
                  Material(
                    child: InkWell(
                      borderRadius:
                          BorderRadius.circular(AppBar().preferredSize.height),
                      child: IconButton(
                        icon: Icon(
                          favoriteSelected
                              ? Icons.favorite
                              : Icons.favorite_border,
                          //Icons.favorite_border,
                          color: AppTheme().getIconColor(),
                        ),
                        onPressed: () {
                          setState(() {
                            favoriteSelected = !favoriteSelected;
                          });
                        },
                        tooltip: 'Favorites',
                      ),
                    ),
                  ),
                  // refresh
                  // Material(
                  //   child: InkWell(
                  //     borderRadius:
                  //         BorderRadius.circular(AppBar().preferredSize.height),
                  //     child: IconButton(
                  //       icon: Icon(
                  //         Icons.refresh,
                  //         color: AppTheme().getIconColor(),
                  //       ),
                  //       onPressed: () {
                  //         setState(() {
                  //           Provider.of<Store>(context, listen: false)
                  //               .getData();
                  //         });
                  //       },
                  //       tooltip: 'Refresh',
                  //     ),
                  //   ),
                  // ),
                  // add
                  Material(
                    child: InkWell(
                      borderRadius:
                          BorderRadius.circular(AppBar().preferredSize.height),
                      child: IconButton(
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: AppTheme().getIconColor(),
                        ),
                        onPressed: () {
                          Navigator.push<dynamic>(
                            context,
                            MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) =>
                                    SuggestLocationScreen()),
                          );
                        },
                        tooltip: 'Add New Location',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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

  Icon iconTypeGetter(String type) {
    if (type == 'Restaurant') {
      return Icon(
        Icons.local_dining,
        color: Colors.blue,
      );
    } else if (type == 'Hotel') {
      return Icon(
        Icons.local_hotel,
        color: Colors.blueAccent,
      );
    } else if (type == 'Bar') {
      return Icon(
        Icons.local_bar,
        color: Colors.orange,
      ); // orange
    } else if (type == 'Cafe') {
      return Icon(
        Icons.local_cafe,
        color: Colors.teal,
      );
    } else if (type == 'Music Venue') {
      return Icon(
        Icons.music_note,
        color: Colors.purple,
      );
    } else if (type == 'Grocery') {
      return Icon(
        Icons.local_grocery_store,
        color: Colors.green,
      );
    } else if (type == 'Gas Station') {
      return Icon(
        Icons.local_gas_station,
        color: Colors.brown,
      ); // brown
    } else if (type == 'Bank') {
      return Icon(
        Icons.attach_money,
        color: Colors.grey,
      );
    } else if (type == 'Post Office') {
      return Icon(
        Icons.local_post_office,
        color: Colors.blueAccent,
      );
    } else if (type == 'Hospital') {
      return Icon(
        Icons.local_hospital,
        color: Colors.redAccent,
      );
    } else if (type == 'Pharmacy') {
      return Icon(
        Icons.local_pharmacy,
        color: Colors.redAccent,
      ); // red
    } else {
      return Icon(
        Icons.location_on,
        color: Colors.blueAccent,
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
                        style: TextStyle(
                            color: Colors.black.withOpacity(.4), fontSize: 13),
                        maxLines: 1,
                      ),
                      Text(
                        '${listData.location.distance} mi',
                        style: TextStyle(
                            color: Colors.black.withOpacity(.4), fontSize: 13),
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
