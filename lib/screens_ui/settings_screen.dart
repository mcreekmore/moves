import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moves/theme_notifier.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:moves/widgets/messaging.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: Text('Settings'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('Dark Theme'),
              trailing: Platform.isIOS
                  ? CupertinoSwitch(
                      value: themeNotifier.getThemeBool(),
                      onChanged: (val) {
                        if (val) {
                          themeNotifier.setTheme(darkTheme);
                        } else {
                          themeNotifier.setTheme(lightTheme);
                        }
                        setState(() {
                          themeNotifier.toggleTheme(val);
                          SystemChrome.setSystemUIOverlayStyle(
                            themeNotifier.getSystemOverlayStyle(),
                          );
                        });
                      },
                    )
                  : Switch(
                      value: themeNotifier.getThemeBool(),
                      onChanged: (val) {
                        if (val) {
                          themeNotifier.setTheme(darkTheme);
                        } else {
                          themeNotifier.setTheme(lightTheme);
                        }
                        setState(() {
                          themeNotifier.toggleTheme(val);
                          SystemChrome.setSystemUIOverlayStyle(
                            themeNotifier.getSystemOverlayStyle(),
                          );
                        });
                      },
                    ),
            ),
            //MessagingWidget(),
          ],
        ),
      ),
    );
  }
}
