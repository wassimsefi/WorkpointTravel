import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/models/User.dart';
import 'package:vato/screens/Login/forgotpassword.dart';
import 'package:vato/services/BuildingService.dart';
import 'package:vato/services/UserServices.dart';
import 'package:vato/widgets/input_field.dart';
import 'package:vato/widgets/navBar.dart';
import 'package:vato/widgets/password_field.dart';


class Login extends StatefulWidget {
  final DateTime selectedDate;

  const Login(
    this.selectedDate, {
    Key key,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>
  with TickerProviderStateMixin {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Icon eye;
  String token;
  var animationStatus = 0;
  var indexpage = 0;
  bool _clicked = false;
  double _opacity = 1.0;
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  AnimationController _loginButtonController;
  final storage = new FlutterSecureStorage();
BuildingService _buildingService = new BuildingService();
  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getToken();

    // TODO: implement initState
    _loginButtonController = new AnimationController(
        duration: new Duration(milliseconds: 3000), vsync: this);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;

    timeDilation = 0.4;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: size.width * 0.1,
                ),
                Center(
                  child: Container(
                    color: NeumorphicColors.background,
                    //margin: EdgeInsets.all(20),
                    width: size.width * 0.7,
                    height: height / 2.5,
                    child: Center(
                      child: Image(
                        //   fit:BoxFit.fitWidth,
                        image: AssetImage("assets/images/logo_WP.png"),
                      ),
                    ),
                  ),
                ),
                Container(width: size.width * 0.1,)
              ],
            ),
            // SizedBox(height: size.height * 0.001),
            InputField(
              hintText: "Your Email",
              textEditingController: email,
              onChanged: (value) {},
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PasswordField(
                  textEditingController: password,
                  onChanged: (value) {},
                  hint: "your password",
                ),

                Align(alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: TextButton(child: Text('Forgot password ?',
                      style: TextStyle(color: LightColors.kDarkBlue),),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  Forgotpassword()));
                        }),
                  ),),
              ],
            ),

            SizedBox(height: size.height * 0.04),

            Stack(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      _clicked = !_clicked;
                      _opacity = _opacity == 1.0 ? 0.0 : 1.0;
                    });

              },
              child: Container(
                child: AnimatedContainer(
                  width: _clicked ? 65 : 200,
                  height: 65,
                  curve: Curves.fastOutSlowIn,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_clicked ? 65.1 : 30.0),
                    color: LightColors.kDarkBlue,
                  ),
                  duration: Duration(milliseconds: 700),
                  child:  Center(
                    child: AnimatedOpacity(
                      duration: Duration(seconds: 1),
                      child: AutoSizeText( "Sign In",maxFontSize: 20,
                        minFontSize: 8, maxLines: 1,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      opacity: _opacity,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
               getToken();
                setState(() {
                  _clicked = !_clicked;
                  _opacity = _opacity == 1.0 ? 0.0 : 1.0;
                });
                User user = new User();
                user.Email = email.text.trim();
                user.tokenDevice= token;
                user.password = password.text.trim();
                if (email.text.trim() == "" && password.text.trim() == "") {
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'email and password are empty',
                        style: TextStyle(color: Colors.orange),
                      )));
                      Future.delayed(Duration(seconds: 5), () {
                  setState(() {
                    _clicked = !_clicked;
                    _opacity = _opacity == 1.0 ? 0.0 : 1.0;
                  });});
                } else if (email.text.trim() == "" &&
                    password.text.trim() != "") {
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'password is empty',
                        style: TextStyle(color: Colors.orange),
                      )));
                  Future.delayed(Duration(seconds: 5), () {
                    setState(() {
                      _clicked = !_clicked;
                      _opacity = _opacity == 1.0 ? 0.0 : 1.0;
                    });});

                } else if (password.text.trim() == "" &&
                    email.text.trim() != "") {
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'password is empty',
                        style: TextStyle(color: Colors.orange),
                      )));
                  Future.delayed(Duration(seconds: 5), () {
                    setState(() {
                      _clicked = !_clicked;
                      _opacity = _opacity == 1.0 ? 0.0 : 1.0;
                    });
                  });
                } else {
                  Future<dynamic> loginUser = UserService().login(user);
                  loginUser.then((value) async {
                    if (value.toString() ==
                        '{errors: Email and password do not match}') {
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Email and password do not match',
                            style: TextStyle(color: Colors.red),
                          )));
                      Future.delayed(Duration(seconds: 5), () {
                        setState(() {
                          _clicked = !_clicked;
                          _opacity = _opacity == 1.0 ? 0.0 : 1.0;
                        });});
                    } else if (value.toString() ==
                        '{errors: User with that email does not exist. Please signup}') {
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Email does not exist',
                            style: TextStyle(color: Colors.red),
                          )));
                      Future.delayed(Duration(seconds: 5), () {
                        setState(() {
                          _clicked = !_clicked;
                          _opacity = _opacity == 1.0 ? 0.0 : 1.0;
                        });});
                    } else {
                      Map<String, dynamic> payload = Jwt.parseJwt(
                        value["token"].toString(),
                      );

                      if (value["refreshToken"].toString() != "null") {
                        await storage.write(key: "refreshToken",
                            value: value["refreshToken"].toString());
                      }
                      await storage.write(
                          key: "token", value: value["token"].toString());

                      _saveLoginUser(
                        payload["id"].toString(),
                        value["token"].toString(),
                        payload["firstname"],
                        payload["lastname"],
                        payload["Email"],
                        payload["role"],
                        payload["tokenDevice"],
                        payload["spot"],
                      );
                      Future.delayed(Duration(seconds: 1), () {
                        _buildingService.getBuildingResources().then((value) async {

                          await storage.write(
                              key: "building_map", value: value["data"][0]["building_map"].toString());
                          await storage.write(
                              key: "building_map_active", value: value["data"][0]["building_map_active"].toString());
                           List Floors =value["data"][0]["Floors"];
                          print("bbbbbbuuuiildiinnggg"+Floors.length.toString());

                          await storage.write(
                              key: "NBFloor", value:Floors.length.toString() );
                          for (var Floor in Floors)
                            {
                              await storage.write(
                                  key: Floor["_id"], value:Floor["floor_map"].toString() );
                            }

                        }).whenComplete(() =>Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    navigationScreen(
                                        0,
                                        null,
                                        null,
                                        0,
                                        null,
                                        widget.selectedDate,
                                        "home"))) );


                      });
                    }
                  });
                }
              },
              child: Column(
                children: [
                  AnimatedContainer(
                    width: _clicked ? 65 : 200,
                    height: 65,
                    curve: Curves.fastOutSlowIn,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_clicked ? 65.1 : 30.0),
                    ),
                    duration: Duration(milliseconds: 700),
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 700),
                      child: Padding(
                        child: CircularProgressIndicator(
                            backgroundColor: LightColors.kDarkBlue,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                _clicked ? LightColors.kgrey : Colors.white)),
                        padding: EdgeInsets.all(1),
                      ),
                      opacity: _opacity == 0.0 ? 1.0 : 0.0,
                    ),
                  ),
                ],
              ),
            ),
              ],
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }

  Future<void> _saveLoginUser(String _id, String token, String firstname,
      String lastname, String Email, String role, String tokendevice,
      String spot) async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      prefs.setString("firstname", firstname.toString()).then((bool success) {
        return firstname.toString();
      });
      prefs.setString("lastname", lastname.toString()).then((bool success) {
        return lastname.toString();
      });
      prefs.setString("_id", _id.toString()).then((bool success) {
        return _id.toString();
      });
      prefs.setString("token", token.toString()).then((bool success) {
        return token.toString();
      });

      prefs.setString("Email", Email.toString()).then((bool success) {
        return Email.toString();
      });
      prefs.setString("role", role.toString()).then((bool success) {
        return role.toString();
      });
      prefs.setString("tokendevice", tokendevice.toString()).then((
          bool success) {
        return tokendevice.toString();
      });
      prefs.setString("spot", spot.toString()).then((bool success) {
        return spot.toString();
      });
/*      String domaine = Email.substring(Email.indexOf('@'));
      if (domaine == "@workpoint.tn")
        prefs.setString("company", "workpoint").then((bool success) {
          return "workpoint";
        });
      if (domaine == "@ey.tn")
        prefs.setString("company", "X-point").then((bool success) {
          return "X-point";
        });*/
    });
  }

  Future<void> getToken() async {

   AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
     if (!isAllowed) {
       AwesomeNotifications().requestPermissionToSendNotifications();
     }
   });
   await Firebase.initializeApp();
   FirebaseMessaging messaging = FirebaseMessaging.instance;
   token = await messaging.getToken();
  }
}
