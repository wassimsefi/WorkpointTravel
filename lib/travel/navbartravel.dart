import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/travel/add_missions.dart';
import 'package:vato/travel/detail%20mission/detail_mission.dart';
import 'package:vato/travel/user/tab_bar_user.dart';
import 'detail mission/stepperpage.dart';
import 'Home/home_travel.dart';
import 'user/profil travel.dart';
import 'package:vato/travel/settings.dart';

class Navbartravel extends StatefulWidget {
  int p;
  Navbartravel(this.p,{Key key}) : super(key: key);

  @override
  _NavbartravelState createState() => _NavbartravelState();
}

class _NavbartravelState extends State<Navbartravel> {
  int indexpage=0;

  @override
  Widget build(BuildContext context) {
    GlobalKey _bottomNavigationKey = GlobalKey();

    return Scaffold(
      // backgroundColor: Colors.orange[200],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: indexpage ,
        color: LightColors.violet,
        backgroundColor: NeumorphicColors.background,
        buttonBackgroundColor: LightColors.violet,
        height: 50,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        items: [
          Icon(Icons.home_outlined,
              size: 20, color: NeumorphicColors.background),
          Icon(Icons.post_add,
              size: 20, color: NeumorphicColors.background),
          Icon(Icons.settings,
              size: 20, color: NeumorphicColors.background),
          Icon(Icons.account_box_outlined,
              size: 20, color: NeumorphicColors.background),
        ],
        onTap: (index) {
          setState(() {
            indexpage = index;
          });
          debugPrint("je suis dans la page  $index");
        },
      ),
      body: navigationbottombar(
          indexpage
      ),
    );
  }

  navigationbottombar(int page) {
    if (page == 0) {
      if (widget.p==0)
{
      return HomeTravel();}
      if(widget.p==1){
        widget.p=0;
        return DetailMission();
      }
    }
    if (page == 1) {
      widget.p=0;

      return AddMissions();
    }
    if (page == 2) {
      widget.p=0;

      return Settings();
    }
    if (page == 3) {
      widget.p=0;

      return TabBarUser();
    } else {
      widget.p=0;

      HomeTravel();
    }
  }
  }
