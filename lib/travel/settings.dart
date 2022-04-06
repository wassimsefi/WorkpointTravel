import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:folding_cell/folding_cell.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/widgets/top_container_travel.dart';

class Settings extends StatefulWidget {

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List<dynamic> _technologyList;

  get name => null;

  get icon => null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _technologyList = [
      {name:"permdiem",icon:Icon(Icons.view_day_outlined,color: Colors.blueGrey,)},
      {name:"accommodation",icon:Icon(Icons.view_day_outlined,color: Colors.blueGrey,)},

      {name:"transport",icon:Icon(Icons.emoji_transportation_outlined,color:Colors.blueGrey)},


/*      TechnologyModel(title: "Research & Development",
      ),
      TechnologyModel(title: "Big Data & Analytics",
      ),
      TechnologyModel(title: "Support Services",
      ),
      TechnologyModel(title: "QA & Software Testing",
      ),*/

    ];

  }
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: LightColors.violet,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
                    TopContainerTravel(
            height: _height/5.5,
            width: width,
            child:Padding(
              padding: const EdgeInsets.only(top:20.0),
              child: Row(

                children: [
                  Expanded(
                    flex:2,
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: _height*0.035,
                            ),
                            Container(
                              width: width/2.5,
                              height: _height/20,
                              child: Image(
                                image: AssetImage("assets/images/top.png"),
                              ),
                            ),
                            SizedBox(
                              height: _height*0.01,

                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                width: width/3,
                                height: _height/25,
                                child: Image(
                                  image: AssetImage("assets/images/travelblanc.png"),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: _height*0.005,

                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: PopupMenuButton<int>(
                        icon: Icon(Icons.adaptive.more,color: Colors.white,),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            child: Text("Workpoint"),
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: Text("Notification"),
                          ),
                          PopupMenuItem(
                            value: 1,
                            child: Text("Déconnexion"),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
                decoration: BoxDecoration(
                    color: NeumorphicColors.background,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                child: Container(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      //Center(child: Text("Applied policies",style: TextStyle(color:Colors.black87,fontSize: 28,fontWeight: FontWeight.bold),)),
                      Center(child: Text("Applied policies",style: TextStyle(color:Colors.black54,fontSize: 25,))),
                      SizedBox(height: _height/20),

                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                          children: <Widget>[
                            Padding(
                          padding: EdgeInsets.only(bottom: _height/500),
                          child: InkWell(
                            onTap: (){

                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10,25,10,25),
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
                                              child:Icon(Icons.monetization_on_outlined,color: LightColors.Lviolet,size: 30,),
                                            )),
                                        SizedBox(width: width/6),
                                        Container(
                                          width: 140,
                                          height: 130,
                                          child: Center(
                                            child: Text("Per diem",style:TextStyle(fontSize: 18,color: Colors.black45))

                                          ),
                                        ),

                                      ],
                                    ),)),

                            ),
                          ),
                      ),

                      Padding(
                          padding: EdgeInsets.only(bottom: _height/500),
                          child: InkWell(
                            onTap: (){

                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10,25,10,25),
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
                                              child:Icon(Icons.airline_seat_flat_outlined,color: LightColors.Lviolet,size: 30,),
                                            )),
                                        SizedBox(width: width/6),
                                        Container(
                                          width: 140,
                                          height: 130,
                                          child: Center(
                                            child: Text("Accommodation",style:TextStyle(fontSize: 18,color: Colors.black45,))
                                          ),
                                        ),

                                      ],
                                    ),)),

                            ),
                          ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: _height/500),
                          child: InkWell(
                            onTap: (){

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
                                              child:Icon(Icons.emoji_transportation_outlined,color: LightColors.Lviolet,size: 30,),
                                            )),
                                        SizedBox(width: width/6),
                                        Container(
                                          width: 140,
                                          height: 130,
                                          child: Center(
                                            child: Text("Transport",style:TextStyle(fontSize: 18,color: Colors.black45,))
                                          ),
                                        ),

                                      ],
                                    ),)),

                            ),
                          ),
                      ),

                          ]
                      ),
                        ),
                    ),

                    ],
                  ),
                ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInnerBottomWidget() {
    return Builder(
        builder: (context) {
          return Container(
            color: Colors.blueGrey[50],
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: FlatButton(
                onPressed: () {
                  final foldingCellState = context
                      .findAncestorStateOfType<SimpleFoldingCellState>();
                  foldingCellState?.toggleFold();
                },
                child: Text(
                  "Close",
                ),
                textColor: Colors.white,
                splashColor: Colors.white.withOpacity(0.5),
              ),
            ),
          );
        }
    );
  }

  Widget _buildInnerWidget(int index,double _height,double width) {
    return Builder(
      builder: (context) {
        return  Padding(
          padding: EdgeInsets.only(bottom: _height/500),
          child: InkWell(
            onTap: (){

            },
            child: Container(
              margin: EdgeInsets.fromLTRB(10,25,10,25),
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
                        child:Icon(Icons.view_day_outlined,color: Colors.blueGrey,),
                      )),
                  SizedBox(width: width/6),
                  Container(
                    width: 140,
                    height: 130,
                    child: Center(
                      child: Text("per diem",style:TextStyle(fontSize: 18,color: Colors.grey,fontWeight: FontWeight.bold))

              ),
            ),

            ],
          ))))));
      },
    );
  }

  Widget _buildFrontWidget(int index,double _height,double width) {
    return Builder(
      builder: (context) {
        return  Padding(
            padding: EdgeInsets.only(bottom: _height/500),
            child: InkWell(
                onTap: (){

                },
                child: Container(
                    margin: EdgeInsets.fromLTRB(10,25,10,25),
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
                                      child:Icon(Icons.view_day_outlined,color: Colors.blueGrey,),
                                    )),
                                SizedBox(width: width/6),
                                Container(
                                  width: 140,
                                  height: 130,
                                  child: Center(
                                      child: Text("per diem",style:TextStyle(fontSize: 18,color: Colors.grey,fontWeight: FontWeight.bold))

                                  ),
                                ),

                              ],
                            ))))));
      },
    );
  }
}








































   /* Padding(
                        padding: EdgeInsets.only(bottom: _height/500),
                        child: InkWell(
                          onTap: (){

                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10,25,10,25),
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
                                            child:Icon(Icons.view_day_outlined,color: Colors.blueGrey,),
                                          )),
                                      SizedBox(width: width/6),
                                      Container(
                                        width: 140,
                                        height: 130,
                                        child: Center(
                                          child: Text("per diem",style:TextStyle(fontSize: 18,color: Colors.grey,fontWeight: FontWeight.bold))


                                          *//* Text("travel" ,  style: GoogleFonts.belleza(
                                              fontSize: 25,
                                                fontWeight: FontWeight.w200,
                                                color: LightColors.violet ??
                                                    Theme.of(context).textTheme.bodyText1.color,
                                              ),),*//*
                                        ),
                                      ),

                                    ],
                                  ),)),

                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(bottom: _height/500),
                        child: InkWell(
                          onTap: (){

                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10,25,10,25),
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
                                            child:Icon(Icons.airline_seat_flat_outlined,color: Colors.blueGrey,),
                                          )),
                                      SizedBox(width: width/6),
                                      Container(
                                        width: 140,
                                        height: 130,
                                        child: Center(
                                          child: Text("accommodation",style:TextStyle(fontSize: 18,color: Colors.grey,fontWeight: FontWeight.bold))


                                          *//* Text("travel" ,  style: GoogleFonts.belleza(
                                              fontSize: 25,
                                                fontWeight: FontWeight.w200,
                                                color: LightColors.violet ??
                                                    Theme.of(context).textTheme.bodyText1.color,
                                              ),),*//*
                                        ),
                                      ),

                                    ],
                                  ),)),

                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: _height/500),
                        child: InkWell(
                          onTap: (){

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
                                            child:Icon(Icons.emoji_transportation_outlined,color:Colors.blueGrey),
                                          )),
                                      SizedBox(width: width/6),
                                      Container(
                                        width: 140,
                                        height: 130,
                                        child: Center(
                                          child: Text("transport",style:TextStyle(fontSize: 18,color: Colors.grey,fontWeight: FontWeight.bold))


                                          *//* Text("travel" ,  style: GoogleFonts.belleza(
                                              fontSize: 25,
                                                fontWeight: FontWeight.w200,
                                                color: LightColors.violet ??
                                                    Theme.of(context).textTheme.bodyText1.color,
                                              ),),*//*
                                        ),
                                      ),

                                    ],
                                  ),)),

                          ),
                        ),
                      ),
*/





