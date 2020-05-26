import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:moves/screens_ui/navigation_home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => NavigationHomeScreen()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => OnBoardingPage()));
    }
  }

  @override
  void initState() {
    super.initState();
    new Timer(new Duration(milliseconds: 200), () {
      checkFirstSeen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SpinKitDoubleBounce(
        color: Colors.blue,
        size: 30.0,
      ),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => NavigationHomeScreen()),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/images/$assetName.png', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(
      fontSize: 18.0,
    );
    // const pageDecoration = const PageDecoration(
    //   titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
    //   bodyTextStyle: bodyStyle,
    //   descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
    //   pageColor: Colors.white,
    //   imagePadding: EdgeInsets.zero,
    // );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Powered by you",
          bodyWidget: Stack(
            // maybe for later detail
            children: <Widget>[
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  children: [
                    TextSpan(
                        text:
                            "Add the places important to you by pressing the "),
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Icon(Icons.add_circle_outline),
                      ),
                    ),
                    TextSpan(
                        text:
                            ' at the top right.\n\nOnce approved, everyone will be able to see them too!'),
                  ],
                ),
              ),
            ],
          ),
          image: _buildImage('pale-fatal-error'),
          decoration: PageDecoration(
            titleTextStyle:
                TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
            bodyTextStyle: bodyStyle,
            descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            pageColor: Color(0xFFD8F3DC),
            imagePadding: EdgeInsets.zero,
          ),
        ),
        PageViewModel(
          title: "Controlled by you",
          bodyWidget: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(color: Colors.black, fontSize: 16),
              children: [
                TextSpan(
                    text:
                        "Found something you were looking for or know something that needs updated?\n\nLook for this button at the bottom right of a place to post an update and share to others!\n\n"),
                WidgetSpan(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: FloatingActionButton(
                      //mini: true,
                      onPressed: null,
                      child: Icon(Icons.add),
                    ),
                  ),
                ),
                // TextSpan(
                //     text:
                //         '\nat the bottom right of a place to post an update and let others know!'),
              ],
            ),
          ),
          image: _buildImage('pale-uploading'),
          decoration: PageDecoration(
            titleTextStyle:
                TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
            bodyTextStyle: bodyStyle,
            descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            pageColor: Color(0xFFB7E4C7),
            imagePadding: EdgeInsets.zero,
          ),
        ),
        PageViewModel(
          title: "Your Privacy",
          bodyWidget: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(color: Colors.black, fontSize: 18),
              children: [
                TextSpan(
                    text:
                        "Don't trust me with your location?\n\nNo problem.\n\nPress the "),
                WidgetSpan(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Icon(Icons.location_on),
                  ),
                ),
                TextSpan(
                    text:
                        ' at the top right and manually set where you want Moves to find places near.'),
              ],
            ),
          ),
          image: _buildImage('pale-list-is-empty'),
          decoration: PageDecoration(
            titleTextStyle:
                TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
            bodyTextStyle: bodyStyle,
            descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            pageColor: Color(0xFF95D5B2),
            imagePadding: EdgeInsets.zero,
          ),
        ),
        PageViewModel(
          title: "Something inappropriate?",
          body:
              "Theres a big ol' REPORT button at the bottom of each location.\n\nReports are acted on as soon as possible to keep this app healthy and helpful.",
          image: _buildImage('pale-work-at-home'),
          decoration: PageDecoration(
            titleTextStyle:
                TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
            bodyTextStyle: bodyStyle,
            descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            pageColor: Color(0xFFB7E4C7),
            imagePadding: EdgeInsets.zero,
          ),
        ),
        PageViewModel(
          title: "Finally... Save time!",
          bodyWidget: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(color: Colors.black, fontSize: 18),
              children: [
                TextSpan(
                    text:
                        "Less time searching means doing more of what you love!\n\n"),
                // WidgetSpan(
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 2.0),
                //     child: Icon(Icons.location_on),
                //   ),
                // ),
                TextSpan(
                    text:
                        ' at the top right and manually set where you want Moves to find places near.'),
              ],
            ),
          ),
          image: _buildImage('pale-waiting'),
          footer: InkWell(
              child: Text(
                'illustrations by Ouch.pics',
                style: TextStyle(color: Colors.blueAccent),
              ),
              onTap: () => launch('https://icons8.com')),
          decoration: PageDecoration(
            titleTextStyle:
                TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
            bodyTextStyle: bodyStyle,
            descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            pageColor: Color(0xFFD8F3DC),
            imagePadding: EdgeInsets.zero,
          ),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
