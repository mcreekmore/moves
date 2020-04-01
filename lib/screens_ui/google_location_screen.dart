//import 'package:flutter/gestures.dart';
import 'package:moves/app_theme.dart';
import 'package:flutter/material.dart';
//import 'package:moves/model/location_loaded_model.dart';
import 'package:moves/themes/location_theme.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_webservice/places.dart';

class GoogleLocationScreen extends StatefulWidget {
  GoogleLocationScreen({@required this.location});

  final PlacesSearchResult location;
  //  this.icon,
  //   this.geometry,
  //   this.name,
  //   this.openingHours,
  //   this.photos,
  //   this.placeId,
  //   this.scope,
  //   this.altIds,
  //   this.priceLevel,
  //   this.rating,
  //   this.types,
  //   this.vicinity,
  //   this.formattedAddress,
  //   this.permanentlyClosed,
  //   this.id,
  //   this.reference,

  @override
  _GoogleLocationScreenState createState() => _GoogleLocationScreenState();
}

class _GoogleLocationScreenState extends State<GoogleLocationScreen>
    with TickerProviderStateMixin {
  //final double infoHeight = 800;
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  @override
  void initState() {
    //SystemChrome.setSystemUIOverlayStyle(AppTheme().getSystemOverlayStyle());
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    print(widget.location.geometry.location);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        //backgroundColor: Colors.blue[200],
        backgroundColor: LocationTheme.nearlyBlue,
        child: Icon((Icons.add)),
      ),
      body: Material(
        type: MaterialType.transparency,
        child: Container(
          color: AppTheme.nearlyWhite,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                brightness: Brightness.light,
                //stretch: true,
                pinned: true,
                expandedHeight: expandedHeight,
                backgroundColor: AppTheme.nearlyWhite,
                //backgroundColor: Color(0xFFb5cdfc),
                //backgroundColor: LocationTheme.nearlyBlue,
                iconTheme: IconThemeData(color: AppTheme.darkText),
                flexibleSpace: FlexibleSpaceBar(
                  //background: Image.asset(
                  //  'assets/icons/${widget.location.type.toString().toLowerCase()}.png'),
                  // background: Image.asset(
                  //     'assets/design_course/webInterFace.png',
                  //     fit: BoxFit.fitWidth),
                  title: Text(
                    '${widget.location.name}',
                    style: TextStyle(
                      fontSize: 22,
                      color: AppTheme.darkText,
                      fontWeight: FontWeight.w700,
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
                delegate: SliverChildBuilderDelegate((_, i) {
                  //return ListTile(title: Text('Item $i'));
                  return Container(
                    decoration: BoxDecoration(
                      color: AppTheme.nearlyWhite,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: SingleChildScrollView(
                        child: Container(
                          // constraints: BoxConstraints(
                          //   minHeight: infoHeight,
                          //   maxHeight: tempHeight > infoHeight
                          //       ? tempHeight
                          //       : infoHeight,
                          // ),
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Padding(
                              //   padding: const EdgeInsets.only(
                              //       top: 32.0, left: 18, right: 16),
                              //   child: Text(
                              //     //'Web Design\nCourse',
                              //     widget.location.name,
                              //     textAlign: TextAlign.left,
                              //     style: TextStyle(
                              //       fontWeight: FontWeight.w600,
                              //       fontSize: 22,
                              //       letterSpacing: 0.27,
                              //       color: LocationTheme.darkerText,
                              //     ),
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, bottom: 8, top: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    // Text(
                                    //   '${widget.location.distance} mi',
                                    //   textAlign: TextAlign.left,
                                    //   style: TextStyle(
                                    //     fontWeight: FontWeight.w200,
                                    //     fontSize: 22,
                                    //     letterSpacing: 0.27,
                                    //     color: LocationTheme.nearlyBlue,
                                    //   ),
                                    // ),
                                    // Container(
                                    //   child: Row(
                                    //     children: <Widget>[
                                    //       Text(
                                    //         '-',
                                    //         textAlign: TextAlign.left,
                                    //         style: TextStyle(
                                    //           fontWeight: FontWeight.w200,
                                    //           fontSize: 22,
                                    //           letterSpacing: 0.27,
                                    //           color: LocationTheme.grey,
                                    //         ),
                                    //       ),
                                    //       Icon(
                                    //         Icons.star,
                                    //         color: LocationTheme.nearlyBlue,
                                    //         size: 24,
                                    //       ),
                                    //     ],
                                    //   ),
                                    // )
                                  ],
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
                                          leading: Icon(Icons
                                              .my_location), //kTODO have this change dynamically on type
                                          title: Text(widget.location.name),
                                          subtitle: Text(widget.location.name),
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
                                                  color:
                                                      LocationTheme.nearlyBlue,
                                                  size: 24,
                                                ),
                                                // Padding(
                                                //   padding:
                                                //       const EdgeInsets.only(
                                                //           right: 20, left: 20),
                                                //   child: Text(
                                                //     widget.location.name,
                                                //     textAlign: TextAlign.left,
                                                //     style: TextStyle(
                                                //       fontWeight:
                                                //           FontWeight.w200,
                                                //       fontSize: 22,
                                                //       letterSpacing: 0.27,
                                                //       color: LocationTheme
                                                //           .nearlyBlue,
                                                //     ),
                                                //   ),
                                                // ),
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
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  color:
                                                      LocationTheme.nearlyBlue,
                                                  splashColor: Colors.white
                                                      .withOpacity(0.3),
                                                  onPressed: () {
                                                    // openMap(widget.location.lat,
                                                    //     widget.location.lon);
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
                              AnimatedOpacity(
                                duration: const Duration(milliseconds: 500),
                                opacity: opacity1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: <Widget>[
                                        getTimeBoxUI('24', 'Classe'),
                                        getTimeBoxUI('2hours', 'Time'),
                                        getTimeBoxUI('24', 'Seat'),
                                        getTimeBoxUI('24', 'Classe'),
                                        getTimeBoxUI('2hours', 'Time'),
                                        getTimeBoxUI('24', 'Seat'),
                                      ],
                                    ),
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
                                          subtitle: widget.location.name != ""
                                              ? Text('${widget.location.name}')
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
                                          subtitle: widget.location.name != ""
                                              ? Text('${widget.location.name}')
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
                                          subtitle: widget.location.name != ""
                                              ? Text('${widget.location.name}')
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
                                          subtitle: widget.location.name != ""
                                              ? Text('${widget.location.name}')
                                              : Text('No Email Added'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Expanded(
                                flex: 0,
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity: opacity2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, top: 8, bottom: 8),
                                    child: Text(
                                      'Lorem ipsum is simply dummy text of printing & typesetting industry, Lorem ipsum is simply dummy text of printing & typesetting industry.',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 14,
                                        letterSpacing: 0.27,
                                        color: LocationTheme.grey,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                //height: MediaQuery.of(context).padding.bottom,
                                height: 90,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }, childCount: 1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // body: SingleChildScrollView(
  //   child: Padding(
  //     padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         appBar(),
  //         Text('hey'),
  //       ],
  //     ),
  //   ),
  // ),

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: LocationTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: LocationTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: LocationTheme.nearlyBlue,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: LocationTheme.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Card(
//   child: Column(
//     mainAxisSize: MainAxisSize.min,
//     children: <Widget>[
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListTile(
//           leading: Image.asset(
//               'assets/icons/${widget.location.type.toString().toLowerCase()}.png'),
//           title: Text('${widget.location.name}'),
//           subtitle: Text(
//               'Address: ${widget.location.street}, ${widget.location.region}, ${widget.location.country}'),
//         ),
//       ),
//       // ButtonBar(
//       //   children: <Widget>[
//       //     FlatButton(
//       //       child: Text('NAVIGATE'),
//       //       onPressed: () {/* ... */},
//       //     ),
//       //     FlatButton(
//       //       child: Text('UPDATE'),
//       //       onPressed: () {/* ... */},
//       //     ),
//       //   ],
//       // ),
//     ],
//   ),
// ),

// Widget appBar() {
//   return SizedBox(
//     height: AppBar().preferredSize.height,
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.only(top: 8, left: 8),
//           child: Container(
//             width: AppBar().preferredSize.height - 8,
//             height: AppBar().preferredSize.height - 8,
//           ),
//         ),
//         Expanded(
//           child: Center(
//             child: Padding(
//               padding: EdgeInsets.only(top: 4),
//               child: Text(
//                 '${widget.location.name}',
//                 style: TextStyle(
//                   fontSize: 22,
//                   color: AppTheme().getTextColor(),
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
