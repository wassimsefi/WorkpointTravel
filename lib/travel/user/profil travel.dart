import 'package:auto_size_text/auto_size_text.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/services/UserServices.dart';
import 'package:vato/travel/user/qrcode_user.dart';
import 'package:vato/widgets/top_container_travel.dart';

class Profiltravel extends StatefulWidget {
  String telephone;
  String grade;
  int nbrMissionComleted;
  int nbrCurrentMission;
  String mat;
  String passportValidity;
  String firstname;
  String lastname;

  Profiltravel(
      this.telephone,
      this.grade,
      this.nbrMissionComleted,
      this.nbrCurrentMission,
      this.mat,
      this.passportValidity,
      this.firstname,
      this.lastname,
      {Key key})
      : super(key: key);

  @override
  _ProfiltravelState createState() => _ProfiltravelState();
}

class _ProfiltravelState extends State<Profiltravel> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("object : " + widget.passportValidity.toString());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: NeumorphicColors.background,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            //   height: height / 1.5,
            // padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: height / 100),

                Divider(),
                SizedBox(height: height / 100),

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
                          width: width / 3.5,
                          height: height / 9,
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Countup(
                                begin: 0,
                                end: widget.nbrMissionComleted.toDouble(),
                                duration: Duration(seconds: 3),
                                // separator: ',',
                                style: TextStyle(
                                    color: LightColors.kDarkBlue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: height / 100,
                              ),
                              Text(
                                "Completed Missions",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 15),
                              ),
                            ],
                          )),
                        )),
                    //                           Divider(color: Colors.red,),

                    Neumorphic(
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          depth: 20,
                        ),
                        child: Container(
                          width: width / 3.5,
                          height: height / 9,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Countup(
                                  begin: 0,
                                  end: widget.nbrCurrentMission.toDouble(),
                                  duration: Duration(seconds: 3),
                                  // separator: ',',
                                  style: TextStyle(
                                      color: LightColors.kDarkBlue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: height / 100,
                                ),
                                Text(
                                  "current     missions",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 15),
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
                          width: width / 3.5,
                          height: height / 9,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Countup(
                                  begin: 0,
                                  end: 10,
                                  duration: Duration(seconds: 2),
                                  // separator: ',',
                                  style: TextStyle(
                                      color: LightColors.kDarkBlue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: height / 100,
                                ),
                                Text(
                                  "canceled missions",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
                SizedBox(height: height / 50),
                //Divider(),

                Card(
                  color: NeumorphicColors.background,
                  child: ListTile(
                    leading: Icon(
                      Icons.phone,
                      color: LightColors.kDarkBlue,
                    ),
                    title: Text(
                      'Telephone number',
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                    ),
                    trailing: Text(
                      widget.telephone,
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                    ),
                  ),
                ),
                Card(
                  color: NeumorphicColors.background,
                  child: ListTile(
                    leading: Icon(
                      Icons.credit_card,
                      color: LightColors.kDarkBlue,
                    ),
                    title: Text(
                      'Passport validity',
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                    ),
                    trailing: Text(
                      widget.passportValidity,
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                    ),
                  ),
                ),

                Card(
                  color: NeumorphicColors.background,
                  child: ListTile(
                    leading: Icon(
                      Icons.confirmation_number,
                      color: LightColors.kDarkBlue,
                    ),
                    title: Text(
                      'Rregistration number',
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                    ),
                    trailing: Text(
                      widget.mat,
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                    ),
                  ),
                ),
                Card(
                  color: NeumorphicColors.background,
                  child: ListTile(
                    leading: Icon(
                      Icons.accessibility_new_outlined,
                      color: LightColors.kDarkBlue,
                    ),
                    title: Text(
                      "SUBSERVICElINE+SERVICElINE",
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                    ),
                    subtitle: Text(
                      widget.grade,
                      style: TextStyle(color: Colors.black54, fontSize: 13),
                    ),

                    //   trailing: Text(telephone.toString(),style: TextStyle(color: LightColors.kbluel,fontSize: 15),),
                  ),
                ),
                Card(
                  color: NeumorphicColors.background,
                  child: ListTile(
                    leading: Icon(
                      Icons.qr_code_2_outlined,
                      color: LightColors.kDarkBlue,
                    ),
                    title: Text(
                      'QR Code',
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: LightColors.kDarkBlue,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GeneratePage(
                                widget.firstname, widget.lastname)),
                      );
                    },
                  ),
                ),
                Card(
                  color: NeumorphicColors.background,
                  child: ListTile(
                    leading: Icon(
                      Icons.lock_rounded,
                      color: LightColors.kDarkBlue,
                    ),
                    title: Text(
                      'Change your password',
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: LightColors.kDarkBlue,
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
