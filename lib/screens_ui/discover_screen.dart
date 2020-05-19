import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';
import 'package:moves/store/store.dart';

// actually the QR screen
class DiscoverScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          // remove when implemented
          child: SingleChildScrollView(
            child: Center(
              child: Provider.of<Store>(context, listen: false).signedInUser !=
                      null
                  ? Column(
                      children: <Widget>[
                        Container(
                          color: Colors.white,
                          child: QrImage(
                            data:
                                '${Provider.of<Store>(context, listen: false).signedInUser.email}',
                            version: QrVersions.auto,
                            size: 320,
                            gapless: false,
                          ),
                        )
                      ],
                    )
                  : Text(
                      'You must be signed in for your\ncustom QR code to be scannable',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
