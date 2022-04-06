
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:folding_cell/folding_cell/widget.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/models/Reservations.dart';
import 'package:vato/services/DeskServices.dart';
import 'package:vato/services/OperationsService.dart';
import 'package:vato/services/ReservationService.dart';
import 'package:vato/services/ZoneService.dart';
import 'package:vato/widgets/navBar.dart';

class ListViewDesck extends StatefulWidget {
  String StringDate;
  String user;
  DateTime selectedDate;

  ListViewDesck(this.StringDate, this.user, this.selectedDate, {Key key})
      : super(key: key);

  @override
  _ListViewDesckState createState() => _ListViewDesckState();
}

List<dynamic> Zones = [];
List<dynamic> Desks = [];

int NBRZones = 0;
int NBDesks = 0;

class _ListViewDesckState extends State<ListViewDesck> {
  List<String> selectedCountList = [];
  String firstname;
  ZoneService Zs = new ZoneService();
  DeskServices Ds = new DeskServices();
  List<dynamic> Zones = [];
  DateTime selectedDate;
  String tokenLogin;
  int NBRZones = 0;
  Future<SharedPreferences> _prefs;

  @override
  void initState() {
    _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      setState(() {
        this.tokenLogin = prefs.get("token").toString();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: NeumorphicColors.background,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              width: width,
              decoration: BoxDecoration(
                  color: NeumorphicColors.background,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))),
              child: FutureBuilder(
                  future:
                  Zs.getZoneByUser(widget.user.toString(), this.tokenLogin)
                          .then((value) async {
                    DateTime Now = await DateTime.now();
                    var newFormat = DateFormat("yyyy-MM-dd");
                    if (widget.StringDate == newFormat.format(Now)) {
                      if (value["data"] == null) {
                        NBRZones = 0;
                        Zones = value["data"];
                      } else {
                        NBRZones = value["data"].length;
                        Zones = value["data"];
                      }
                    } else {
                      if (value["data"] == null) {
                        NBRZones = 0;
                        Zones = value["data"];
                      } else {
                        Zones = value["data"]
                            .where((i) =>
                                i["Zone"].toString().substring(0, 1) != "-")
                            .toList();
                        NBRZones = Zones.length;
                      }
                    }
                  }),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Center(child: CircularProgressIndicator());
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      case ConnectionState.done:
                        return (NBRZones != 0)
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: NBRZones,
                                      itemBuilder: (context, indexzone) {
                                        return SimpleFoldingCell(
                                          frontWidget: _buildFrontWidget(
                                              indexzone, Zones),
                                          innerTopWidget: _buildInnerWidget(
                                              indexzone, Zones),
                                          innerBottomWidget:
                                          _buildInnerButtomwidget(
                                              indexzone,
                                              Zones,
                                              widget.StringDate,
                                              widget.user.toString(),
                                              this.tokenLogin,
                                              context,
                                              widget.selectedDate),
                                          cellSize: Size(width, height / 5),
                                          padding: EdgeInsets.only(
                                              bottom: height / 500),
                                          animationDuration:
                                              Duration(milliseconds: 300),
                                          borderRadius: 10,

                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : Center(
                                child: Text("No Zone"),
                              );
                    }
                    return Center(child: CircularProgressIndicator());
                  }
                  // By default, show a loading spinner

                  ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildInnerWidget(int index, List<dynamic> zones) {
  return Builder(
    builder: (BuildContext context) {
      var size = MediaQuery.of(context).size;
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;
      return GestureDetector(
        child: Container(
            color: Colors.white24,
            child: Neumorphic(
              style: NeumorphicStyle(
                color: NeumorphicColors.background,
              ),
              child: Container(
                  height: height,
                  width: width,
                  child: Neumorphic(
                      style: NeumorphicStyle(
                        /* border: NeumorphicBorder(
                                  isEnabled: true,
                                  color:LightColors.kDarkBlue,
                                  width: 1,
                                ),*/
                        color: NeumorphicColors.background,
                      ),
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            // margin: EdgeInsets.all(5),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              //mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 25),
                                  child: NeumorphicText(
                                    zones[index]["Zone"].toString(),
                                    textStyle: NeumorphicTextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    style: NeumorphicStyle(
                                        color: LightColors.kDarkBlue),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 25),
                                  child: NeumorphicText(
                                    zones[index]["Floor"].toString(),
                                    textStyle: NeumorphicTextStyle(
                                      fontSize: 15,
                                    ),
                                    style: NeumorphicStyle(
                                        color: LightColors.kDarkBlue),
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Neumorphic(
                              style: NeumorphicStyle(
                                shadowDarkColor: LightColors.kDarkBlue,
                                color: NeumorphicColors.background,
                              ),
                              child: Container(
                                //  margin: EdgeInsets.only(bottom: 10),
                                height: height / 17,
                                width: width / 6,
                                child: Center(
                                  child: NeumorphicText(
                                    zones[index]["Desks"].toString(),
                                    textStyle: NeumorphicTextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                    style: NeumorphicStyle(
                                      // shape: NeumorphicShape.flat,
                                      depth: 20,
                                      intensity: 1,
                                      surfaceIntensity: 0,
                                      color: LightColors.kDarkBlue,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: Icon(Icons.arrow_drop_up),
                                  iconSize: 30,
                                  //focusColor: Colors.green,
                                  color: LightColors.kbluen,
                                  onPressed: () {
                                    final foldingCellState =
                                        context.findAncestorStateOfType<
                                            SimpleFoldingCellState>();
                                    foldingCellState?.toggleFold();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))),
            )),
        onTap: () {
          final foldingCellState =
              context.findAncestorStateOfType<SimpleFoldingCellState>();
          foldingCellState?.toggleFold();
        },
      );
    },
  );
}

Widget _buildFrontWidget(int index, List<dynamic> zones) {
  return Builder(
    builder: (BuildContext context) {
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;
      return GestureDetector(
        child: Container(
          child: Neumorphic(
              style: NeumorphicStyle(
                color: NeumorphicColors.background,
              ),
              child: Container(
                  margin: EdgeInsets.fromLTRB(10, 25, 10, 25),
                  height: height,
                  width: width,
                  child: Neumorphic(
                      style: NeumorphicStyle(
                        color: NeumorphicColors.background,
                      ),
                      child: Container(
                        //  margin: EdgeInsets.all(30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              flex: 6,
                              child: Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      //  margin: EdgeInsets.only(left: 25),
                                      child: NeumorphicText(
                                        zones[index]["Zone"].toString(),
                                        textStyle: NeumorphicTextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        style: NeumorphicStyle(
                                            color: LightColors.kbluel),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: NeumorphicText(
                                        zones[index]["Floor"].toString(),
                                        textStyle: NeumorphicTextStyle(
                                          fontSize: 15,
                                        ),
                                        style: NeumorphicStyle(
                                            color: LightColors.kDarkBlue),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 3,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Image(
                                    // fit: BoxFit.fill,
                                    height: height * 0.5,
                                    width: width * 0.1,
                                    image: AssetImage("assets/images/mapF.png"),
                                  ),
                                )),
                            Spacer(),
                            Expanded(
                              flex: 1,
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Center(
                                    child: NeumorphicText(
                                      zones[index]["Desks"].toString(),
                                      textStyle: NeumorphicTextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      style: NeumorphicStyle(
                                          color: LightColors.kbluel),
                                    ),
                                  )),
                            ),
                            Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: Icon(Icons.arrow_drop_down),
                                  //focusColor: Colors.green,
                                  iconSize: 30,
                                  color: LightColors.kDarkBlue,
                                  onPressed: () {
                                    final foldingCellState =
                                        context.findAncestorStateOfType<
                                            SimpleFoldingCellState>();
                                    foldingCellState?.toggleFold();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )))),
        ),
        onTap: () {
          final foldingCellState =
          context.findAncestorStateOfType<SimpleFoldingCellState>();
          foldingCellState?.toggleFold();
        },
      );
    },
  );
}

class _buildInnerButtomwidget extends StatefulWidget {
  int indexzone;
  List<dynamic> zones;
  String StringDate;
  String user;
  String tokenLogin;
  dynamic context2;
  dynamic DateSelected;
  List<dynamic> ListDesks;

  _buildInnerButtomwidget(this.indexzone, this.zones, this.StringDate,
      this.user, this.tokenLogin, this.context2, this.DateSelected, {Key key})
      : super(key: key);

  @override
  __buildInnerButtomwidgetState createState() =>
      __buildInnerButtomwidgetState();
}

class __buildInnerButtomwidgetState extends State<_buildInnerButtomwidget> {
  List<dynamic> AllDesks = [];
  List<dynamic> ListDesks = [];
  Future <List<dynamic>>getListDesks;
  DeskServices _deskServices = new DeskServices();
  String result;
  bool StatutAM = true;
  bool StatutPM = true;

  Future<List> GetDesks(zones, indexzone) async {
    var newFormat = DateFormat("yyyy-MM-dd");
    String StringDate = newFormat.format(widget.DateSelected);
    await _deskServices.getAvailability(
        zones[indexzone]["id"], StringDate.toString(), widget.tokenLogin)
        .then((value) {
      setState(() {
        AllDesks = value["data"][0]["Desks"];
      });

      AllDesks.forEach((element) {
        if (element["statusAM"] == "AVAILABLE" ||
            element["statusPM"] == "AVAILABLE") {
          ListDesks.add(element);
        }
      });
    });
    return AllDesks;
  }

  checkSlot(iduser, date, slot, resource) async {
    if (resource == "Parking -1" || resource.toString() == "Parking -2") {
      result = "parking";
    } else {
      result = "Desk";
    }
    var newFormat = DateFormat("yyyy-MM-dd");
    await ReservationService()
        .checkAvailibility(
        iduser.toString(), date.toString(), "PM", result, widget.tokenLogin)
        .then((value) async {
      if (value["data"] == 201) {
        StatutPM = false;
      } else {
        StatutPM = true;
      }
    });

    await ReservationService()
        .checkAvailibility(
        iduser.toString(), date.toString(), "AM", result, widget.tokenLogin)
        .then((value) async {
      DateTime Now = DateTime.now();

      if (value["data"] == 201) {
        StatutAM = false;
      } else {
        if (date == newFormat.format(Now)) {
          if (DateFormat('a').format(Now) == "AM") {
            StatutAM = true;
          } else if ((DateFormat('a').format(Now) == "PM") &&
              slot == "AM") {
            StatutAM = false;
          } else {
            StatutAM = true;
          }
        } else {
          StatutAM = true;
        }
      }
    });
  }

  @override
  void initState() {
    setState(() {
      getListDesks = GetDesks(widget.zones, widget.indexzone);
    });
    // TODO: implement initState
    super.initState();
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
    return GestureDetector(
        child: Neumorphic(
          style: NeumorphicStyle(
            //  boxShape: NeumorphicBoxShape.stadium(),
              color: NeumorphicColors.background),
          padding: EdgeInsets.only(top: 0),
          child: Neumorphic(
            margin: EdgeInsets.symmetric(vertical: 0.0),
            child: ListView.builder(
                itemCount: ListDesks.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, x) {
                  return Container(
                    margin: EdgeInsets.only(left: 20),
                    height: height - 10,
                    width: width - width / 2,
                    color: NeumorphicColors.background,
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Neumorphic(
                          //margin: EdgeInsets.only(left: 50),
                          style: NeumorphicStyle(
                            shape: NeumorphicShape.flat,
                            depth: 10,
                          ),
                          child: Container(
                            // height: height/3,
                            width: width / 2.5,
                            color: NeumorphicColors.background,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  height: height / 300,
                                ),
                                Center(
                                  child: AutoSizeText(
                                    ListDesks[x]["deskname"]
                                        .toString(),
                                    style: TextStyle(
                                        color: LightColors.kdBlue,
                                        fontSize: 17),
                                    maxLines: 1,
                                    minFontSize: 13,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: width / 25),
                                      alignment:
                                      Alignment.centerLeft,
                                      /*padding: EdgeInsets.all(
                                                            5)*/
                                      child: AutoSizeText("AM ",
                                          style: TextStyle(
                                              color: LightColors
                                                  .kdBlue,
                                              fontSize: 17),
                                          maxLines: 1,
                                          minFontSize: 13),
                                    ),
                                    (ListDesks[x]["statusAM"] ==
                                        "AVAILABLE")
                                        ? NeumorphicIcon(
                                      Icons.check_circle,
                                      style: NeumorphicStyle(
                                          depth: 20,
                                          color: LightColors
                                              .kGreen),
                                    )
                                        : NeumorphicIcon(
                                      Icons.cancel,
                                      style: NeumorphicStyle(
                                          depth: 20,
                                          color: LightColors
                                              .kRed),
                                    ),
                                    Spacer(),
                                    Container(
                                      alignment:
                                      Alignment.centerLeft,
                                      child: AutoSizeText("PM ",
                                          style: TextStyle(
                                              color: LightColors
                                                  .kdBlue,
                                              fontSize: 17),
                                          maxLines: 1,
                                          minFontSize: 13),
                                    ),
                                    (ListDesks[x]["statusPM"] ==
                                        "AVAILABLE")
                                        ? Container(
                                      margin:
                                      EdgeInsets.only(
                                          right: width /
                                              25),
                                      child: NeumorphicIcon(
                                        Icons.check_circle,
                                        style: NeumorphicStyle(
                                            depth: 20,
                                            color:
                                            LightColors
                                                .kGreen),
                                      ),
                                    )
                                        : Container(
                                      margin:
                                      EdgeInsets.only(
                                          right: width /
                                              25),
                                      child:
                                      (NeumorphicIcon(
                                        Icons.cancel,
                                        style: NeumorphicStyle(
                                            depth: 20,
                                            color:
                                            LightColors
                                                .kRed),
                                      )),
                                    ),
                                  ],
                                ),
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: NeumorphicButton(
                                        style: NeumorphicStyle(
                                            depth: 30.0,
                                            color: LightColors
                                                .kDarkBlue),
                                        child: Center(
                                          child: Text("Book",
                                              style: TextStyle(
                                                  color: Colors
                                                      .white,
                                                  fontWeight:
                                                  FontWeight
                                                      .bold)),
                                        ),
                                        onPressed: () async {
                                          await checkSlot(
                                              widget.user.toString(),
                                              widget.StringDate,
                                              "AM",
                                              widget.zones[widget.indexzone][
                                              "Floor"]); // TODO: implement initState

                                          _openPopup(
                                              context,
                                              widget.StringDate,
                                              ListDesks[x],
                                              widget.user.toString(),
                                              widget.zones[widget.indexzone]
                                              ["id"],
                                              StatutAM,
                                              StatutPM,
                                              widget.tokenLogin,
                                              widget.context2,
                                              widget.indexzone,
                                              widget.DateSelected);
                                          //    getDesks(widget.zones[widget.index]["id"], widget.selectedDate.toString());
                                        }),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ),
        ),
        onTap: () {
          final foldingCellState = context
              .findAncestorStateOfType<SimpleFoldingCellState>();
          foldingCellState?.toggleFold();
        });
  }
}


/*Widget _buildInnerButtomWidget(
    int indexzone,
    List<dynamic> zones,
    String selectedDate,
    String user,
    String tokenLogin,
    context2,
    DateSelected,
   Future<dynamic> getGesks(zones,indexzone),
   List<dynamic> ListDesks) {
  bool StatutAM = true;
  bool StatutPM = true;

  String result;
  checkSlot(iduser, date, slot, resource) async {
    if (resource == "Parking -1" || resource.toString() == "Parking -2") {
      result = "parking";
    } else {
      result = "Desk";
    }
    var newFormat = DateFormat("yyyy-MM-dd");
    await ReservationService()
        .checkAvailibility(
            iduser.toString(), date.toString(), "PM", result, tokenLogin)
        .then((value) async {

      if (value["data"] == 201) {
        StatutPM = false;
      } else {
        StatutPM = true;
      }
    });

    await ReservationService()
        .checkAvailibility(
            iduser.toString(), date.toString(), "AM", result, tokenLogin)
        .then((value) async {
      DateTime Now= await NTP.now();

      if (value["data"] == 201) {
        StatutAM = false;
      } else {
        if (date == newFormat.format(Now)) {
          if (DateFormat('a').format(Now) == "AM") {
            StatutAM = true;
          } else if ((DateFormat('a').format(Now) == "PM") &&
              slot == "AM") {
            StatutAM = false;
          } else {
            StatutAM = true;
          }
        } else {

          StatutAM = true;
        }
      }
    });

  }

  DeskServices Ds = new DeskServices();


  return Builder(builder: (context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: getGesks(zones,indexzone),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(child: Text("zzzz"));
            case ConnectionState.waiting:
              return Center(child: Text("aaaaaa"));
            case ConnectionState.done:
              return (  ListDesks.length != 0)
                  ? GestureDetector(
                      child: Neumorphic(
                        style: NeumorphicStyle(
                            //  boxShape: NeumorphicBoxShape.stadium(),
                            color: NeumorphicColors.background),
                        padding: EdgeInsets.only(top: 0),
                        child: Neumorphic(
                          margin: EdgeInsets.symmetric(vertical: 0.0),
                          child: ListView.builder(
                              itemCount: ListDesks.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, x) {
                                return Container(
                                  margin: EdgeInsets.only(left: 20),
                                  height: height - 10,
                                  width: width - width / 2,
                                  color: NeumorphicColors.background,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Neumorphic(
                                        //margin: EdgeInsets.only(left: 50),
                                        style: NeumorphicStyle(
                                          shape: NeumorphicShape.flat,
                                          depth: 10,
                                        ),
                                        child: Container(
                                          // height: height/3,
                                          width: width / 2.5,
                                          color: NeumorphicColors.background,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              SizedBox(
                                                height: height / 300,
                                              ),
                                              Center(
                                                child: AutoSizeText(
                                                  ListDesks[x]["deskname"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: LightColors.kdBlue,
                                                      fontSize: 17),
                                                  maxLines: 1,
                                                  minFontSize: 13,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: width / 25),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    */ /*padding: EdgeInsets.all(
                                                            5)*/
/*
                                                    child: AutoSizeText("AM ",
                                                        style: TextStyle(
                                                            color: LightColors
                                                                .kdBlue,
                                                            fontSize: 17),
                                                        maxLines: 1,
                                                        minFontSize: 13),
                                                  ),
                                                  (ListDesks[x]["statusAM"] ==
                                                          "AVAILABLE")
                                                      ? NeumorphicIcon(
                                                          Icons.check_circle,
                                                          style: NeumorphicStyle(
                                                              depth: 20,
                                                              color: LightColors
                                                                  .kGreen),
                                                        )
                                                      : NeumorphicIcon(
                                                          Icons.cancel,
                                                          style: NeumorphicStyle(
                                                              depth: 20,
                                                              color: LightColors
                                                                  .kRed),
                                                        ),
                                                  Spacer(),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: AutoSizeText("PM ",
                                                        style: TextStyle(
                                                            color: LightColors
                                                                .kdBlue,
                                                            fontSize: 17),
                                                        maxLines: 1,
                                                        minFontSize: 13),
                                                  ),
                                                  (ListDesks[x]["statusPM"] ==
                                                          "AVAILABLE")
                                                      ? Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: width /
                                                                      25),
                                                          child: NeumorphicIcon(
                                                            Icons.check_circle,
                                                            style: NeumorphicStyle(
                                                                depth: 20,
                                                                color:
                                                                    LightColors
                                                                        .kGreen),
                                                          ),
                                                        )
                                                      : Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: width /
                                                                      25),
                                                          child:
                                                              (NeumorphicIcon(
                                                            Icons.cancel,
                                                            style: NeumorphicStyle(
                                                                depth: 20,
                                                                color:
                                                                    LightColors
                                                                        .kRed),
                                                          )),
                                                        ),
                                                ],
                                              ),
                                              Center(
                                                child: Container(
                                                  padding: EdgeInsets.all(5),
                                                  child: NeumorphicButton(
                                                      style: NeumorphicStyle(
                                                          depth: 30.0,
                                                          color: LightColors
                                                              .kDarkBlue),
                                                      child: Center(
                                                        child: Text("Book",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                      onPressed: () async {
                                                        await checkSlot(
                                                            user.toString(),
                                                            selectedDate,
                                                            "AM",
                                                            zones[indexzone][
                                                                "Floor"]); // TODO: implement initState

                                                        _openPopup(
                                                            context,
                                                            selectedDate,
                                                            ListDesks[x],
                                                            user.toString(),
                                                            zones[indexzone]
                                                                ["id"],
                                                            StatutAM,
                                                            StatutPM,
                                                            tokenLogin,
                                                            context2,
                                                            indexzone,
                                                            DateSelected);
                                                        //    getDesks(widget.zones[widget.index]["id"], widget.selectedDate.toString());
                                                      }),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                      onTap: () {
                        final foldingCellState = context
                            .findAncestorStateOfType<SimpleFoldingCellState>();
                        foldingCellState?.toggleFold();
                      })
                  : Center(child: Text("No desks"));
          }
          return Center(child: CircularProgressIndicator());
        }
        // By default, show a loading spinner

        );
  });
}*/

_openPopup(context1, selectedDate, Desks, userid, zones, StatutAM, StatutPM,
    tokenLogin, context2, indexzones, DateSelected) {
  double width = MediaQuery.of(context1).size.width;
  double height = MediaQuery.of(context1).size.height;
  List<Reservations> reservations = [];
  bool PMVAL = false;
  bool AMVAL = false;
  void STATEPM(setState) {
    setState(() {
      PMVAL = !PMVAL;
    });
  }

  void STATEAM(setState) {
    setState(() {
      AMVAL = !AMVAL;
    });
  }

  void state(setState) {
    setState(() {
//
//
      selectedDate = selectedDate;
    });
  }

  String Function() title() {
    return () {
      if (((Desks["statusAM"] == "BOOKED") ||
              StatutAM == false ||
              Desks["statusAM"] == "OCCUPIED") &&
          ((Desks["statusPM"] == "BOOKED") ||
              StatutPM == false ||
              Desks["statusPM"] == "OCCUPIED")) {
        return 'Booking is not allowed !';
      } else {
        return "Choose your time slot";
      }
    };
  }

  var tit = title();
  var alertStyle = AlertStyle(
    animationType: AnimationType.shrink,
    isCloseButton: true,
    //isOverlayTapDismiss: true,
    backgroundColor: Colors.black12,
    titleStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    descTextAlign: TextAlign.start,
    animationDuration: Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0.0),
      side: BorderSide(
        color: Colors.grey,
      ),
    ),
    descStyle: TextStyle(
      color: LightColors.kbluen,
    ),
    alertAlignment: Alignment.center,
  );
  Alert(
    context: context1,
    title: Desks["deskname"],
    type: AlertType.info,
    style: alertStyle,
    desc: tit().toString(),
    content: StatefulBuilder(
      builder: (context, StateSetter setState) {
        return Column(children: <Widget>[
          SizedBox(
            height: height / 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // [Monday] checkbox
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "AM",
                    style: TextStyle(color: Colors.white),
                  ),
                  if ((Desks["statusAM"] == "BOOKED") ||
                      StatutAM == false ||
                      Desks["statusAM"] == "OCCUPIED")
                    IconButton(
                      icon: Icon(Icons.cancel_outlined),
                      color: LightColors.kRed,
                      onPressed: () {},
                    )
                  else
                    (AMVAL == false)
                        ? IconButton(
                            icon: Icon(Icons.radio_button_unchecked),
                            color: Colors.white,
                            onPressed: () {
                              STATEAM(setState);
                            },
                          )
                        : IconButton(
                            icon: Icon(Icons.check_circle_outline),
                            color: Colors.green,
                            onPressed: () {
                              STATEAM(setState);
                            },
                          ),
                  (Desks["statusAM"] == "BOOKED" ||
                          Desks["statusAM"] == "OCCUPIED")
                      ? Text(
                          Desks["userAM"]["firstname"].toString(),
                          style: TextStyle(color: Colors.grey, fontSize: 11),
                          maxLines: 1,
                        )
                      : Text(
                          "",
                          style: TextStyle(color: Colors.white),
                        ),
                  (Desks["statusAM"] == "BOOKED" ||
                          Desks["statusAM"] == "OCCUPIED")
                      ? Text(
                          Desks["userAM"]["lastname"].toString(),
                          style: TextStyle(color: Colors.grey, fontSize: 11),
                          maxLines: 1,
                        )
                      : Text(
                          "",
                          style: TextStyle(color: Colors.white),
                        )
                ],
              ),
              // [Tuesday] checkbox
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "PM",
                    style: TextStyle(color: Colors.white),
                  ),
                  (Desks["statusPM"] == "BOOKED" ||
                          StatutPM == false ||
                          Desks["statusPM"] == "OCCUPIED")
                      ? IconButton(
                          icon: Icon(Icons.cancel_outlined),
                          color: LightColors.kRed,
                          onPressed: () {},
                        )
                      : (PMVAL == false)
                          ? IconButton(
                              icon: Icon(Icons.radio_button_unchecked),
                              color: Colors.white,
                              onPressed: () {
                                STATEPM(setState);
                              },
                            )
                          : IconButton(
                              icon: Icon(Icons.check_circle_outline),
                              //focusColor: Colors.green,
                              color: Colors.green,
                              onPressed: () {
                                STATEPM(setState);
                              },
                            ),
                  (Desks["statusPM"] == "BOOKED" ||
                          Desks["statusPM"] == "OCCUPIED")
                      ? Text(
                          Desks["userPM"]["firstname"].toString(),
                          style: TextStyle(color: Colors.grey, fontSize: 11),
                          maxLines: 1,
                        )
                      : Text(
                          "",
                          style: TextStyle(color: Colors.white),
                        ),
                  (Desks["statusPM"] == "BOOKED" ||
                          Desks["statusPM"] == "OCCUPIED")
                      ? Text(
                          Desks["userPM"]["lastname"].toString(),
                          style: TextStyle(color: Colors.grey, fontSize: 11),
                          maxLines: 1,
                        )
                      : Text(
                          "",
                          style: TextStyle(color: Colors.white),
                        )
                ],
              ),
            ],
          ),
          SizedBox(
            height: height * 0.02,
          ),
          (((Desks["statusAM"] == "BOOKED") ||
                      StatutAM == false ||
                      Desks["statusAM"] == "OCCUPIED") &&
                  ((Desks["statusPM"] == "BOOKED") ||
                      StatutPM == false ||
                      Desks["statusPM"] == "OCCUPIED"))
              ? Center(
                  child: Text(
                  "",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ))
              : // [Wednesday] checkbox
              DialogButton(
                  width: width / 3,
                  color: LightColors.kDarkBlue,
                  onPressed: () {
                    Reservations reservation = new Reservations();
                    reservation.desk = Desks["id"].toString();
                    reservation.user = userid.toString();
                    reservation.reservationdate = selectedDate.toString();

                    if (PMVAL == true && AMVAL == true) {
                      Reservations reservationAM = new Reservations();
                      reservationAM.desk = Desks["id"].toString();
                      reservationAM.user = userid.toString();
                      reservationAM.reservationdate = selectedDate.toString();
                      reservationAM.timeslot = "AM";

                      reservations.add(reservationAM);

                      Reservations reservationPM = new Reservations();
                      reservationPM.desk = Desks["id"].toString();
                      reservationPM.user = userid.toString();
                      reservationPM.reservationdate = selectedDate.toString();
                      reservationPM.timeslot = "PM";
                      reservations.add(reservationPM);
                      Future<dynamic> addresesvationPM = OperationService().AddNewReservations(reservations, tokenLogin);
                      addresesvationPM.then((value) async {
                        if (value["data"] == 201) {
                          SweetAlert.show(context,
                              subtitle:
                                  "Ooops! You already have a reservation for this time slot!",
                              style: SweetAlertStyle.error);
                        }
                        if (value["data"] == 300) {
                          SweetAlert.show(context,
                              subtitle: "Ooops! Someone else just booked it!",
                              style: SweetAlertStyle.error);
                        }
                        if (value["data"] == 200) {
                          SweetAlert.show(context,
                              subtitle: "Booking ...",
                              style: SweetAlertStyle.loading);
                          await Future.delayed(new Duration(seconds: 1),
                              () async {
                            SweetAlert.show(context,
                                subtitle: " Done !",
                                style: SweetAlertStyle.success);
                          });

                          await Future.delayed(new Duration(seconds: 1),
                              () async {
                            await Navigator.pushReplacement(
                                context1,
                                MaterialPageRoute(
                                    builder: (context1) => navigationScreen(
                                        0,
                                        null,
                                        null,
                                        null,
                                        null,
                                        DateSelected,
                                        "list")));
                          });
                        }
                        if (value["status"] == 400) {
                          SweetAlert.show(context,
                              subtitle: "Ooops! Something Went Wrong!",
                              style: SweetAlertStyle.error);
                        }
                      });
                    }

                    if (PMVAL == true && AMVAL == false) {
                      reservation.timeslot = "PM";
                      Future<dynamic> addresesvationPM = OperationService().AddNewReservation(reservation, tokenLogin);
                      addresesvationPM.then((value) async {

                        if (value["data"] == 201) {
                          SweetAlert.show(context,
                              subtitle:
                                  "Ooops! You already have a reservation for this time slot!",
                              style: SweetAlertStyle.error);
                        }
                        if (value["data"] == 300) {
                          SweetAlert.show(context,
                              subtitle: "Ooops! Someone else just booked it!",
                              style: SweetAlertStyle.error);
                        }
                        if (value["data"] == 200) {
                          SweetAlert.show(context1,
                              subtitle: "Booking ...",
                              style: SweetAlertStyle.loading);
                          await Future.delayed(new Duration(seconds: 1),
                              () async {
                            SweetAlert.show(context1,
                                subtitle: " Done !",
                                style: SweetAlertStyle.success);
                          });

                          await Future.delayed(new Duration(seconds: 1),
                              () async {
                            await Navigator.pushReplacement(
                                context1,
                                MaterialPageRoute(
                                    builder: (context1) => navigationScreen(
                                        0,
                                        null,
                                        null,
                                        null,
                                        null,
                                        DateSelected,
                                        "list")));
                          });
                        }
                        if (value["status"] == 400) {
                          SweetAlert.show(context,
                              subtitle: "Ooops! Something Went Wrong!",
                              style: SweetAlertStyle.error);
                        }
                      });
                    }
                    if (PMVAL == false && AMVAL == true) {
                      reservation.timeslot = "AM";
                      Future<dynamic> addresesvationAM = OperationService().AddNewReservation(reservation, tokenLogin);
                      addresesvationAM.then((value) async {
                        if (value["data"] == 201) {
                          SweetAlert.show(context,
                              subtitle:
                                  "Ooops! You already have a reservation for this time slot!",
                              style: SweetAlertStyle.error);
                        }
                        if (value["data"] == 300) {
                          SweetAlert.show(context,
                              subtitle: "Ooops! Someone else just booked it!",
                              style: SweetAlertStyle.error);
                        }
                        if (value["data"] == 200) {
                          SweetAlert.show(context,
                              subtitle: "Booking ...",
                              style: SweetAlertStyle.loading);
                          await Future.delayed(new Duration(seconds: 1),
                              () async {
                            await SweetAlert.show(context1,
                                subtitle: " Done !",
                                style: SweetAlertStyle.success);
                          });

                          await Future.delayed(new Duration(seconds: 1),
                              () async {
                            await Navigator.pushReplacement(
                                context1,
                                MaterialPageRoute(
                                    builder: (context1) => navigationScreen(
                                        0,
                                        null,
                                        null,
                                        null,
                                        null,
                                        DateSelected,
                                        "list")));
                          });

                        }
                        if (value["status"] == 400) {
                          SweetAlert.show(context,
                              subtitle: "Ooops! Something Went Wrong!",
                              style: SweetAlertStyle.error);
                        }
                      });
                    }
                    if (PMVAL == false && AMVAL == false) {
                      return SweetAlert.show(context,
                          subtitle: "please check your time slot !",
                          style: SweetAlertStyle.error);
                    }
                  },
                  child: Text(
                    "BOOK",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
        ]);
      },
    ),
    buttons: [],
  ).show();
}
