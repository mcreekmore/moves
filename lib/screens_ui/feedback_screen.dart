import 'package:flutter/material.dart';
import 'package:email_launcher/email_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:moves/theme_notifier.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  void initState() {
    super.initState();
  }

  Email email = Email(
      to: ['matthewacreekmore@gmail.com'], subject: 'Moves Feedback', body: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor:
      //     Provider.of<ThemeNotifier>(context, listen: false).getTheme() ==
      //             darkTheme
      //         ? Colors.black
      //         : Color(0xFFD8F3DC),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top, left: 16, right: 16),
              child: Image.asset('assets/images/pale-work-at-home.png'),
            ),
            Container(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Your FeedBack',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Send me an email about what you think could be added or improved on!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: Center(
                child: Container(
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      // onTap: () => launch(
                      //     'mailto:matthewacreekmore@gmail.com?subject=Moves Feedback&body='),
                      onTap: () async {
                        await EmailLauncher.launch(email);
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Email',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              child: Text(
                'illustration by Ouch.pics',
                style: TextStyle(color: Colors.blueAccent),
              ),
              onTap: () => launch('https://icons8.com'),
            ),
          ],
        ),
      ),
    );
  }
}
