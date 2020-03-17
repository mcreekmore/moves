import 'package:moves/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:moves/model/location_loaded_model.dart';
import 'package:moves/themes/location_theme.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:moves/screens_ui/type_screens/bar.dart';
import 'package:moves/widgets/bottom_sheet.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({@required this.location});

  final LocationLoadedModel location;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen>
    with TickerProviderStateMixin {
  //final double infoHeight = 800;
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(AppTheme().getSystemOverlayStyle());
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  Future<void> setData() async {
    animationController.forward();
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

  @override
  Widget build(BuildContext context) {
    var expandedHeight = 128.0;

    return Scaffold(
      floatingActionButton: Builder(
        builder: (BuildContext context) {
          return FloatingActionButton(
            onPressed: () {
              showBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return BottomSheetWidget(location: widget.location);
                  });
            },
            //backgroundColor: LocationTheme.nearlyBlue,
            backgroundColor: Colors.blue,
            child: Icon((Icons.add)),
          );
        },
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            brightness: Brightness.light,
            pinned: true,
            expandedHeight: expandedHeight,
            backgroundColor: AppTheme.nearlyWhite,
            iconTheme: IconThemeData(color: AppTheme.darkText),
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                constraints: BoxConstraints(
                  minWidth: 100,
                  maxWidth: MediaQuery.of(context).size.width * .85,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      '${widget.location.name}',
                      style: TextStyle(
                        //fontSize: 22,
                        color: AppTheme.darkText,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.favorite_border),
                tooltip: 'Add to favorites',
                color: AppTheme.darkText,
                onPressed: () {/* ... */},
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) {
                return Container(
                  decoration: BoxDecoration(
                    color: AppTheme.nearlyWhite,
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
                                  left: 16, right: 16, bottom: 8, top: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[],
                              ),
                            ),
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: opacity1,
                              child: Card(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        leading: Icon(Icons.my_location),
                                        title: Text('${widget.location.name}'),
                                        subtitle: Text(
                                            '${widget.location.street}, ${widget.location.region}, ${widget.location.country}, ${widget.location.zip}'),
                                      ),
                                    ),
                                    ButtonBar(
                                      children: <Widget>[
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                '-',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 22,
                                                  letterSpacing: 0.27,
                                                  color: LocationTheme.grey,
                                                ),
                                              ),
                                              Icon(
                                                Icons.star,
                                                //color: LocationTheme.nearlyBlue,
                                                color: Colors.blue,

                                                size: 24,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20, left: 20),
                                                child: Text(
                                                  '${widget.location.distance} mi',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 22,
                                                    letterSpacing: 0.27,
                                                    // color: LocationTheme
                                                    //     .nearlyBlue,
                                                    color: Colors.blue,
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
                                                      .symmetric(horizontal: 5),
                                                  child: Text(
                                                    'NAVIGATE',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                //color: LocationTheme.nearlyBlue,
                                                color: Colors.blue,
                                                splashColor: Colors.white
                                                    .withOpacity(0.3),
                                                onPressed: () {
                                                  openMap(widget.location.lat,
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
                            ),

                            /* optional pages toggle here based on type */
                            widget.location.types.contains('Bar')
                                ? AnimatedOpacity(
                                    duration: const Duration(milliseconds: 500),
                                    opacity: opacity1,
                                    child: Bar(
                                      location: widget.location,
                                    ),
                                  )
                                : Container(),
                            widget.location.types.contains('Restaurant')
                                ? AnimatedOpacity(
                                    duration: const Duration(milliseconds: 500),
                                    opacity: opacity1,
                                    child: Bar(
                                      location: widget.location,
                                    ),
                                  )
                                : Container(),
                            widget.location.types.contains('Cafe')
                                ? AnimatedOpacity(
                                    duration: const Duration(milliseconds: 500),
                                    opacity: opacity1,
                                    child: Bar(
                                      location: widget.location,
                                    ),
                                  )
                                : Container(),
                            widget.location.types.contains('Hotel')
                                ? AnimatedOpacity(
                                    duration: const Duration(milliseconds: 500),
                                    opacity: opacity1,
                                    child: Bar(
                                      location: widget.location,
                                    ),
                                  )
                                : Container(),
                            widget.location.types.contains('Music Venue')
                                ? AnimatedOpacity(
                                    duration: const Duration(milliseconds: 500),
                                    opacity: opacity1,
                                    child: Bar(
                                      location: widget.location,
                                    ),
                                  )
                                : Container(),
                            widget.location.types.contains('Grocery')
                                ? AnimatedOpacity(
                                    duration: const Duration(milliseconds: 500),
                                    opacity: opacity1,
                                    child: Bar(
                                      location: widget.location,
                                    ),
                                  )
                                : Container(),
                            widget.location.types.contains('Gas Station')
                                ? AnimatedOpacity(
                                    duration: const Duration(milliseconds: 500),
                                    opacity: opacity1,
                                    child: Bar(
                                      location: widget.location,
                                    ),
                                  )
                                : Container(),
                            widget.location.types.contains('Bank')
                                ? AnimatedOpacity(
                                    duration: const Duration(milliseconds: 500),
                                    opacity: opacity1,
                                    child: Bar(
                                      location: widget.location,
                                    ),
                                  )
                                : Container(),
                            widget.location.types.contains('Post Office')
                                ? AnimatedOpacity(
                                    duration: const Duration(milliseconds: 500),
                                    opacity: opacity1,
                                    child: Bar(
                                      location: widget.location,
                                    ),
                                  )
                                : Container(),
                            widget.location.types.contains('Hospital')
                                ? AnimatedOpacity(
                                    duration: const Duration(milliseconds: 500),
                                    opacity: opacity1,
                                    child: Bar(
                                      location: widget.location,
                                    ),
                                  )
                                : Container(),

                            /* basic info */
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: opacity1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text('Basic Info'),
                                ),
                              ),
                            ),
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: opacity1,
                              child: Card(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        leading: Icon(Icons.description),
                                        title: Text('Open'),
                                        subtitle: widget.location.description !=
                                                ""
                                            ? Text(
                                                '${widget.location.openPercent}')
                                            : Text('No Description'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: opacity1,
                              child: Card(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        leading: Icon(Icons.description),
                                        title: Text('Description'),
                                        subtitle: widget.location.description !=
                                                ""
                                            ? Text(
                                                '${widget.location.description}')
                                            : Text('No Description'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: opacity1,
                              child: Card(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        leading: Icon(Icons.web),
                                        title: Text('Website'),
                                        subtitle: widget.location.website != ""
                                            ? Text('${widget.location.website}')
                                            : Text('No Website Added'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: opacity1,
                              child: Card(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        leading: Icon(Icons.phone),
                                        title: Text('Phone'),
                                        subtitle: widget.location.phone != ""
                                            ? Text('${widget.location.phone}')
                                            : Text('No Phone Added'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: opacity1,
                              child: Card(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        leading: Icon(Icons.email),
                                        title: Text('Email'),
                                        subtitle: widget.location.email != ""
                                            ? Text('${widget.location.email}')
                                            : Text('No Email Added'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 90,
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
    );
  }
}
