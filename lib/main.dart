import 'app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moves/screens_ui/navigation_home_screen.dart';
import 'package:provider/provider.dart';
import 'store/store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(AppTheme().getSystemOverlayStyle());
    return ChangeNotifierProvider<Store>(
      create: (context) => Store(),
      child: MaterialApp(
        title: 'Flutter UI',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          //textTheme: AppTheme.textTheme,
          textTheme: AppTheme().getTextTheme(),
          platform: TargetPlatform.iOS,
        ),
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