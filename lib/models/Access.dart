import 'package:vato/models/User.dart';
import 'package:vato/models/Grades.dart';
import 'package:vato/models/ServicesLines.dart';
import 'package:vato/models/SubServiceLines.dart';
import 'package:vato/models/Zone.dart';

class Access {
  int id;
  String Status;
  User user;
  Zone zone;
  Grades grade;
  ServiceLines serviceLine;
  SubServiceLines subserviceLine;

  Access.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        Status = map["Status"],
        user = map["Users"],
        zone = map["Zones"],
        grade = map["grade"],
        serviceLine = map["serviceLine"],
        subserviceLine = map["SubServiceLine"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data["Status"] = Status;
    data["Users"] = user;
    data["Zones"] = zone;
    data["grade"] = grade;
    data["serviceLine"] = serviceLine;
    data["SubServiceLine"] = subserviceLine;
    return data;
  }

  Access();
}
/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateAnimatedButton();
  }
}

class _StateAnimatedButton extends State<AnimatedButton> {
  bool _clicked = false;
  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              _clicked = !_clicked;
              _opacity = _opacity == 1.0 ? 0.0 : 1.0;
            });
          },
          child: AnimatedContainer(
            width: _clicked ? 55 : 200,
            height: 55,
            curve: Curves.fastOutSlowIn,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_clicked ? 70.0 : 30.0),
              color: Colors.lightBlueAccent,
            ),
            duration: Duration(milliseconds: 700),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AnimatedOpacity(
                  duration: Duration(seconds: 1),
                  child: Text(
                    "Sign In",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  opacity: _opacity,
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              _clicked = !_clicked;
              _opacity = _opacity == 1.0 ? 0.0 : 1.0;
            });
          },
          child: AnimatedContainer(
            width: _clicked ? 55 : 200,
            height: 55,
            curve: Curves.fastOutSlowIn,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_clicked ? 70.0 : 30.0),
            ),
            duration: Duration(milliseconds: 700),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 700),
              child: Padding(
                child: CircularProgressIndicator(
                    backgroundColor: Colors.blueAccent,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        _clicked ? Colors.pinkAccent : Colors.blueAccent)),
                padding: EdgeInsets.all(1),
              ),
              opacity: _opacity == 0.0 ? 1.0 : 0.0,
            ),
          ),
        ),
      ],
    );
  }
}




*/
