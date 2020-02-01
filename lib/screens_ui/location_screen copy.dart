// import 'package:flutter/material.dart';
// import 'package:moves/themes/location_theme.dart';
// import 'package:moves/model/location_loaded_model.dart';

// class LocationScreen extends StatefulWidget {
//   @override
//   _LocationScreenState createState() => _LocationScreenState();

//   LocationScreen({this.location});

//   final LocationLoadedModel location;
// }

// class _LocationScreenState extends State<LocationScreen>
//     with TickerProviderStateMixin {
//   final double infoHeight = 364.0;
//   AnimationController animationController;
//   Animation<double> animation;
//   double opacity1 = 0.0;
//   double opacity2 = 0.0;
//   double opacity3 = 0.0;
//   @override
//   void initState() {
//     animationController = AnimationController(
//         duration: const Duration(milliseconds: 1000), vsync: this);
//     animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//         parent: animationController,
//         curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
//     setData();
//     super.initState();
//   }

//   Future<void> setData() async {
//     animationController.forward();
//     await Future<dynamic>.delayed(const Duration(milliseconds: 200));
//     setState(() {
//       opacity1 = 1.0;
//     });
//     await Future<dynamic>.delayed(const Duration(milliseconds: 200));
//     setState(() {
//       opacity2 = 1.0;
//     });
//     await Future<dynamic>.delayed(const Duration(milliseconds: 200));
//     setState(() {
//       opacity3 = 1.0;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double tempHeight = MediaQuery.of(context).size.height -
//         (MediaQuery.of(context).size.width / 1.2) +
//         24.0;
//     return Container(
//       color: LocationTheme.nearlyWhite,
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Stack(
//           children: <Widget>[
//             Column(
//               children: <Widget>[
//                 AspectRatio(
//                   aspectRatio: 1.2,
//                   child: Image.asset('assets/design_course/webInterFace.png'),
//                 ),
//               ],
//             ),
//             Positioned(
//               top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: SingleChildScrollView(
//                 // ADDED ^^^^
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: LocationTheme.nearlyWhite,
//                     borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(32.0),
//                         topRight: Radius.circular(32.0)),
//                     boxShadow: <BoxShadow>[
//                       BoxShadow(
//                           color: LocationTheme.grey.withOpacity(0.2),
//                           offset: const Offset(1.1, 1.1),
//                           blurRadius: 10.0),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 8, right: 8),
//                     child: SingleChildScrollView(
//                       child: Container(
//                         constraints: BoxConstraints(
//                           minHeight: infoHeight,
//                           maxHeight:
//                               tempHeight > infoHeight ? tempHeight : infoHeight,
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 32.0, left: 18, right: 16),
//                               child: Text(
//                                 //'Web Design\nCourse',
//                                 widget.location.name,
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 22,
//                                   letterSpacing: 0.27,
//                                   color: LocationTheme.darkerText,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 16, right: 16, bottom: 8, top: 16),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: <Widget>[
//                                   Text(
//                                     '${widget.location.distance} mi',
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w200,
//                                       fontSize: 22,
//                                       letterSpacing: 0.27,
//                                       color: LocationTheme.nearlyBlue,
//                                     ),
//                                   ),
//                                   Container(
//                                     child: Row(
//                                       children: <Widget>[
//                                         Text(
//                                           '4.3',
//                                           textAlign: TextAlign.left,
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.w200,
//                                             fontSize: 22,
//                                             letterSpacing: 0.27,
//                                             color: LocationTheme.grey,
//                                           ),
//                                         ),
//                                         Icon(
//                                           Icons.star,
//                                           color: LocationTheme.nearlyBlue,
//                                           size: 24,
//                                         ),
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             AnimatedOpacity(
//                               duration: const Duration(milliseconds: 500),
//                               opacity: opacity1,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8),
//                                 child: Row(
//                                   children: <Widget>[
//                                     getTimeBoxUI('24', 'Classe'),
//                                     getTimeBoxUI('2hours', 'Time'),
//                                     getTimeBoxUI('24', 'Seat'),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: AnimatedOpacity(
//                                 duration: const Duration(milliseconds: 500),
//                                 opacity: opacity2,
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 16, right: 16, top: 8, bottom: 8),
//                                   child: Text(
//                                     'Lorem ipsum is simply dummy text of printing & typesetting industry, Lorem ipsum is simply dummy text of printing & typesetting industry.',
//                                     textAlign: TextAlign.justify,
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w200,
//                                       fontSize: 14,
//                                       letterSpacing: 0.27,
//                                       color: LocationTheme.grey,
//                                     ),
//                                     maxLines: 3,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             AnimatedOpacity(
//                               duration: const Duration(milliseconds: 500),
//                               opacity: opacity3,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 16, bottom: 16, right: 16),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: <Widget>[
//                                     Container(
//                                       width: 48,
//                                       height: 48,
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           color: LocationTheme.nearlyWhite,
//                                           borderRadius: const BorderRadius.all(
//                                             Radius.circular(16.0),
//                                           ),
//                                           border: Border.all(
//                                               color: LocationTheme.grey
//                                                   .withOpacity(0.2)),
//                                         ),
//                                         child: Icon(
//                                           Icons.add,
//                                           color: LocationTheme.nearlyBlue,
//                                           size: 28,
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       width: 16,
//                                     ),
//                                     Expanded(
//                                       child: Container(
//                                         height: 48,
//                                         decoration: BoxDecoration(
//                                           color: LocationTheme.nearlyBlue,
//                                           borderRadius: const BorderRadius.all(
//                                             Radius.circular(16.0),
//                                           ),
//                                           boxShadow: <BoxShadow>[
//                                             BoxShadow(
//                                                 color: LocationTheme.nearlyBlue
//                                                     .withOpacity(0.5),
//                                                 offset: const Offset(1.1, 1.1),
//                                                 blurRadius: 10.0),
//                                           ],
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             'Join Course',
//                                             textAlign: TextAlign.left,
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.w600,
//                                               fontSize: 18,
//                                               letterSpacing: 0.0,
//                                               color: LocationTheme.nearlyWhite,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: MediaQuery.of(context).padding.bottom,
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             // heart circle at top of card
//             Positioned(
//               top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
//               right: 35,
//               child: ScaleTransition(
//                 alignment: Alignment.center,
//                 scale: CurvedAnimation(
//                   parent: animationController,
//                   curve: Curves.fastOutSlowIn,
//                 ),
//                 child: Card(
//                   color: LocationTheme.nearlyBlue,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(50.0),
//                   ),
//                   elevation: 10.0,
//                   child: Container(
//                     width: 60,
//                     height: 60,
//                     child: Center(
//                       child: Icon(
//                         Icons.favorite,
//                         color: LocationTheme.nearlyWhite,
//                         size: 30,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             // "app bar"
//             Padding(
//               padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
//               child: SizedBox(
//                 width: AppBar().preferredSize.height,
//                 height: AppBar().preferredSize.height,
//                 child: Material(
//                   color: Colors.transparent,
//                   child: InkWell(
//                     borderRadius:
//                         BorderRadius.circular(AppBar().preferredSize.height),
//                     child: Icon(
//                       Icons.arrow_back_ios,
//                       color: LocationTheme.nearlyBlack,
//                     ),
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget getTimeBoxUI(String text1, String txt2) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: LocationTheme.nearlyWhite,
//           borderRadius: const BorderRadius.all(Radius.circular(16.0)),
//           boxShadow: <BoxShadow>[
//             BoxShadow(
//                 color: LocationTheme.grey.withOpacity(0.2),
//                 offset: const Offset(1.1, 1.1),
//                 blurRadius: 8.0),
//           ],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.only(
//               left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 text1,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 14,
//                   letterSpacing: 0.27,
//                   color: LocationTheme.nearlyBlue,
//                 ),
//               ),
//               Text(
//                 txt2,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w200,
//                   fontSize: 14,
//                   letterSpacing: 0.27,
//                   color: LocationTheme.grey,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//import 'package:flutter/gestures.dart';
import 'package:moves/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:moves/model/location_loaded_model.dart';
import 'package:moves/themes/location_theme.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({@required this.location});

  final LocationLoadedModel location;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  @override
  void initState() {
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

  // @override
  // void initState() {
  //   super.initState();
  // }

  bool multiple = false;

  // String name;
  // String description;
  // String type;
  // String country;
  // String region;
  // String city;
  // String street;
  // String zip;
  // double lat;
  // double lon;
  // String email;
  // String phone;
  // String website;
  // double distance;

  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue[200],
        child: Icon((Icons.add)),
      ),
      body: Material(
        type: MaterialType.transparency,
        child: Container(
          color: AppTheme.nearlyWhite,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: 150.0,
                // backgroundColor: AppTheme.nearlyWhite,
                backgroundColor: AppTheme.nearlyWhite,
                iconTheme: IconThemeData(color: AppTheme.darkText),
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                      'assets/icons/${widget.location.type.toString().toLowerCase()}.png'),
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
                    icon: Icon(Icons.add_circle),
                    tooltip: 'Add new entry',
                    color: AppTheme.darkText,
                    onPressed: () {/* ... */},
                  ),
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      color: AppTheme.nearlyWhite,
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Overview',
                            textAlign: TextAlign.center,
                            style: AppTheme.headline,
                          ),
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
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      // ADDED ^^^^
                      child: Container(
                        decoration: BoxDecoration(
                          color: LocationTheme.nearlyWhite,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(32.0),
                              topRight: Radius.circular(32.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: LocationTheme.grey.withOpacity(0.2),
                                offset: const Offset(1.1, 1.1),
                                blurRadius: 10.0),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: SingleChildScrollView(
                            child: Container(
                              constraints: BoxConstraints(
                                minHeight: infoHeight,
                                maxHeight: tempHeight > infoHeight
                                    ? tempHeight
                                    : infoHeight,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 32.0, left: 18, right: 16),
                                    child: Text(
                                      //'Web Design\nCourse',
                                      widget.location.name,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22,
                                        letterSpacing: 0.27,
                                        color: LocationTheme.darkerText,
                                      ),
                                    ),
                                  ),
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
                                      children: <Widget>[
                                        Text(
                                          '${widget.location.distance} mi',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            fontSize: 22,
                                            letterSpacing: 0.27,
                                            color: LocationTheme.nearlyBlue,
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                '4.3',
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
                                                color: LocationTheme.nearlyBlue,
                                                size: 24,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  AnimatedOpacity(
                                    duration: const Duration(milliseconds: 500),
                                    opacity: opacity1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        children: <Widget>[
                                          getTimeBoxUI('24', 'Classe'),
                                          getTimeBoxUI('2hours', 'Time'),
                                          getTimeBoxUI('24', 'Seat'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: AnimatedOpacity(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      opacity: opacity2,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                            top: 8,
                                            bottom: 8),
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
                                  AnimatedOpacity(
                                    duration: const Duration(milliseconds: 500),
                                    opacity: opacity3,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, bottom: 16, right: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: 48,
                                            height: 48,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    LocationTheme.nearlyWhite,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(16.0),
                                                ),
                                                border: Border.all(
                                                    color: LocationTheme.grey
                                                        .withOpacity(0.2)),
                                              ),
                                              child: Icon(
                                                Icons.add,
                                                color: LocationTheme.nearlyBlue,
                                                size: 28,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 48,
                                              decoration: BoxDecoration(
                                                color: LocationTheme.nearlyBlue,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(16.0),
                                                ),
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(
                                                      color: LocationTheme
                                                          .nearlyBlue
                                                          .withOpacity(0.5),
                                                      offset: const Offset(
                                                          1.1, 1.1),
                                                      blurRadius: 10.0),
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Join Course',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                    letterSpacing: 0.0,
                                                    color: LocationTheme
                                                        .nearlyWhite,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).padding.bottom,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
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

  Widget appBar() {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Padding(
          //   padding: const EdgeInsets.only(top: 8, left: 8),
          //   child: Container(
          //     width: AppBar().preferredSize.height - 8,
          //     height: AppBar().preferredSize.height - 8,
          //   ),
          // ),
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  '${widget.location.name}',
                  style: TextStyle(
                    fontSize: 22,
                    color: AppTheme().getTextColor(),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.only(top: 8, right: 8),
          //   child: Container(
          //     width: AppBar().preferredSize.height - 8,
          //     height: AppBar().preferredSize.height - 8,
          //     color: Colors.white,
          //     child: Material(
          //       color: Colors.transparent,
          //       child: InkWell(
          //         borderRadius:
          //             BorderRadius.circular(AppBar().preferredSize.height),
          //         child: Icon(
          //           multiple ? Icons.dashboard : Icons.view_agenda,
          //           color: AppTheme().getIconColor(),
          //         ),
          //         onTap: () {
          //           setState(() {
          //             multiple = !multiple;
          //           });
          //         },
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

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
