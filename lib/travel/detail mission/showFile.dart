import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/widgets/navBar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FilePage extends StatefulWidget {
  // String image;

  FilePage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => FilePageState();
}

class FilePageState extends State<FilePage> {
  // already generated qr code when the page opens

  /* SweetAlert.show(context,
              subtitle: "Loading ...", style: SweetAlertStyle.loading);
          await Future.delayed(new Duration(seconds: 1), () async {
            if (value["status"] == "200") {
    
              
                      await SweetAlert.show(context,
                          subtitle: " Done !", style: SweetAlertStyle.success,
                          onPress: (bool isConfirm) {
                        if (isConfirm) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => navigationScreen(
                                      0, null, null, 0, null, null, "home")));
                          return false;
                        }
                      });
                    
                  
              
              
            } else if (value["status"].toString() == "201") {
              await SweetAlert.show(context,
                  subtitle: value["message"], style: SweetAlertStyle.error);
            } else {
              await SweetAlert.show(context,
                  subtitle: "Ooops! Something Went Wrong!",
                  style: SweetAlertStyle.error);
            }
          });
*/

  _save() async {
    var response = await Dio().get(
        "http://192.168.100.50:8087/alfresco/s/slingshot/node/content/workspace/SpacesStore/660aa61b-cfa2-40df-952c-638cb6a494f1?a=true&alf_ticket=TICKET_dc241c43cc611a9a20d2ac9ba159d40c4898fc2c",
        options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: "hello");
    SweetAlert.show(context,
        subtitle: "Loading ...", style: SweetAlertStyle.loading);
    await Future.delayed(new Duration(seconds: 1), () async {
      if (response.statusCode.toString() == "200") {
        await SweetAlert.show(context,
            subtitle: " Done !",
            style: SweetAlertStyle.success,
            confirmButtonColor: LightColors.kDarkBlue);
      } else if (response.statusCode.toString() == "201") {
        await SweetAlert.show(context,
            subtitle: response.statusMessage, style: SweetAlertStyle.error);
      } else {
        await SweetAlert.show(context,
            subtitle: "Ooops! Something Went Wrong!",
            style: SweetAlertStyle.error);
      }
    });
    print("tezst :" + response.statusCode.toString());
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicColors.background,
      appBar: AppBar(
        backgroundColor: LightColors.kDarkBlue,
        title: Text('File'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height - 270) / 2,
              color: NeumorphicColors.background,
              child: Image.network(
                "http://192.168.100.50:8087/alfresco/s/slingshot/node/content/workspace/SpacesStore/660aa61b-cfa2-40df-952c-638cb6a494f1?a=true&alf_ticket=TICKET_dc241c43cc611a9a20d2ac9ba159d40c4898fc2c",
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: LoadingAnimationWidget.hexagonDots(
                      color: LightColors.kDarkBlue,
                      size: 50,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) =>
                    const Text('Some errors occurred!'),
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: NeumorphicColors.background,
        label: Icon(
          Icons.download,
          color: LightColors.kDarkBlue,
        ),
        onPressed: () {
          _save();
        },
      ),
    );
  }
}
