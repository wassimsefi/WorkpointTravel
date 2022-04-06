
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/models/Floor.dart';
import 'package:vato/services/ZoneService.dart';
import 'package:vato/utils/FloorButton.dart';
import 'package:vato/widgets/navBar.dart';

class BuldingPlan extends StatefulWidget {
  //BuildContext context;
  DateTime SelectedDate;

  BuldingPlan(this.SelectedDate, {Key key}) : super(key: key);

  @override
  _BuldingPlanState createState() => _BuldingPlanState();
}

class _BuldingPlanState extends State<BuldingPlan> with TickerProviderStateMixin {
  ZoneService _zoneService = new ZoneService();
  List<dynamic> animationTab=[];
  List<bool> annimationStatus=[];
  List<dynamic> annimationControllerTab=[];
  List<dynamic> annimationPosition=[];


  List <dynamic> Zones;
  Map<dynamic, List<dynamic>>Groupe_Num_Floors;
  Map<dynamic, List<dynamic>>Groupe_Id_Floors;

  AnimationController animationController0;


  int NBRZones = 0;
  Future<SharedPreferences> _prefs;
  String user;
  int NBFloor;

  final _storage = const FlutterSecureStorage();
String ImageBuilding;
  String ImageBuildingActive;

  Future<void> getZone;
  var Num_Floors;
  var Id_Floors;
  String tokenLogin;
  double x=0.01;
  @override
  void initState() {

    _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      tokenLogin = prefs.get("token");
      user = prefs.get("_id");
      getZone = getZones(user);
    });
  }


  Future<void> getZones(String user) async {
   // await getAnnimationPosition();
   ImageBuilding = await _storage.read(key: 'building_map');
    ImageBuildingActive = await _storage.read(key: 'building_map_active');
   animationController0 = AnimationController(
       vsync: this,
       duration: Duration(seconds: 1),
       reverseDuration: Duration(seconds: 3));
    NBFloor = int.parse(await _storage.read(key: 'NBFloor'));
for (var i=0;i<NBFloor;i++)
  {
    annimationControllerTab.add(animationController0);
    animationTab.add(Tween<double>(begin: 0, end: -30).animate(AnimationController(
        vsync: this,
        duration: Duration(seconds: 1),
        reverseDuration: Duration(seconds: 3)))) ;
    annimationStatus.add(true);
  }

    await _zoneService.getZoneByUser(user.toString(), tokenLogin).then((value) {

      setState(() {
        Zones = value["data"];
      });
      print ("Zonesss"+ Zones.toString());
      if (Zones != null) {
        Groupe_Num_Floors = groupBy(Zones, (obj) => obj["floor_num"]);
        Num_Floors  = Groupe_Num_Floors.keys.toList();
        Groupe_Id_Floors = groupBy(Zones, (obj) => obj["floor_id"]);
        Id_Floors  = Groupe_Id_Floors.keys.toList();

        setState(() {
          NBRZones = Groupe_Num_Floors.length;
        });
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

/*    animation51 =
        Tween<double>(begin: 0.135*height, end: 0.16*height).animate(animationController5);
    animation61 =
        Tween<double>(begin: 0.11*height, end: 0.135*height).animate(animationController6);
    animation71 =
        Tween<double>(begin: 0.085*height, end: 0.11*height).animate(animationController7);
    animation81 =
        Tween<double>(begin: 0.06*height, end: 0.085*height).animate(animationController8);
    animation91 =
        Tween<double>(begin: 0.035 * height, end: 0.06 * height).animate(
            animationController9);
    animation101 =
        Tween<double>(begin: 0.01 * height, end: 0.035 * height).animate(
            animationController10);
    animation01 =
        Tween<double>(begin: 0.26 * height, end: 0.285 * height).animate(
            animationController0);
    animationp11 =
        Tween<double>(begin: 0.285 * height, end: 0.31 * height).animate(
            animationControllerp1);
    animationp21 =
        Tween<double>(begin: 0.31 * height, end: 0.335 * height).animate(
            animationControllerp2);*/
    var begin=0.1241;
    var end=0.1435;

/*    for (var i=0;i>NBFloor;i++)
    {
      annimationPosition.add(Tween<double>(begin: begin * height, end: end * height).animate(
          AnimationController(
              vsync: this,
              duration: Duration(seconds: 1),
              reverseDuration: Duration(seconds: 3))));
      begin =begin-0.025;
      end =end-0.025;

    }*/
    final _controller = ScrollController();


    _animateToIndex(i) => _controller.animateTo(
        width * 0.1 * i, duration: Duration(seconds: 2),
        curve: Curves.fastOutSlowIn);
    _animateToback(i) => _controller.animateTo(
        width * 0.1 * -i, duration: Duration(seconds: 2),
        curve: Curves.fastOutSlowIn);


    return

      FutureBuilder(
          future:
          getZone,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none :
                return Center(child: CircularProgressIndicator());
              case ConnectionState.waiting :
                return Center(child: CircularProgressIndicator());
              case ConnectionState.done :
                return (NBRZones != 0) ?
                Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child:
                      Container(
                        color: NeumorphicColors.background,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            NBRZones >= 6 ?
                            Container(
                              width: width * 0.1,
                              child: Neumorphic(
                                child: new IconButton(
                                  icon: new Icon(Icons.arrow_back_ios_outlined,
                                    color: LightColors.kDarkBlue, size: 20,),
                                  onPressed: () {
                                    _animateToback(NBRZones);
                                  },
                                ),
                              ),
                            )
                                : Container(),
                            Container(
                              color: NeumorphicColors.background,
                              width: width * 0.75,
                              child: Center(
                                child: ListView.builder(
                                  controller: _controller,
                                  scrollDirection: Axis.horizontal,
                                  key: new Key("buildingkey"),
                                  //new
                                  itemCount: NBRZones,
                                  itemBuilder: (BuildContext context,
                                      int index) =>
                                      Container(
                                        color: NeumorphicColors.background,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 5, 5, 5),
                                          child: NeuCalculatorButton(
                                              textColor: LightColors.kDarkBlue,
                                              onPressed: () {
                                                print("ZoneFloor"+Groupe_Id_Floors[Id_Floors[index]][0]["floor_type"].toString());
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (
                                                            BuildContext context) =>
                                                            navigationScreen(
                                                                0,
                                                                Groupe_Id_Floors,
                                                                Id_Floors,
                                                                index,
                                                                null,
                                                                widget
                                                                    .SelectedDate,
                                                                "map",floor_type: Groupe_Id_Floors[Id_Floors[index]][0]["floor_type"].toString())));
/*                                                if (double.parse(
                                                    sortedKeys[index]
                                                        .toString()
                                                        .substring(
                                                        sortedKeys[index]
                                                            .toString()
                                                            .indexOf(" "),
                                                        sortedKeys[index]
                                                            .toString()
                                                            .length)) == -2) {
                                                  if (annimationp2 == true) {
                                                    animationControllerp2
                                                        .forward();
                                                    annimationp2 = false;
                                                    new Future.delayed(
                                                        new Duration(
                                                            seconds: 1), () {
                                                      var res = Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (
                                                                  BuildContext context) =>
                                                                  navigationScreen(
                                                                      0,
                                                                      Floors,
                                                                      sortedKeys,
                                                                      index,
                                                                      null,
                                                                      widget
                                                                          .SelectedDate,
                                                                      "map")));
                                                    });
                                                  }
                                                }
                                                if (double.parse(
                                                    sortedKeys[index]
                                                        .toString()
                                                        .substring(
                                                        sortedKeys[index]
                                                            .toString()
                                                            .indexOf(" "),
                                                        sortedKeys[index]
                                                            .toString()
                                                            .length)) == -1) {
                                                  if (annimationp1 == true) {
                                                    animationControllerp1
                                                        .forward();
                                                    annimationp1 = false;
                                                    new Future.delayed(
                                                        new Duration(
                                                            seconds: 1), () {
                                                      var res = Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (
                                                                  BuildContext context) =>
                                                                  navigationScreen(
                                                                      0,
                                                                      Floors,
                                                                      sortedKeys,
                                                                      index,
                                                                      null,
                                                                      widget
                                                                          .SelectedDate,
                                                                      "map")));
                                                    });
                                                  }
                                                }
                                                if (double.parse(
                                                    sortedKeys[index]
                                                        .toString()
                                                        .substring(
                                                        sortedKeys[index]
                                                            .toString()
                                                            .indexOf(" "),
                                                        sortedKeys[index]
                                                            .toString()
                                                            .length)) == 0) {
                                                  if (annimation0 == true) {
                                                    animationController0
                                                        .forward();
                                                    annimation0 = false;
                                                    new Future.delayed(
                                                        new Duration(
                                                            seconds: 1), () {
                                                      var res = Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (
                                                                  BuildContext context) =>
                                                                  navigationScreen(
                                                                      0,
                                                                      Floors,
                                                                      sortedKeys,
                                                                      index,
                                                                      null,
                                                                      widget
                                                                          .SelectedDate,
                                                                      "map")));
                                                    });
                                                  }
                                                }
                                                if (double.parse(
                                                    sortedKeys[index]
                                                        .toString()
                                                        .substring(
                                                        sortedKeys[index]
                                                            .toString()
                                                            .indexOf(" "),
                                                        sortedKeys[index]
                                                            .toString()
                                                            .length)) == 5) {
                                                  if (annimation5 == true) {
                                                    animationController5
                                                        .forward();
                                                    annimation5 = false;
                                                    new Future.delayed(
                                                        new Duration(
                                                            seconds: 1), () {
                                                      var res = Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (
                                                                  BuildContext context) =>
                                                                  navigationScreen(
                                                                      0,
                                                                      Floors,
                                                                      sortedKeys,
                                                                      index,
                                                                      null,
                                                                      widget
                                                                          .SelectedDate,
                                                                      "map")));
                                                    });
                                                  }
                                                }
                                                if (double.parse(
                                                    sortedKeys[index]
                                                        .toString()
                                                        .substring(
                                                        sortedKeys[index]
                                                            .toString()
                                                            .indexOf(" "),
                                                        sortedKeys[index]
                                                            .toString()
                                                            .length)) == 6) {
                                                  if (annimation6 == true) {
                                                    animationController6
                                                        .forward();
                                                    annimation6 = false;
                                                    new Future.delayed(
                                                        new Duration(
                                                            seconds: 1), () {
                                                      var res = Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (
                                                                  BuildContext context) =>
                                                                  navigationScreen(
                                                                      0,
                                                                      Floors,
                                                                      sortedKeys,
                                                                      index,
                                                                      null,
                                                                      widget
                                                                          .SelectedDate,
                                                                      "map")));
                                                    });
                                                  }
                                                }
                                                if (double.parse(
                                                    sortedKeys[index]
                                                        .toString()
                                                        .substring(
                                                        sortedKeys[index]
                                                            .toString()
                                                            .indexOf(" "),
                                                        sortedKeys[index]
                                                            .toString()
                                                            .length)) == 7) {
                                                  if (annimation7 == true) {
                                                    animationController7
                                                        .forward();
                                                    annimation7 = false;
                                                    new Future.delayed(
                                                        new Duration(
                                                            seconds: 1), () {
                                                      var res = Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (
                                                                  BuildContext context) =>
                                                                  navigationScreen(
                                                                      0,
                                                                      Floors,
                                                                      sortedKeys,
                                                                      index,
                                                                      null,
                                                                      widget
                                                                          .SelectedDate,
                                                                      "map")));
                                                    });
                                                  }
                                                }
                                                if (double.parse(
                                                    sortedKeys[index]
                                                        .toString()
                                                        .substring(
                                                        sortedKeys[index]
                                                            .toString()
                                                            .indexOf(" "),
                                                        sortedKeys[index]
                                                            .toString()
                                                            .length)) == 8) {
                                                  if (annimation8 == true) {
                                                    animationController8
                                                        .forward();
                                                    annimation8 = false;

                                                    new Future.delayed(
                                                        new Duration(
                                                            seconds: 1), () {
                                                      var res = Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (
                                                                  BuildContext context) =>
                                                                  navigationScreen(
                                                                      0,
                                                                      Floors,
                                                                      sortedKeys,
                                                                      index,
                                                                      null,
                                                                      widget
                                                                          .SelectedDate,
                                                                      "map")));
                                                    });
                                                  }
                                                }
                                                if (double.parse(
                                                    sortedKeys[index]
                                                        .toString()
                                                        .substring(
                                                        sortedKeys[index]
                                                            .toString()
                                                            .indexOf(" "),
                                                        sortedKeys[index]
                                                            .toString()
                                                            .length)) == 9) {
                                                  if (annimation9 == true) {
                                                    animationController9
                                                        .forward();
                                                    annimation9 = false;
                                                    new Future.delayed(
                                                        new Duration(
                                                            seconds: 1), () {
                                                      var res = Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (
                                                                  BuildContext context) =>
                                                                  navigationScreen(
                                                                      0,
                                                                      Floors,
                                                                      sortedKeys,
                                                                      index,
                                                                      null,
                                                                      widget
                                                                          .SelectedDate,
                                                                      "map")));
                                                    });
                                                  }
                                                }
                                                if (double.parse(
                                                    sortedKeys[index]
                                                        .toString()
                                                        .substring(
                                                        sortedKeys[index]
                                                            .toString()
                                                            .indexOf(" "),
                                                        sortedKeys[index]
                                                            .toString()
                                                            .length)) == 10) {
                                                  if (annimation10 == true) {
                                                    animationController10
                                                        .forward();
                                                    annimation10 = false;
                                                    new Future.delayed(
                                                        new Duration(
                                                            seconds: 1), () {
                                                      var res = Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (
                                                                  BuildContext context) =>
                                                                  navigationScreen(
                                                                      0,
                                                                      Floors,
                                                                      sortedKeys,
                                                                      index,
                                                                      null,
                                                                      widget
                                                                          .SelectedDate,
                                                                      "map")));
                                                    });
                                                  }
                                                }*/
                                              },
                                              text: Num_Floors[index]
                                                  .toString()
                                                  ),),
                                      ),
                                ),
                              ),
                            ),
                            NBRZones >= 6 ?
                            Container(
                              width: width * 0.1,
                              child: Neumorphic(
                                child: new IconButton(
                                  icon: new Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: LightColors.kDarkBlue, size: 20,),
                                  onPressed: () {
                                    _animateToIndex(NBRZones);
                                  },
                                ),
                              ),
                            )
                                : Container()

                          ],
                        ),
                      ),

                    ), Expanded(
                      flex: 12,
                      child: GestureDetector(
                        child: Align(
                            alignment: Alignment.topCenter,
                            child: Stack(
                                alignment: Alignment.topCenter,
                                children:
                                          List.generate(
                                          NBFloor,
                                          (idx) {
                                 return  Align(
                                   alignment: Alignment.topCenter,
                                   child: AnimatedBuilder(
                                     animation:  annimationControllerTab[0],
                                      builder: (_, child) {
                                       // print("annimatiooonnnnnn"+annimationControllerZ.toString());

                                        begin =begin-0.025;
                                        end =end-0.025;
                                        return Transform.translate(
                                          offset: Offset(
                                              animationTab[1].value,Tween<double>(begin: begin * height, end: end * height).animate(
                                              AnimationController(
                                                  vsync: this,
                                                  duration: Duration(seconds: 1),
                                                  reverseDuration: Duration(seconds: 3))).value),
                                          child: child,
                                        );
                                      },
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child:(Num_Floors.contains("0"+idx.toString()))
                                            ? Container(
                                            width: width * 0.7,
                                            child:SvgPicture.string(""""$ImageBuildingActive""",)
                                        ):Container(
                                            width: width * 0.7,
                                            child:SvgPicture.string(""""$ImageBuilding""",)
                                        ),
                                      ),
                                    ),
                                 );}
                          /*        (Floors.keys.toList().contains("Parking -2"))
                                      ? AnimatedBuilder(
                                    animation: animationControllerp2,
                                    builder: (_, child) {
                                      return Transform.translate(
                                        offset: Offset(animationp2.value,
                                            animationp21.value),
                                        child: child,
                                      );
                                    },
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: width * 0.7,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/parking.png"),
                                        ),
                                      ),


                                    ),
                                  )
                                      : AnimatedBuilder(
                                    animation: animationControllerp2,
                                    builder: (_, child) {
                                      return Transform.translate(
                                        offset: Offset(animationp2.value,
                                            animationp21.value),
                                        child: child,
                                      );
                                    },
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: width * 0.7,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/parkingGris.png"),
                                        ),
                                      ),


                                    ),
                                  ),
                                  (Floors.keys.toList().contains("Parking -1"))
                                      ? AnimatedBuilder(
                                    animation: animationControllerp1,
                                    builder: (_, child) {
                                      return Transform.translate(
                                        offset: Offset(animationp1.value,
                                            animationp11.value),
                                        child: child,
                                      );
                                    },
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: width * 0.7,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/parking.png"),
                                        ),
                                      ),


                                    ),
                                  )
                                      : AnimatedBuilder(
                                    animation: animationControllerp1,
                                    builder: (_, child) {
                                      return Transform.translate(
                                        offset: Offset(animationp1.value,
                                            animationp11.value),
                                        child: child,
                                      );
                                    },
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: width * 0.7,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/parkingGris.png"),
                                        ),
                                      ),


                                    ),
                                  ),
                                  (Floors.keys.toList().contains("Floor 00"))
                                      ? AnimatedBuilder(
                                    animation: animationController0,
                                    builder: (_, child) {
                                      return Transform.translate(
                                        offset: Offset(animation0.value,
                                            animation01.value),
                                        child: child,
                                      );
                                    },
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: width * 0.7,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/floorav.png"),
                                        ),
                                      ),


                                    ),
                                  )
                                      : AnimatedBuilder(
                                    animation: animationController0,
                                    builder: (_, child) {
                                      return Transform.translate(
                                        offset: Offset(animation0.value,
                                            animation01.value),
                                        child: child,
                                      );
                                    },
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: width * 0.7,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/building1.png"),
                                        ),
                                      ),


                                    ),
                                  ),
                                  (Floors.keys.toList().contains("Floor 01"))
                                      ? AnimatedBuilder(
                                    animation: animationController1,
                                    builder: (_, child) {
                                      return Transform.translate(
                                        offset: Offset(
                                            animation1.value, 0.235 * height),
                                        child: child,
                                      );
                                    },
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: width * 0.7,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/floorav.png"),
                                        ),
                                      ),


                                    ),
                                  )
                                      : AnimatedBuilder(
                                    animation: animationController1,
                                    builder: (_, child) {
                                      return Transform.translate(
                                        offset: Offset(
                                            animation1.value, 0.235 * height),
                                        child: child,
                                      );
                                    },
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: width * 0.7,
                                        child:SvgPicture.string(""""$ImageBuilding""",)
                                      ),
                                    ),
                                  ),

                                  Hero(
                                    tag: 'imageHero',
                                    child: AnimatedBuilder(
                                      animation: animationController2,
                                      builder: (_, child) {
                                        return Transform.translate(
                                          offset: Offset(
                                              animation2.value, 0.21 * height),
                                          child: child,
                                        );
                                      },
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          width: width * 0.7,
                                          child: Image(
                                            image: AssetImage(
                                                "assets/images/building1.png"),
                                          ),
                                        ),


                                      ),
                                    ),
                                  ),
                                  AnimatedBuilder(
                                    animation: animationController3,
                                    builder: (_, child) {
                                      return Transform.translate(
                                        offset: Offset(
                                            animation3.value, 0.185 * height),
                                        child: child,
                                      );
                                    },
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: width * 0.7,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/building1.png"),
                                        ),
                                      ),


                                    ),
                                  ),
                                  AnimatedBuilder(
                                    animation: animationController4,
                                    builder: (_, child) {
                                      return Transform.translate(
                                        offset: Offset(
                                            animation4.value, 0.16 * height),
                                        child: child,
                                      );
                                    },
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: width * 0.7,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/building1.png"),
                                        ),
                                      ),


                                    ),
                                  ),

                                  (Floors.keys.toList().contains("Floor 05"))
                                      ? AnimatedBuilder(
                                    animation: animationController5,
                                    builder: (_, child) {
                                      return Transform.translate(
                                        offset: Offset(animation5.value,
                                            animation51.value),
                                        child: child,
                                      );
                                    },
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: width * 0.7,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/floorav.png"),
                                        ),
                                      ),


                                    ),
                                  )
                                      : AnimatedBuilder(
                                    animation: animationController5,
                                    builder: (_, child) {
                                      return Transform.translate(
                                        offset: Offset(animation5.value,
                                            animation51.value),
                                        child: child,
                                      );
                                    },
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: width * 0.7,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/building1.png"),
                                        ),
                                      ),


                                    ),
                                  ),
                                  (Floors.keys.toList().contains("Floor 06"))
                                      ? AnimatedBuilder(
                                    animation: animationController6,
                                    builder: (_, child) {
                                      return Transform.translate(
                                        offset: Offset(animation6.value,
                                            animation61.value),
                                        child: child,
                                      );
                                    },
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: width * 0.7,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/floorav.png"),
                                        ),
                                      ),


                                    ),
                                  )
                                      : AnimatedBuilder(
                                    animation: animationController6,
                                    builder: (_, child) {
                                      return Transform.translate(
                                        offset: Offset(animation6.value,
                                            animation61.value),
                                        child: child,
                                      );
                                    },
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: width * 0.7,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/building1.png"),
                                        ),
                                      ),


                                    ),
                                  ),
                                  (Floors.keys.toList().contains("Floor 07"))
                                      ? AnimatedBuilder(
                                    animation: animationController7,
                                    builder: (_, child) {
                                      return Transform.translate(
                                        offset: Offset(animation7.value,
                                            animation71.value),
                                        child: child,
                                      );
                                    },
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: width * 0.7,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/floorav.png"),
                                        ),
                                      ),


                                    ),
                                  )
                                      : AnimatedBuilder(
                                    animation: animationController7,
                                    builder: (_, child) {
                                      return Transform.translate(
                                        offset: Offset(animation7.value,
                                            animation71.value),
                                        child: child,
                                      );
                                    },
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: width * 0.7,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/building1.png"),
                                        ),
                                      ),


                                    ),
                                  ),

                                  (Floors.keys.toList().contains("Floor 08"))
                                      ? AnimatedBuilder(
                                    animation: animationController8,
                                    builder: (_, child) {
                                      return Transform.translate(
                                        offset: Offset(animation8.value,
                                            animation81.value),
                                        child: child,
                                      );
                                    },
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: width * 0.7,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/floorav.png"),
                                        ),
                                      ),


                                    ),
                                  )
                                      : AnimatedBuilder(
                                    animation: animationController8,
                                    builder: (_, child) {
                                      return Transform.translate(
                                        offset: Offset(animation8.value,
                                            animation81.value),
                                        child: child,
                                      );
                                    },
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: width * 0.7,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/building1.png"),
                                        ),
                                      ),


                                    ),
                                  ),
                                  (Floors.keys.toList().contains("Floor 09"))
                                      ? AnimatedBuilder(
                                    animation: animationController9,
                                    builder: (_, child) {
                                      return Transform.translate(
                                        offset: Offset(animation9.value,
                                            animation91.value),
                                        child: child,
                                      );
                                    },
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: width * 0.7,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/floorav.png"),
                                        ),
                                      ),


                                    ),
                                  )
                                      : AnimatedBuilder(
                                    animation: animationController9,
                                    builder: (_, child) {
                                      return Transform.translate(
                                        offset: Offset(animation9.value,
                                            animation91.value),
                                        child: child,
                                      );
                                    },
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: width * 0.7,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/building1.png"),
                                        ),
                                      ),


                                    ),
                                  ),
                                  (Floors.keys.toList().contains("Floor 10"))
                                      ? AnimatedBuilder(
                                    animation: animationController10,
                                    builder: (_, child) {
                                      return Transform.translate(
                                        offset: Offset(animation10.value,
                                            animation101.value),
                                        child: child,
                                      );
                                    },
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: width * 0.7,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/floorav.png"),
                                        ),
                                      ),


                                    ),
                                  )
                                      : AnimatedBuilder(
                                    animation: animationController10,
                                    builder: (_, child) {
                                      return Transform.translate(
                                        offset: Offset(animation10.value,
                                            animation101.value),
                                        child: child,
                                      );
                                    },
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: width * 0.7,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/building1.png"),
                                        ),
                                      ),


                                    ),
                                  ),
*/
                                          ) )),
                        onTap: () {

                        },
                      ),

                    ),
                  ],
                )

                    : Center(child: CircularProgressIndicator());
            }
            return Center(child: CircularProgressIndicator());
          }
        // By default, show a loading spinner


        // By default, show a loading spinner

      );
  }
}