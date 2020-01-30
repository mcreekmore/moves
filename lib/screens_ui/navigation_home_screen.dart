import 'package:moves/app_theme.dart';
import 'package:moves/screens/map_screen.dart';
import 'package:moves/screens_ui/suggest_location_screen.dart';
import '../widgets/custom_drawer/drawer_user_controller.dart';
import '../widgets/custom_drawer/home_drawer.dart';
import 'feedback_screen.dart';
import 'help_screen.dart';
import 'home_screen.dart';
import 'invite_friend_screen.dart';
import 'about_me_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moves/store/store.dart';
import 'package:moves/model/location_model.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget screenView;
  DrawerIndex drawerIndex;
  //AnimationController sliderAnimationController;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = const MyHomePage();
    super.initState();
    getLocations();
  }

  void getLocations() async {
    List<LocationModel> parsedLocations = [];
    List<dynamic> locations =
        await Provider.of<Store>(context, listen: false).getData();
    //print(locations);
    for (var location in locations) {
      parsedLocations.add(
        LocationModel(
          name: location["name"],
          description: location["description"],
          type: location["type"],
          country: location["country"],
          region: location["region"],
          city: location["city"],
          street: location["street"],
          zip: location["zip"],
          email: location["email"],
          phone: location["phone"],
          website: location["website"],
        ),
      );
    }
    print(parsedLocations[0].website);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme().getContainerColor(),
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme().getContainerColor(),
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            animationController: (AnimationController animationController) {
              //sliderAnimationController = animationController;
            },
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
            },
            screenView: screenView,
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = const MyHomePage();
        });
      } else if (drawerIndex == DrawerIndex.Help) {
        setState(() {
          screenView = HelpScreen();
        });
      } else if (drawerIndex == DrawerIndex.FeedBack) {
        setState(() {
          screenView = FeedbackScreen();
        });
      } else if (drawerIndex == DrawerIndex.Invite) {
        setState(() {
          screenView = InviteFriend();
        });
      } else if (drawerIndex == DrawerIndex.Map) {
        setState(() {
          screenView = MapScreen();
        });
      } else if (drawerIndex == DrawerIndex.About) {
        setState(() {
          screenView = AboutMe();
        });
      } else if (drawerIndex == DrawerIndex.Suggest) {
        setState(() {
          screenView = SuggestLocationScreen();
        });
      } else {
        //do in your way......
      }
    }
  }
}
