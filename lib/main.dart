import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moves/screens_ui/navigation_home_screen.dart';
import 'package:provider/provider.dart';
import 'store/store.dart';
import 'theme_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then(
    (_) {
      SharedPreferences.getInstance().then((prefs) {
        var darkModeOn = prefs.getBool('darkMode') ?? false;
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => ThemeNotifier(darkModeOn ? darkTheme : lightTheme),
            child: MyApp(),
          ),
        );
      });
    },
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    SystemChrome.setSystemUIOverlayStyle(themeNotifier.getSystemOverlayStyle());
    return ChangeNotifierProvider<Store>(
      create: (context) => Store(),
      child: MaterialApp(
        title: 'Flutter UI',
        debugShowCheckedModeBanner: false,
        theme: themeNotifier.getTheme(),
        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        //   //textTheme: AppTheme.textTheme,
        //   textTheme: AppTheme().getTextTheme(),
        //   //platform: TargetPlatform.iOS,
        // ),
        home: NavigationHomeScreen(),
      ),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
