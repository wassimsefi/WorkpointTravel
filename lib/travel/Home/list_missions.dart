import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/travel/navbartravel.dart';
import '../detail mission/stepperpage.dart';

class ListMissions extends StatelessWidget {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[

        Padding(
          padding: EdgeInsets.only(bottom: _height/500),
          child: InkWell(
            onTap: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Navbartravel(1)),
              );
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(10,25,10,25),
              height: _height/7,
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
                              child:Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceEvenly,
                                      children: [
                                        Text(
                                          "FEB",
                                          style: TextStyle(
                                              color:
                                              LightColors
                                                  .Lviolet,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          "10",
                                            style: TextStyle(
                                              color:
                                              LightColors
                                                  .LLviolet,
                                              fontSize: 18,
                                            )),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceEvenly,
                                      children: [
                                        Text(
                                          "FEB",
                                          style: TextStyle(
                                              color:
                                              LightColors
                                                  .Lviolet,
                                              fontSize: 15),
                                        ),
                                        Text(
                                            "30",
                                            style: TextStyle(
                                              color:
                                              LightColors
                                                  .LLviolet,
                                              fontSize: 18,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )),

                        Container(
                          width: width/2.3,
                          height: _height/7.2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:30.0),
                                  child: Center(
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Audit SG',style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),)]
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:20.0),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(Icons.location_on,color: Colors.black54,),
                                      Text('Paris , France',style: TextStyle(color: Colors.black54))]
                              ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:20.0),
                                  child: Center(
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(Icons.arrow_forward,color: Colors.black54,),
                                          Text('Processing',style: TextStyle(color: Colors.black54))]
                                    ),
                                  ),
                                ),
                              /*                               ListTile(

                                  leading: Icon(Icons.location_on),
                                  title: Text('Paris , France'),
                                ),
                                ListTile(
                                  leading: Icon(Icons.arrow_forward),
                                  title: Text('Facility processing'),
                                ),*/
                              ],
                            ),


                            /* Text("travel" ,  style: GoogleFonts.belleza(
                                              fontSize: 25,
                                                fontWeight: FontWeight.w200,
                                                color: LightColors.violet ??
                                                    Theme.of(context).textTheme.bodyText1.color,
                                              ),),*/

                        ),

                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child:
                                    AutoSizeText("In progress ",style: TextStyle(color: Colors.green),))
                                ,
                                  Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(
                                          0, 0, 5, 0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.circle
                                        ),
                                        child:Text("  "),
                                      )),
                                ],
                              ),
                              Spacer()
                            ],
                          ),
                        )

                      ],
                    ),)),

            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: _height/500),
          child: InkWell(
            onTap: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Navbartravel(1)),
              );
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(10,25,10,25),
              height: _height/7,
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
                              child:Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceEvenly,
                                      children: [
                                        Text(
                                          "SEP",
                                          style: TextStyle(
                                              color:
                                              LightColors
                                                  .Lviolet,
                                              fontSize: 15),
                                        ),
                                        Text(
                                            "18",
                                            style: TextStyle(
                                              color:
                                              LightColors
                                                  .LLviolet,
                                              fontSize: 18,
                                            )),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceEvenly,
                                      children: [
                                        Text(
                                          "SEP",
                                          style: TextStyle(
                                              color:
                                              LightColors
                                                  .Lviolet,
                                              fontSize: 15),
                                        ),
                                        Text(
                                            "25",
                                            style: TextStyle(
                                              color:
                                              LightColors
                                                  .LLviolet,
                                              fontSize: 18,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )),

                        Container(
                          width: width/2.3,
                          height: _height/7.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left:30.0),
                                child: Center(
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[

                                        Text('Audit AXA',style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),)]
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:20.0),
                                child: Center(
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(Icons.location_on,color: Colors.black54,),
                                        Text('Marseille , France',style: TextStyle(color: Colors.black54))]
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:20.0),
                                child: Center(
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(Icons.arrow_forward,color: Colors.black54,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Awaiting closure',style: TextStyle(color: Colors.black54)),

                                          ],
                                        )]
                                  ),
                                ),
                              ),
                              /*                               ListTile(

                                  leading: Icon(Icons.location_on),
                                  title: Text('Paris , France'),
                                ),
                                ListTile(
                                  leading: Icon(Icons.arrow_forward),
                                  title: Text('Facility processing'),
                                ),*/
                            ],
                          ),


                          /* Text("travel" ,  style: GoogleFonts.belleza(
                                              fontSize: 25,
                                                fontWeight: FontWeight.w200,
                                                color: LightColors.violet ??
                                                    Theme.of(context).textTheme.bodyText1.color,
                                              ),),*/

                        ),
                        Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text("Pending  ",style: TextStyle(color: Colors.orange),),
                                Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(
                                        0, 0, 5, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.orange,
                                          shape: BoxShape.circle
                                      ),
                                      child:Text("  "),
                                    )),
                              ],
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                icon: const Icon(Icons.monetization_on_rounded),
                                tooltip: 'remboursement',
                                color: Colors.green,
                                iconSize: 26,
                                onPressed: () {

                                },
                              ),
                            ),
                          ],
                        )

                      ],
                    ),)),

            ),
          ),
        ),
     /*   Padding(
          padding: EdgeInsets.only(bottom: _height/500),
          child: InkWell(
              onTap: (){
                _openPopup(context);

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
                              child:Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceEvenly,
                                      children: [
                                        Text(
                                          "10",
                                          style: TextStyle(
                                              color:
                                              LightColors
                                                  .Lviolet,
                                              fontSize: 18),
                                        ),
                                        Text(
                                            "FEB",
                                            style: TextStyle(
                                              color:
                                              LightColors
                                                  .LLviolet,
                                              fontSize: 15,
                                            )),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceEvenly,
                                      children: [
                                        Text(
                                          "30",
                                          style: TextStyle(
                                              color:
                                              LightColors
                                                  .Lviolet,
                                              fontSize: 18),
                                        ),
                                        Text(
                                            "FEB",
                                            style: TextStyle(
                                              color:
                                              LightColors
                                                  .LLviolet,
                                              fontSize: 15,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        SizedBox(width: width/6),
                        Container(
                          width: 140,
                          height: 130,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  "Missions 2",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20),
                                  maxLines: 1,
                                  minFontSize: 13,
                                ),
                                AutoSizeText(
                                  "validé",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  )    ,
                                  maxLines: 1,
                                  minFontSize: 10,)
                              ],
                            ),


                            *//* Text("travel" ,  style: GoogleFonts.belleza(
                                              fontSize: 25,
                                                fontWeight: FontWeight.w200,
                                                color: LightColors.violet ??
                                                    Theme.of(context).textTheme.bodyText1.color,
                                              ),),*//*
                          ),
                        ),
                        Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                                padding:
                                const EdgeInsets.fromLTRB(
                                    0, 0, 5, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle
                                  ),
                                  child:Text("  "),
                                )),
                            Spacer(),
                            Padding(
                                padding:
                                const EdgeInsets.fromLTRB(
                                    0, 0, 5, 0),
                                child: Container(

                                  child:        IconButton(
                                    icon: const Icon(Icons.monetization_on_rounded),
                                    tooltip: 'remboursement',
                                    color: Colors.green,
                                    iconSize: 26,
                                    onPressed: () {

                                    },
                                  ),
                                )),
                          ],
                        )
                      ],
                    ),)),

            ),
          ),
        ),*/
      ],
    );





  }
  _openPopup(context)
  {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    var alertStyle = AlertStyle(
      animationType: AnimationType.shrink,
      isCloseButton: true,
      //isOverlayTapDismiss: true,
      backgroundColor: Colors.black12,
      titleStyle : TextStyle(color: Colors.white,
          fontWeight: FontWeight.bold),
      descTextAlign: TextAlign.start,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      descStyle: TextStyle(
        color:LightColors.kbluen,
      ),
      alertAlignment: Alignment.center,
    );
    Alert(
        context: context,
        title: "Details",
        type:AlertType.info ,
        style:alertStyle,
    //    desc:"Choose your time slot",

        content:StatefulBuilder(builder: (context, StateSetter setState) {
          return Container(
            height: height/2,
            width: width,
            child: Stepper(

              steps: [
                Step(
                    title: Text("First Step",style: TextStyle(color: Colors.white),),
                    subtitle: Text("Done ",style: TextStyle(color: Colors.white)),
                    content: Text("you've completed the first step successfully",style: TextStyle(color: Colors.white,fontSize: 10)),
                    isActive: true,
                    state: StepState.complete
                ),
                Step(
                    title: Text("Second",style: TextStyle(color: Colors.white)),
                    subtitle: Text("waitting",style: TextStyle(color: Colors.white)),
                    content: Text("Let's look at its construtor.",style: TextStyle(color: Colors.white)),
                    state: StepState.editing,
                    isActive: true
                ),
                Step(
                    title: Text("Third",style: TextStyle(color: Colors.white)),
                    subtitle: Text("Constructor",style: TextStyle(color: Colors.white)),
                    content: Text("Let's look at its construtor.",style: TextStyle(color: Colors.white)),
                    state: StepState.disabled),

              ],
              controlsBuilder: (BuildContext context,
                  {VoidCallback onStepContinue, VoidCallback onStepCancel}) =>
                  Container(),
            ),
          );
        },
        ),
        buttons:[
        ]


    ).show();
  }


}
