import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:vato/constants/light_colors.dart';

class Documents extends StatefulWidget {
  Documents({Key key}) : super(key: key);

  @override
  _DocumentsState createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicColors.background,
        body:
        ListView.builder(  //if file/folder list is grabbed, then show here
          itemCount: 5,
          itemBuilder: (context, index) {
            return Card(
              color: NeumorphicColors.background,
                child:ListTile(
                  title: Text("fichier "+index.toString()),
                  leading: Icon(Icons.file_copy),
                  trailing: Icon(Icons.file_download, color: LightColors.kDarkBlue,),
                )
            );
          },
        ),
      floatingActionButton: FloatingActionButton.extended(
backgroundColor: NeumorphicColors.background,
        label: Icon(Icons.add,color: LightColors.kDarkBlue,),
       // icon: Icon(Icons.directions_boat),

      ),

    );
  }
}