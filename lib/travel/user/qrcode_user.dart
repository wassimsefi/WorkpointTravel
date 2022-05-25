import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:vato/constants/light_colors.dart';

class GeneratePage extends StatefulWidget {
  String firstname;
  String lastname;
  GeneratePage(this.firstname, this.lastname, {Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => GeneratePageState();
}

class GeneratePageState extends State<GeneratePage> {
  // already generated qr code when the page opens

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
        actions: <Widget>[],
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QrImage(
              foregroundColor: LightColors.kDarkBlue,
              //plce where the QR Image will be shown
              version: 2,
              data: "" + widget.firstname + " " + widget.lastname,
              embeddedImage: AssetImage('assets/images/iconandroid.png'),
              embeddedImageStyle: QrEmbeddedImageStyle(size: Size(80, 80)),
            ),
          ],
        ),
      ),
    );
  }
}
