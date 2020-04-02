import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moves/theme_notifier.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Padding(
        padding: const EdgeInsets.only(left: 40.0),
        child: Text('Settings'),
      )),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('Dark Theme'),
              trailing: Switch(
                value: darkThemeSelected,
                onChanged: (val) {
                  if (val) {
                    setState(() {
                      Provider.of<ThemeNotifier>(context, listen: false)
                          .setTheme(darkTheme);
                      darkThemeSelected = true;
                    });
                  } else {
                    setState(() {
                      Provider.of<ThemeNotifier>(context, listen: false)
                          .setTheme(lightTheme);
                      darkThemeSelected = false;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
