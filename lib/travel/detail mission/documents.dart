import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:vato/constants/light_colors.dart';
import 'package:vato/services/Alfresco.dart';
import 'package:vato/travel/detail%20mission/showFile.dart';

class Documents extends StatefulWidget {
  Documents({Key key}) : super(key: key);

  @override
  _DocumentsState createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  AlfrescoService _alfrescoService = new AlfrescoService();
  Uint8List _bytesImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicColors.background,
      body: ListView.builder(
        //if file/folder list is grabbed, then show here
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
              color: NeumorphicColors.background,
              child: ListTile(
                title: Text("fichier " + index.toString()),
                leading: Icon(Icons.file_copy),
                trailing: GestureDetector(
                  child: Icon(
                    Icons.file_download,
                    color: LightColors.kDarkBlue,
                  ),
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FilePage()),
                    );
                    /*   _alfrescoService.getDoc().then((value) async {
         });*/
                  },
                ),
              ));
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: NeumorphicColors.background,
        label: Icon(
          Icons.add,
          color: LightColors.kDarkBlue,
        ),
        // icon: Icon(Icons.directions_boat),
      ),
    );
  }
}
