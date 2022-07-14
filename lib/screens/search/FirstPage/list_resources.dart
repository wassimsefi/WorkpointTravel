import 'package:flutter/painting.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/screens/Login/SignInScreen.dart';
import 'package:vato/screens/search/My%20Requests/myrequests.dart';
import 'package:vato/screens/search/My%20Requests/request_validation.dart';
import 'package:vato/services/UserServices.dart';
import 'package:vato/widgets/navBar.dart';
import 'package:vato/widgets/topContainerScan.dart';

class ListResources extends StatefulWidget {
  const ListResources({Key key}) : super(key: key);

  @override
  _ListResourcesState createState() => _ListResourcesState();
}

class _ListResourcesState extends State<ListResources> {
  DateTime selectedDate;
  dynamic data;
  dynamic Desk;
  String DateNow;
  Future<SharedPreferences> _prefs;
  String user;
  String tokenLogin;
  String role;
  UserService _userService = new UserService();
  Future<dynamic> getUser;
  dynamic User;
  Map<String, dynamic> payload;

  @override
  void initState() {
    DateTime datetimeenow = DateTime.now();
    var newFormat = DateFormat("yyyy-MM-dd");
    DateNow = newFormat.format(datetimeenow);
    _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) async {
      setState(() {
        user = prefs.get("_id");
        role = prefs.get("role");

        tokenLogin = prefs.get("token");
        payload = Jwt.parseJwt(
          this.tokenLogin.toString(),
        );
      });
      //  getUser = _userService.getUserProfil(user, tokenLogin).then((value) {
/*        if (value.toString() == "jwt expired" ||
            value.toString() ==
                "{errors: A token is required for authentication}" ||
            payload["role"] == null ||
            value.toString() == "invalid signature") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignInScreen()));
        }
        ;*/
/*        setState(() {
          User = value["data"];
        });
      });*/
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    DateTime selectedDate;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: LightColors.kDarkBlue,
        body: (this.role == "validator" || this.role == "manager_validator")
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TopContainer(),
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
                      decoration: BoxDecoration(
                          color: NeumorphicColors.background,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: _height * 0.05),
                          Padding(
                            padding: EdgeInsets.only(bottom: _height * 0.02),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => navigationScreen(
                                            1,
                                            null,
                                            null,
                                            0,
                                            "Myrequests",
                                            selectedDate,
                                            "Myrequests")));
                              },
                              child: Container(
                                // margin: EdgeInsets.fromLTRB(10,0,10,10),
                                height: _height / 8,
                                width: width,
                                child: Neumorphic(
                                    style: NeumorphicStyle(
                                      color: NeumorphicColors.background,
                                    ),
                                    child: Container(
                                      //  margin: EdgeInsets.all(30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: width * 0.03,
                                          ),
                                          Neumorphic(
                                              style: NeumorphicStyle(
                                                shape: NeumorphicShape.flat,
                                                depth: 20,
                                              ),
                                              child: Container(
                                                width: width * 0.2,
                                                height: _height / 10,
                                                child: Icon(
                                                  Icons
                                                      .insert_drive_file_outlined,
                                                  color: LightColors.kDarkBlue,
                                                  size: 70,
                                                ),
                                              )),
                                          SizedBox(width: width * 0.05),
                                          Container(
                                              width: width * 0.5,
                                              height: 60,
                                              child: Align(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .centerStart,
                                                  child: Text("My requests",
                                                      style: GoogleFonts.roboto(
                                                          color: LightColors
                                                              .kDarkBlue,
                                                          fontSize: 18)))),
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: _height * 0.02),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RequestValidations()));
                              },
                              child: Container(
                                // margin: EdgeInsets.fromLTRB(10,0,10,10),
                                height: _height / 8,
                                width: width,
                                child: Neumorphic(
                                    style: NeumorphicStyle(
                                      color: NeumorphicColors.background,
                                    ),
                                    child: Container(
                                      //  margin: EdgeInsets.all(30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: width * 0.03,
                                          ),
                                          Neumorphic(
                                              style: NeumorphicStyle(
                                                shape: NeumorphicShape.flat,
                                                depth: 20,
                                              ),
                                              child: Container(
                                                width: width * 0.2,
                                                height: _height / 10,
                                                child: IconButton(
                                                    icon: Image.asset(
                                                  "assets/images/check-list.png",
                                                  color: LightColors.kDarkBlue,
                                                )),
                                              )),
                                          SizedBox(width: width * 0.05),
                                          Container(
                                              width: width * 0.5,
                                              height: 60,
                                              child: Align(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .centerStart,
                                                  child: Text(
                                                      "Request validation",
                                                      style: GoogleFonts.roboto(
                                                          color: LightColors
                                                              .kDarkBlue,
                                                          fontSize: 18)))),
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          /*    Padding(
                            padding: EdgeInsets.only(bottom: _height * 0.02),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => navigationScreen(
                                            1,
                                            null,
                                            null,
                                            0,
                                            "team",
                                            selectedDate,
                                            "team")));
                              },
                              child: Container(
                                // margin: EdgeInsets.fromLTRB(10,0,10,10),
                                height: _height / 8,
                                width: width,
                                child: Neumorphic(
                                    style: NeumorphicStyle(
                                      color: NeumorphicColors.background,
                                    ),
                                    child: Container(
                                      //  margin: EdgeInsets.all(30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: width * 0.03,
                                          ),
                                          Neumorphic(
                                              style: NeumorphicStyle(
                                                shape: NeumorphicShape.flat,
                                                depth: 20,
                                              ),
                                              child: Container(
                                                width: width * 0.2,
                                                height: _height / 10,
                                                child: Icon(
                                                  Icons.groups,
                                                  color: LightColors.kDarkBlue,
                                                ),
                                              )),
                                          SizedBox(width: width * 0.05),
                                          Container(
                                              width: width * 0.5,
                                              height: 60,
                                              child: Align(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .centerStart,
                                                  child: Text(
                                                      "My Team's schedule ",
                                                      style: GoogleFonts.roboto(
                                                          color: LightColors
                                                              .kDarkBlue,
                                                          fontSize: 18)))),
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: _height * 0.02),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => navigationScreen(
                                            1,
                                            null,
                                            null,
                                            0,
                                            "Teamrequests",
                                            selectedDate,
                                            "Teamrequests")));
                              },
                              child: Container(
                                // margin: EdgeInsets.fromLTRB(10,0,10,10),
                                height: _height / 8,
                                width: width,
                                child: Neumorphic(
                                    style: NeumorphicStyle(
                                      color: NeumorphicColors.background,
                                    ),
                                    child: Container(
                                      //  margin: EdgeInsets.all(30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: width * 0.03,
                                          ),
                                          Neumorphic(
                                              style: NeumorphicStyle(
                                                shape: NeumorphicShape.flat,
                                                depth: 20,
                                              ),
                                              child: Container(
                                                width: width * 0.2,
                                                height: _height / 10,
                                                child: Icon(
                                                  Icons.announcement_rounded,
                                                  color: LightColors.kDarkBlue,
                                                ),
                                              )),
                                          SizedBox(width: width * 0.05),
                                          Container(
                                              width: width * 0.5,
                                              height: 60,
                                              child: Align(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .centerStart,
                                                  child: Text(
                                                      "My Pending requests",
                                                      style: GoogleFonts.roboto(
                                                          color: LightColors
                                                              .kDarkBlue,
                                                          fontSize: 18)))),
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                          )
                       */
                        ],
                      ),
                    ),
                  )
                ],
              )
            : Myrequests(0));
  }
}
