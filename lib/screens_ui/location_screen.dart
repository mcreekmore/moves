//import 'package:flutter/gestures.dart';
import 'package:moves/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:moves/model/location_loaded_model.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({@required this.location});

  final LocationLoadedModel location;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  void initState() {
    super.initState();
  }

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
                          Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    leading: Image.asset(
                                        'assets/icons/${widget.location.type.toString().toLowerCase()}.png'),
                                    title: Text('${widget.location.name}'),
                                    subtitle: Text(
                                        'Address: ${widget.location.street}, ${widget.location.region}, ${widget.location.country}'),
                                  ),
                                ),
                                // ButtonBar(
                                //   children: <Widget>[
                                //     FlatButton(
                                //       child: Text('NAVIGATE'),
                                //       onPressed: () {/* ... */},
                                //     ),
                                //     FlatButton(
                                //       child: Text('UPDATE'),
                                //       onPressed: () {/* ... */},
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ],
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
}
