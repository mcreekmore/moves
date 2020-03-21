import 'package:moves/app_theme.dart';
import 'package:flutter/material.dart';
import '../model/homelist.dart';
import 'package:provider/provider.dart';
import 'package:moves/store/store.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moves/screens_ui/suggest_location_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                appBar(),
                Expanded(
                  child: FutureBuilder<bool>(
                    future: getData(),
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (!snapshot.hasData ||
                          Provider.of<Store>(context).homeList.length == 0) {
                        return SpinKitDoubleBounce(
                          color: Colors.blue,
                          size: 30.0,
                        );
                      } else {
                        return GridView(
                          padding: const EdgeInsets.only(
                              top: 0, left: 12, right: 12),
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          children: List<Widget>.generate(
                            Provider.of<Store>(context).homeList.length,
                            (int index) {
                              final int count =
                                  Provider.of<Store>(context).homeList.length;
                              final Animation<double> animation =
                                  Tween<double>(begin: 0.0, end: 1.0).animate(
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
                                listData:
                                    Provider.of<Store>(context).homeList[index],
                                callBack: () {
                                  Navigator.push<dynamic>(
                                    context,
                                    MaterialPageRoute<dynamic>(
                                      builder: (BuildContext context) =>
                                          Provider.of<Store>(context)
                                              .homeList[index]
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
                            mainAxisSpacing: 12.0,
                            crossAxisSpacing: 12.0,
                            childAspectRatio: 5, // this changes the card size
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
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
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
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
                    color: Colors.transparent,
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
                            // Provider.of<Store>(context, listen: false)
                            //     .getData();
                          });
                        },
                        tooltip: 'Favorites',
                      ),
                    ),
                  ),
                  // refresh
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius:
                          BorderRadius.circular(AppBar().preferredSize.height),
                      child: IconButton(
                        icon: Icon(
                          Icons.refresh,
                          color: AppTheme().getIconColor(),
                        ),
                        onPressed: () {
                          setState(() {
                            Provider.of<Store>(context, listen: false)
                                .getData();
                          });
                        },
                        tooltip: 'Refresh',
                      ),
                    ),
                  ),
                  // add
                  Material(
                    color: Colors.transparent,
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

  final HomeList listData;
  final VoidCallback callBack;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  Icon iconTypeGetter(String type) {
    if (type == 'Restaurant') {
      return Icon(Icons.local_dining);
    } else if (type == 'Hotel') {
      return Icon(Icons.local_hotel);
    } else if (type == 'Bar') {
      return Icon(Icons.local_bar);
    } else if (type == 'Cafe') {
      return Icon(Icons.local_cafe);
    } else if (type == 'Music Venue') {
      return Icon(Icons.music_note);
    } else if (type == 'Grocery') {
      return Icon(Icons.local_grocery_store);
    } else if (type == 'Gas Station') {
      return Icon(Icons.local_gas_station);
    } else if (type == 'Bank') {
      return Icon(Icons.attach_money);
    } else if (type == 'Post Office') {
      return Icon(Icons.local_post_office);
    } else if (type == 'Hospital') {
      return Icon(Icons.local_hospital);
    } else if (type == 'Pharmacy') {
      return Icon(Icons.local_pharmacy);
    } else {
      return Icon(Icons.location_on);
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
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              child: Container(
                color: Colors.blue[50],
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Positioned(
                      left: 20,
                      child: iconTypeGetter(listData.location.types[0]),
                    ),
                    Positioned(
                      left: 65,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${listData.location.name}'),
                          Text(
                            //TODO add country selector
                            '${listData.location.street}, ${listData.location.region}, ${listData.location.country}',
                            style: TextStyle(
                                color: Colors.black.withOpacity(.4),
                                fontSize: 13),
                          ),
                          Text(
                            '${listData.location.distance} mi',
                            style: TextStyle(
                                color: Colors.black.withOpacity(.4),
                                fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.blue.withOpacity(0.2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                        onTap: () {
                          callBack();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
