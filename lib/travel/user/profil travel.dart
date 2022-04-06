import 'package:auto_size_text/auto_size_text.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/services/UserServices.dart';
import 'package:vato/widgets/top_container_travel.dart';

class Profiltravel extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return Scaffold(
      backgroundColor: NeumorphicColors.background,
      body: SafeArea(
        child:  Container(
          height: height,
          // padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: height/100),

              Divider(),
              SizedBox(height: height/100),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Neumorphic(
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        depth: 20,
                      ),
                      child: Container(
                        width: width/3.5,
                        height:height/9,
                        child: Center(
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Countup(
                                  begin: 0,
                                  end: 15,
                                  duration: Duration(seconds: 3),
                                  // separator: ',',
                                  style:  TextStyle(
                                      color:
                                      LightColors.Lviolet,
                                      fontSize: 18,
                                      fontWeight:FontWeight.bold
                                  ),


                                ),
                                SizedBox(height: height/100,),
                                Text("Completed Missions",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color:
                                      Colors.black54,
                                      fontSize: 15),

                                ),
                              ],
                            )

                        ),
                      )),
                  //                           Divider(color: Colors.red,),

                  Neumorphic(
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        depth: 20,
                      ),
                      child: Container(
                        width: width/3.5,
                        height:height/9,
                        child: Center(
                          child:
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Countup(
                                begin: 0,
                                end: 5,
                                duration: Duration(seconds: 3),
                                // separator: ',',
                                style:  TextStyle(
                                    color:
                                    LightColors.Lviolet,
                                    fontSize: 18,
                                    fontWeight:FontWeight.bold
                                ),


                              ),
                              SizedBox(height: height/100,),

                              Text("current     missions",
                                textAlign: TextAlign.center,

                                style: TextStyle(
                                    color:
                                    Colors.black54,
                                    fontSize: 15),

                              ),
                            ],
                          ),
                        ),
                      )),
                  Neumorphic(
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        depth: 20,
                      ),
                      child: Container(
                        width: width/3.5,
                        height:height/9,
                        child: Center(
                          child:
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Countup(
                                begin: 0,
                                end: 10,
                                duration: Duration(seconds: 2),
                                // separator: ',',
                                style:  TextStyle(
                                    color:
                                    LightColors.Lviolet,
                                    fontSize: 18,
                                    fontWeight:FontWeight.bold
                                ),


                              ),
                              SizedBox(height: height/100,),

                              Text("canceled missions",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color:
                                    Colors.black54,
                                    fontSize: 15),

                              ),
                            ],
                          ),
                        ),
                      ))
                ],
              ),
              SizedBox(height: height/50),
              //Divider(),

              Card(
                color: NeumorphicColors.background,
                child: ListTile(
                  leading: Icon(Icons.phone,color:LightColors.Lviolet) ,
                  title: Text('telephone number',style: TextStyle(color: Colors.black54,fontSize: 15),),
                  trailing: Text("22558555",style: TextStyle(color:Colors.black54,fontSize: 15),),

                ),
              ),
              Card(
                color: NeumorphicColors.background,
                child: ListTile(
                  leading: Icon(Icons.accessibility_new_outlined,color:LightColors.Lviolet) ,
                  title: Text("SUBSERVICElINE+SERVICElINE",style: TextStyle(color: Colors.black54,fontSize: 15),),
                  subtitle: Text("grade",style: TextStyle(color: Colors.black54,fontSize: 13),),

                  //   trailing: Text(telephone.toString(),style: TextStyle(color: LightColors.kbluel,fontSize: 15),),

                ),
              ),

              Card(
                color: NeumorphicColors.background,
                child: ListTile(
                  leading: Icon(Icons.lock_rounded,color:LightColors.Lviolet) ,
                  title: Text('change your password',style: TextStyle(color: Colors.black54,fontSize: 15),),
                  trailing: Icon(Icons.arrow_forward_ios_outlined,color:LightColors.Lviolet,),
                  onTap:() {

                  },

                ),
              ),
              Spacer(),



            ],
          ),
        ),
      ),

    );
  }
}
