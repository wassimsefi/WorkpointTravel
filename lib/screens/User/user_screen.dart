import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/screens/User/Chart/categories_row.dart';
import 'package:vato/screens/User/Chart/pie_chart_view.dart';
import 'package:vato/services/ServiceLineService.dart';
import 'package:vato/services/UserServices.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({
    Key key,
  }) : super(key: key);
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  Future<SharedPreferences> _prefs;


  DateTime FormatStartDate = DateTime.now().add(Duration(days:1));
  DateTime FormatSndDate = DateTime.now().add(Duration(days: -7));
  String endDate;
  String startDate;
  TextEditingController _textFieldControllerPW = TextEditingController();
  TextEditingController _textFieldControllerPR = TextEditingController();
  TextEditingController _textFieldControllerNP = TextEditingController();
  UserService rs = new UserService();
  ServiceLineService Ss = new ServiceLineService();
  String iduser;
  String tokenLogin;

  @override
  void initState() {
    super.initState();
    _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      setState(() {
        iduser = prefs.get("_id");
        tokenLogin = prefs.get("token");

      });
    });
  }





  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    var alertStyle = AlertStyle(
      animationType: AnimationType.shrink,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      backgroundColor: Colors.black12,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      descTextAlign: TextAlign.start,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color:LightColors.kbluen,
      ),
      alertAlignment: Alignment.center,
    );
    return Scaffold(
      resizeToAvoidBottomInset:false,
        backgroundColor: NeumorphicColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // Spacer(),
                SizedBox(
                  height: height * 0.43,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: height * 0.065),
                        Text(
                          "Some analytics during the month of " + Jiffy().MMMM.toString(),
                          style: GoogleFonts.rubik(color: Colors.black87,
                               fontSize: 15),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              CategoriesRow(),
                              PieChartView(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
              floatingActionButton: FloatingActionButton(    onPressed:() {
                Alert(
                  context: context,
                  title: "Change your password",
                  // type:AlertType.info ,
                  style:alertStyle,

                  content:StatefulBuilder(builder: (context, StateSetter setState) {
                    return
                      SingleChildScrollView(
                        child: Container(
                          height:height/3,
                          child: Column(
                            children: [
                              TextField(
                                enableSuggestions: false,
                                autocorrect: false,
                                style: TextStyle(color: Colors.white),
                                controller: _textFieldControllerPW,
                                obscureText: true,
                                cursorColor: LightColors.kDarkBlue,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(color: LightColors.kgrey),
                                  focusColor: LightColors.kDarkBlue,
                                  hoverColor: Colors.white,
                                  fillColor: LightColors.kDarkBlue,
                                  hintText: "enter your old password",
                                  icon: Icon(
                                    Icons.lock_outline_rounded,
                                    color: LightColors.kDarkBlue,
                                  ),

                                  focusedBorder: UnderlineInputBorder(
                                    //   borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                      borderSide: BorderSide(color: LightColors.kDarkBlue)),
                                  border: UnderlineInputBorder(
                                    //   borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                      borderSide: BorderSide(color: LightColors.kDarkBlue)),
                                ),
                              ),
                              TextField(
                                enableSuggestions: false,
                                autocorrect: false,
                                style: TextStyle(color: Colors.white),
                                controller: _textFieldControllerPR,
                                obscureText: true,
                                cursorColor: LightColors.kDarkBlue,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(color: LightColors.kgrey),
                                  focusColor: LightColors.kDarkBlue,
                                  hoverColor: Colors.white,
                                  fillColor: LightColors.kDarkBlue,
                                  hintText: "enter your new password",
                                  icon: Icon(
                                    Icons.lock_outline_rounded,
                                    color: LightColors.kDarkBlue,
                                  ),

                                  focusedBorder: UnderlineInputBorder(
                                    //   borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                      borderSide: BorderSide(color: LightColors.kDarkBlue)),
                                  border: UnderlineInputBorder(
                                    //   borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                      borderSide: BorderSide(color: LightColors.kDarkBlue)),
                                ),
                              ),
                              TextField(
                                enableSuggestions: false,
                                autocorrect: false,
                                style: TextStyle(color: Colors.white),
                                controller: _textFieldControllerNP,
                                obscureText: true,
                                cursorColor: LightColors.kDarkBlue,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(color: LightColors.kgrey),
                                  focusColor: LightColors.kDarkBlue,
                                  hoverColor: Colors.white,
                                  fillColor: LightColors.kDarkBlue,
                                  hintText: "repeat your new password",
                                  icon: Icon(
                                    Icons.lock_outline_rounded,
                                    color: LightColors.kDarkBlue,
                                  ),

                                  focusedBorder: UnderlineInputBorder(
                                    //   borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                      borderSide: BorderSide(color: LightColors.kDarkBlue)),
                                  border: UnderlineInputBorder(
                                    //   borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                      borderSide: BorderSide(color: LightColors.kDarkBlue)),
                                ),
                              ),

                            ],), ),
                      )
                    ;},),
                  buttons: [
                    DialogButton(
                      child: new Text('Submit',style: TextStyle(color: Colors.white),),
                      color: LightColors.kDarkBlue,
                      onPressed: () {
                        print("useeeeeeeeer"+this.iduser.toString());
                        if(_textFieldControllerPR.text.trim()!=_textFieldControllerNP.text.trim()){
                          new Future.delayed(new Duration(seconds: 2),(){
                            SweetAlert.show(context,subtitle: "passwords dont match!", style: SweetAlertStyle.error);
                          });
                          Navigator.of(context).pop();

                        }
                        if(_textFieldControllerPR.text.trim()==_textFieldControllerNP.text.trim()){
                          Future<dynamic> updatepassword = UserService().updatepassword(this.iduser.toString(), _textFieldControllerPW.text.toString(), _textFieldControllerNP.text.toString(),tokenLogin);
                          updatepassword.then((value) {
                            print(value.toString());
                            if (value["status"].toString()=="201")
                              {
                                SweetAlert.show(context,subtitle:value["message"].toString(), style: SweetAlertStyle.error);

                              }
                            else {
                              new Future.delayed(new Duration(seconds: 2),(){
                                SweetAlert.show(context,subtitle: " password updated successfully!", style: SweetAlertStyle.success);
                              });
                            }
/*                            if (value.toString() ==
                                '{errors: Old password is incorrect}') {
                              new Future.delayed(new Duration(seconds: 2),(){
                                SweetAlert.show(context,subtitle: "password incorrect !", style: SweetAlertStyle.error);
                              });
                            }if (value.toString() ==
                                '{error: Password should be min 6 characters long}') {
                              new Future.delayed(new Duration(seconds: 2),(){
                                SweetAlert.show(context,subtitle: "Password should be min 6 characters long !", style: SweetAlertStyle.error);
                              });
                            }
                            else {
                              new Future.delayed(new Duration(seconds: 2),(){
                                SweetAlert.show(context,subtitle: " password updated successfully!", style: SweetAlertStyle.success);
                              });
                            }*/
                          });

                          Navigator.of(context).pop();
                        }

                      },
                    ),
                    DialogButton(
                      child: new Text('cancel',style: TextStyle(color: Colors.white),),
                      color: LightColors.kDarkBlue,

                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],

                ).show();
              },
backgroundColor: NeumorphicColors.background,
                  child: Icon(Icons.password_rounded,color: LightColors.kDarkBlue,)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

    );
                }
              }
