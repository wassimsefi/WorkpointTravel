import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/travel/navbartravel.dart';
import 'detail mission/stepperpage.dart';
import 'package:vato/widgets/navBar.dart';

class FirstPage extends StatelessWidget {
DateTime  selectedDate;
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      body: Container(
        height: _height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.1,
                0.9,
              ],
              colors: [
                NeumorphicColors.background,
                NeumorphicColors.background


              ],
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(height: _height/16),

            Container(
              width: 170,
              height: 80,
              child: Center(
                child: Image.asset(
                  'assets/images/work.png',
                  height: 60.0,
                  fit: BoxFit.fitWidth,
                ),


                /* Text("travel" ,  style: GoogleFonts.belleza(
                                                  fontSize: 25,
                                                    fontWeight: FontWeight.w200,
                                                    color: LightColors.violet ??
                                                        Theme.of(context).textTheme.bodyText1.color,
                                                  ),),*/
              ),
            ),
            Container(

              height: _height/3,
              width: width/2,
              child: Lottie.asset(
                'assets/logosplash.json',
                repeat: true,
                reverse: true,
                animate: true,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: _height/16),

                Padding(
                  padding: EdgeInsets.only(bottom: _height/500),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                          MaterialPageRoute(builder: (context) => navigationScreen(0,null,null,0,null,selectedDate,"home")));

                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10,0,10,25),
                      height: _height/7.2,
                      width: width,
                      child:Neumorphic(
                          style: NeumorphicStyle(
                            color: NeumorphicColors.background,
                          ),
                          child:Container(
                            //  margin: EdgeInsets.all(30),
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Neumorphic(
                                    style: NeumorphicStyle(
                                      shape: NeumorphicShape.flat,
                                      depth: 20,

                                    ),

                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      child:Icon(Icons.home_work_outlined,color: LightColors.kDarkBlue,),
                                    )),
                                SizedBox(width: width/6),
                                Container(
                                  width: 90,
                                  height: 60,
                                  child: Center(
                                    child: Image.asset(
                                      'assets/images/FlexiPoint.png',
                                      height: 30.0,
                                      fit: BoxFit.fitWidth,
                                    ),


                                    /* Text("travel" ,  style: GoogleFonts.belleza(
                                                  fontSize: 25,
                                                    fontWeight: FontWeight.w200,
                                                    color: LightColors.violet ??
                                                        Theme.of(context).textTheme.bodyText1.color,
                                                  ),),*/
                                  ),
                                ),

                              ],
                            ),)),

                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: _height/50),
                  child: InkWell(
                    onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Navbartravel(0)),
              );
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10,25,10,25),
                      height: _height/7.2,
                      width: width,
                      child:Neumorphic(
                          style: NeumorphicStyle(
                              color: NeumorphicColors.background,
                              lightSource:LightSource.top
                          ),
                          child:Container(
                            //  margin: EdgeInsets.all(30),
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Neumorphic(
                                    style: NeumorphicStyle(
                                      shape: NeumorphicShape.flat,
                                      depth: 20,
                                    ),

                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      child:Icon(Icons.card_travel_outlined,color: LightColors.violet,),
                                    )),
                                SizedBox(width: width/6),
                                Container(
                                  width: 100,
                                  height: 80,
                                  child: Center(
                                    child: Image.asset(
                                      'assets/images/TravelPoint.png',
                                      height: 30.0,
                                      fit: BoxFit.fitWidth,
                                    ),


                                    /* Text("travel" ,  style: GoogleFonts.belleza(
                                                  fontSize: 25,
                                                    fontWeight: FontWeight.w200,
                                                    color: LightColors.violet ??
                                                        Theme.of(context).textTheme.bodyText1.color,
                                                  ),),*/
                                  ),
                                ),

                              ],
                            ),)),

                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
