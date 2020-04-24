import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:moves/store/store.dart';
import 'package:flutter/material.dart';
import 'package:moves/screens/sign_in.dart';
import 'dart:io';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer(
      {Key key,
      this.screenIndex,
      this.iconAnimationController,
      this.callBackIndex})
      : super(key: key);

  final AnimationController iconAnimationController;
  final DrawerIndex screenIndex;
  final Function(DrawerIndex) callBackIndex;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<DrawerList> drawerList;

  @override
  void initState() {
    setdDrawerListArray();
    super.initState();
  }

  void setdDrawerListArray() {
    drawerList = <DrawerList>[
      DrawerList(
        index: DrawerIndex.HOME,
        labelName: 'Home',
        icon: Icon(Icons.home),
      ),
      // DrawerList(
      //   index: DrawerIndex.Map,
      //   labelName: 'Map',
      //   //isAssetsImage: true,
      //   //imageName: 'assets/images/supportIcon.png',
      //   icon: Icon(Icons.map),
      // ),

      DrawerList(
        index: DrawerIndex.FeedBack,
        labelName: 'FeedBack',
        icon: Icon(Icons.help),
      ),
      // DrawerList(
      //   index: DrawerIndex.Invite,
      //   labelName: 'Invite Friend',
      //   icon: Icon(Icons.group),
      // ),

      // DrawerList(
      //   index: DrawerIndex.Share,
      //   labelName: 'Rate the app',
      //   icon: Icon(Icons.share),
      // ),
      DrawerList(
        index: DrawerIndex.About,
        labelName: 'About',
        icon: Icon(Icons.info),
      ),
      DrawerList(
        index: DrawerIndex.Settings,
        labelName: 'Settings',
        icon: Icon(Icons.settings),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    bool signedIn = Provider.of<Store>(context).userID != null;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  signedIn
                      ? AnimatedBuilder(
                          animation: widget.iconAnimationController,
                          builder: (BuildContext context, Widget child) {
                            return ScaleTransition(
                              scale: AlwaysStoppedAnimation<double>(1.0 -
                                  (widget.iconAnimationController.value) * 0.2),
                              child: RotationTransition(
                                turns: AlwaysStoppedAnimation<double>(
                                    Tween<double>(begin: 0.0, end: 24.0)
                                            .animate(CurvedAnimation(
                                                parent: widget
                                                    .iconAnimationController,
                                                curve: Curves.fastOutSlowIn))
                                            .value /
                                        360),
                                child: Container(
                                  height: 120,
                                  width: 120,
                                  child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(60.0)),
                                      // child:
                                      //     Image.asset('assets/images/matt.jpg'),
                                      child: Icon(
                                        Icons.person,
                                        size: 100,
                                        color: Colors.blueAccent,
                                      )),
                                ),
                              ),
                            );
                          },
                        )
                      : AnimatedBuilder(
                          animation: widget.iconAnimationController,
                          builder: (BuildContext context, Widget child) {
                            return ScaleTransition(
                              scale: AlwaysStoppedAnimation<double>(1.0 -
                                  (widget.iconAnimationController.value) * 0.2),
                              child: RotationTransition(
                                turns: AlwaysStoppedAnimation<double>(
                                    Tween<double>(begin: 0.0, end: 24.0)
                                            .animate(CurvedAnimation(
                                                parent: widget
                                                    .iconAnimationController,
                                                curve: Curves.fastOutSlowIn))
                                            .value /
                                        360),
                                child: Container(
                                  height: 120,
                                  width: 120,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(60.0)),
                                    child: Icon(
                                      Icons.person,
                                      size: 100,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                  signedIn
                      ? Padding(
                          padding: const EdgeInsets.only(top: 8, left: 4),
                          child: Text(
                            '${Provider.of<Store>(context).userEmail}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 8, left: 4),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Divider(
            height: 1,
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemCount: drawerList.length,
              itemBuilder: (BuildContext context, int index) {
                return inkwell(drawerList[index]);
              },
            ),
          ),
          Divider(
            height: 1,
          ),
          Column(
            children: <Widget>[
              signedIn
                  ? ListTile(
                      title: Text(
                        'Sign Out',
                        style: TextStyle(
                          //fontFamily: AppTheme.fontName,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      trailing: Icon(
                        Icons.power_settings_new,
                        color: Colors.redAccent,
                      ),
                      onTap: () {
                        if (Platform.isIOS) {
                          setState(() {
                            showCupertinoDialog(
                                context: context,
                                builder: (_) => CupertinoAlertDialog(
                                      title: Text('Sign Out'),
                                      content:
                                          Text('Would you like to sign out?'),
                                      actions: <Widget>[
                                        CupertinoDialogAction(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('No',
                                                style: TextStyle(
                                                    color: Colors.redAccent))),
                                        CupertinoDialogAction(
                                            onPressed: () {
                                              Provider.of<Store>(context,
                                                      listen: false)
                                                  .signOutGoogle();
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'Yes',
                                              style: TextStyle(
                                                  color: Colors.blueAccent),
                                            ))
                                      ],
                                    ));
                          });
                        } else {
                          setState(() {
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      title: Text('Sign Out'),
                                      content:
                                          Text('Would you like to sign out?'),
                                      actions: <Widget>[
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('No')),
                                        FlatButton(
                                            onPressed: () {
                                              Provider.of<Store>(context,
                                                      listen: false)
                                                  .signOutGoogle();
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Yes'))
                                      ],
                                    ));
                          });
                        }
                      },
                    )
                  : ListTile(
                      title: Text(
                        'Sign In',
                        style: TextStyle(
                          //fontFamily: AppTheme.fontName,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      trailing: Icon(
                        Icons.power_settings_new,
                        color: Colors.blueAccent,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()));
                      },
                    ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget inkwell(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          navigationtoScreen(listData.index);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 46.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  listData.isAssetsImage
                      ? Container(
                          width: 24,
                          height: 24,
                          child: Image.asset(
                            listData.imageName,
                          ),
                        )
                      : Icon(
                          listData.icon.icon,
                        ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    listData.labelName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            widget.screenIndex == listData.index
                ? AnimatedBuilder(
                    animation: widget.iconAnimationController,
                    builder: (BuildContext context, Widget child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            (MediaQuery.of(context).size.width * 0.75 - 64) *
                                (1.0 -
                                    widget.iconAnimationController.value -
                                    1.0),
                            0.0,
                            0.0),
                        child: Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 0.75 - 64,
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent.withOpacity(0.2),
                              borderRadius: new BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(28),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(28),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Future<void> navigationtoScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex(indexScreen);
  }
}

enum DrawerIndex {
  HOME,
  Map,
  FeedBack,
  Help,
  Share,
  About,
  Settings,
  Invite,
  Testing,
}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });

  String labelName;
  Icon icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex index;
}
