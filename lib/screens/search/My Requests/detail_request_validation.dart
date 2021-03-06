import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/constants/link.dart';
import 'package:vato/screens/Home/Mission/detail_mission.dart';
import 'package:vato/screens/search/My%20Requests/myrequests.dart';
import 'package:vato/screens/search/My%20Requests/request_validation.dart';
import 'package:vato/services/MissionService.dart';
import 'package:vato/services/OperationsService.dart';
import 'package:vato/services/RequestService.dart';
import 'package:vato/widgets/navBar.dart';
import 'package:vato/widgets/topContainerBack.dart';

class DetailRequestValidation extends StatefulWidget {
  String Request_id;
  String manager;
  String Date;

  List UserTonotif;
  String StatusRequest;
  String image;
  String commentManager;
  String commentUser;
  dynamic mission;

  DetailRequestValidation(
      this.Request_id,
      this.manager,
      this.Date,
      this.UserTonotif,
      this.StatusRequest,
      this.image,
      this.commentManager,
      this.mission,
      {Key key})
      : super(key: key);

  @override
  _DetailRequestValidationState createState() =>
      _DetailRequestValidationState();
}

class _DetailRequestValidationState extends State<DetailRequestValidation> {
  Future<SharedPreferences> _prefs;
  String tokenLogin;
  String idUser;
  OperationService _operationService = new OperationService();
  RequestService _requestService = new RequestService();
  MissionService _missionService = new MissionService();
  TextEditingController commentController = new TextEditingController();

  DateTime selectedDate;
  Future<dynamic> getDetail;
  List<dynamic> Operations = [];
  var image;

  ImageProvider decideImage() {
    {
      if (widget.image == null) {
        return AssetImage("assets/images/user3.png");
      } else {
        return NetworkImage(link.linkw + "/uploads/" + widget.image);
      }
    }
  }

  @override
  void initState() {
    print("*****" + widget.commentUser.toString());
    print("******" + widget.mission["visaValidation"].toString());

    _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      setState(() {
        this.idUser = prefs.get("_id").toString();
        this.tokenLogin = prefs.get("token").toString();
      });

      getDetail = _operationService
          .getOperationsbyRequest(widget.Request_id, tokenLogin)
          .then((value) {
        setState(() {
          Operations = value["data"];
          Operations.sort((a, b) => b["updatedAt"].compareTo(a["updatedAt"]));
        });

        if (value["data"] != null) {
          Operations = value["data"].length;
        }
      });
      image = decideImage();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    CalendarController _controller = CalendarController();

    return Scaffold(
      backgroundColor: LightColors.kDarkBlue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TopContainerBack(),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
              decoration: BoxDecoration(
                  color: NeumorphicColors.background,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))),
              child: FutureBuilder(
                  future: getDetail,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Center(
                          child: LoadingAnimationWidget.hexagonDots(
                            color: LightColors.kDarkBlue,
                            size: 50,
                          ),
                        );
                      case ConnectionState.waiting:
                        return Center(
                          child: LoadingAnimationWidget.hexagonDots(
                            color: LightColors.kDarkBlue,
                            size: 50,
                          ),
                        );
                      case ConnectionState.done:
                        return SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              AutoSizeText(
                                " " + widget.mission["title"],
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                                maxLines: 1,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      //SizedBox(width: 10,),
                                      Neumorphic(
                                          style: NeumorphicStyle(
                                            depth: 3,

                                            //shape: NeumorphicShape.convex,
                                            color: NeumorphicColors.background,
                                            boxShape:
                                                NeumorphicBoxShape.circle(),
                                          ),
                                          child: Container(
                                            width: 70,
                                            height: 100,
                                            child: Image(
                                              image: image,
                                            ),
                                          )),
                                      Text(widget.manager),

                                      //     Spacer(),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 70,
                                        ),
                                        //   Spacer(),
                                        //  SizedBox(width: 10,),
                                        (widget.StatusRequest == "Processing")
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        30, 0, 10, 10),
                                                child: Text(
                                                  widget.StatusRequest,
                                                  style: TextStyle(
                                                      color: Colors.deepOrange,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 17),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            : (widget.StatusRequest == "Ending")
                                                ? Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        30, 10, 10, 10),
                                                    child: Text(
                                                      widget.StatusRequest,
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  )
                                                : (widget.StatusRequest ==
                                                        "Validation")
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                30, 10, 10, 10),
                                                        child: Text(
                                                          widget.StatusRequest,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      )
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                30, 10, 10, 10),
                                                        child: Text(
                                                          widget.StatusRequest,
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ),
                                        // Spacer(),
                                        // SizedBox(height: 5,),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              widget.mission["startDate"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget.mission["endDate"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13)),
                                        ),
                                      ]),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  padding: EdgeInsets.all(10),
                                  height: 550,
                                  child: Neumorphic(
                                      style: NeumorphicStyle(
                                        depth: 1,

                                        //shape: NeumorphicShape.convex,
                                        color: NeumorphicColors.background,
                                        boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.all(
                                                Radius.elliptical(20, 20))),
                                      ),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                "Information ",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 0),
                                                child: Container(
                                                  height: 50,
                                                  // color: Colors.grey[200],
                                                  child: Neumorphic(
                                                    style: NeumorphicStyle(
                                                      //     shape: NeumorphicShape.flat,
                                                      color: NeumorphicColors
                                                          .background,
                                                      boxShape:
                                                          NeumorphicBoxShape
                                                              .roundRect(
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: Text(
                                                            "Mission Country :",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 10),
                                                          child: Text(
                                                              widget.mission[
                                                                      "transportation"]
                                                                      [
                                                                      "missionCountry"]
                                                                      ["name"]
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 0),
                                                child: Container(
                                                  height: 50,
                                                  // color: Colors.grey[200],
                                                  child: Neumorphic(
                                                    style: NeumorphicStyle(
                                                      //     shape: NeumorphicShape.flat,
                                                      color: NeumorphicColors
                                                          .background,
                                                      boxShape:
                                                          NeumorphicBoxShape
                                                              .roundRect(
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: Text(
                                                            "Mission City :",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 10),
                                                          child: Text(
                                                              widget.mission[
                                                                      "transportation"]
                                                                      [
                                                                      "missionCity"]
                                                                      ["name"]
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 0),
                                                child: Container(
                                                  height: 70,
                                                  // color: Colors.grey[200],
                                                  child: Neumorphic(
                                                    style: NeumorphicStyle(
                                                      //     shape: NeumorphicShape.flat,
                                                      color: NeumorphicColors
                                                          .background,
                                                      boxShape:
                                                          NeumorphicBoxShape
                                                              .roundRect(
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                    ),
                                                    child: widget.mission[
                                                                    "transportation"]
                                                                [
                                                                "needTransportation"] ==
                                                            false
                                                        ? Center(
                                                            child: Expanded(
                                                              child: AutoSizeText(
                                                                  "pas de deolacement",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontSize:
                                                                          10)),
                                                            ),
                                                          )
                                                        : Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: <
                                                                      Widget>[
                                                                    Expanded(
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          AutoSizeText(
                                                                              widget.mission["transportation"]["onewayDepartureCountry"]["name"],
                                                                              style: TextStyle(color: Colors.black54, fontSize: 16)),
                                                                          AutoSizeText(
                                                                              " ( " + widget.mission["transportation"]["onewayDepartureCity"]["name"] + " )",
                                                                              style: TextStyle(color: Colors.black54, fontSize: 14))
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 0,
                                                                    ),

                                                                    widget.mission["transportation"]["roundTrip"] ==
                                                                            true
                                                                        ? Icon(
                                                                            Icons.compare_arrows,
                                                                            color:
                                                                                Colors.black54,
                                                                          )
                                                                        : Icon(
                                                                            Icons.arrow_right_alt,
                                                                            color:
                                                                                Colors.black54,
                                                                          ),

                                                                    Expanded(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          AutoSizeText(
                                                                              widget.mission["transportation"]["onewayDestinationCountry"]["name"],
                                                                              style: TextStyle(color: Colors.black54, fontSize: 16)),
                                                                          AutoSizeText(
                                                                              " ( " + widget.mission["transportation"]["onewayDestinationCity"]["name"] + " )",
                                                                              style: TextStyle(color: Colors.black54, fontSize: 14))
                                                                        ],
                                                                      ),
                                                                    ),

                                                                    //  Expanded( child: AutoSizeText(filtred[x]["mission"]["departureCountryAller"], style: TextStyle(color: Colors.black54)),)
                                                                  ]),
                                                              /*    widget.mission[
                                                                          "roundTrip"] ==
                                                                      true
                                                                  ? Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: <
                                                                          Widget>[
                                                                          Expanded(
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                AutoSizeText(widget.mission["returnDepartureCountry"]["name"], style: TextStyle(color: Colors.black54, fontSize: 16)),
                                                                                AutoSizeText(" ( " + widget.mission["returnDepartureCity"]["name"] + " )", style: TextStyle(color: Colors.black54, fontSize: 14))
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                0,
                                                                          ),

                                                                          Icon(
                                                                            Icons.compare_arrows,
                                                                            color:
                                                                                Colors.black,
                                                                          ),

                                                                          Expanded(
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                AutoSizeText(widget.mission["returnDestinationCountry"]["name"], style: TextStyle(color: Colors.black54, fontSize: 16)),
                                                                                AutoSizeText(" ( " + widget.mission["returnDestinationCity"]["name"] + " )", style: TextStyle(color: Colors.black54, fontSize: 14))
                                                                              ],
                                                                            ),
                                                                          ),

                                                                          //  Expanded( child: AutoSizeText(filtred[x]["mission"]["departureCountryAller"], style: TextStyle(color: Colors.black54)),)
                                                                        ])
                                                                  : Container(), */
                                                            ],
                                                          ),
                                                  ),
                                                )),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 0),
                                                child: Container(
                                                  height: 50,
                                                  // color: Colors.grey[200],
                                                  child: Neumorphic(
                                                    style: NeumorphicStyle(
                                                      //     shape: NeumorphicShape.flat,
                                                      color: NeumorphicColors
                                                          .background,
                                                      boxShape:
                                                          NeumorphicBoxShape
                                                              .roundRect(
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: Text(
                                                            "Object :",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 10),
                                                          child: Text(
                                                              widget.mission[
                                                                      "MissionObjet"]
                                                                      ["name"]
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 0),
                                                child: Container(
                                                  height: 50,
                                                  // color: Colors.grey[200],
                                                  child: Neumorphic(
                                                    style: NeumorphicStyle(
                                                      //     shape: NeumorphicShape.flat,
                                                      color: NeumorphicColors
                                                          .background,
                                                      boxShape:
                                                          NeumorphicBoxShape
                                                              .roundRect(
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: Text(
                                                            "Formula :",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 10),
                                                          child: Text(
                                                              widget.mission[
                                                                      "Formula"]
                                                                      ["name"]
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 0),
                                                child: Container(
                                                  height: 100,
                                                  // color: Colors.grey[200],
                                                  child: Neumorphic(
                                                    style: NeumorphicStyle(
                                                      //     shape: NeumorphicShape.flat,
                                                      color: NeumorphicColors
                                                          .background,
                                                      boxShape:
                                                          NeumorphicBoxShape
                                                              .roundRect(
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: Text(
                                                            "transportation Comment :",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10,
                                                                  top: 10),
                                                          child: Container(
                                                            height: 70,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            child:
                                                                SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              child: Center(
                                                                child: Text(
                                                                    widget
                                                                        .mission[
                                                                            "transportation"]
                                                                            [
                                                                            "transportationComment"]
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                          ]))),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                  padding: EdgeInsets.all(10),
                                  height: 500,
                                  child: Neumorphic(
                                      style: NeumorphicStyle(
                                        depth: 1,

                                        //shape: NeumorphicShape.convex,
                                        color: NeumorphicColors.background,
                                        boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.all(
                                                Radius.elliptical(20, 20))),
                                      ),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                "Expenses ",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 0),
                                                child: Container(
                                                  height: 50,
                                                  // color: Colors.grey[200],
                                                  child: Neumorphic(
                                                    style: NeumorphicStyle(
                                                      //     shape: NeumorphicShape.flat,
                                                      color: NeumorphicColors
                                                          .background,
                                                      boxShape:
                                                          NeumorphicBoxShape
                                                              .roundRect(
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: Text(
                                                            "Applicable perdiem :",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 10),
                                                          child: widget.mission[
                                                                          "expenses"]
                                                                      [
                                                                      "perdiem"] ==
                                                                  null
                                                              ? Text(
                                                                  "No perdieme",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black))
                                                              : Row(
                                                                  children: [
                                                                    Text(
                                                                        widget
                                                                            .mission["expenses"]["perdiem"][
                                                                                "indemnity"]
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black)),
                                                                    Icon(
                                                                      Icons
                                                                          .euro,
                                                                      color: LightColors
                                                                          .kDarkBlue,
                                                                    ),
                                                                  ],
                                                                ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 0),
                                                child: Container(
                                                  height: 50,
                                                  // color: Colors.grey[200],
                                                  child: Neumorphic(
                                                    style: NeumorphicStyle(
                                                      //     shape: NeumorphicShape.flat,
                                                      color: NeumorphicColors
                                                          .background,
                                                      boxShape:
                                                          NeumorphicBoxShape
                                                              .roundRect(
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: Text(
                                                            "Request additional amount :",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 10),
                                                          child: widget.mission[
                                                                          "expenses"]
                                                                      [
                                                                      "extraExpenses"] ==
                                                                  null
                                                              ? Text("No Amout",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black))
                                                              : Row(
                                                                  children: [
                                                                    Text(
                                                                        widget
                                                                            .mission["expenses"]["extraExpenses"][
                                                                                "\$numberDecimal"]
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black)),
                                                                    Icon(
                                                                      Icons
                                                                          .euro,
                                                                      color: LightColors
                                                                          .kDarkBlue,
                                                                    ),
                                                                  ],
                                                                ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 0),
                                                child: Container(
                                                  height: 100,
                                                  // color: Colors.grey[200],
                                                  child: Neumorphic(
                                                    style: NeumorphicStyle(
                                                      //     shape: NeumorphicShape.flat,
                                                      color: NeumorphicColors
                                                          .background,
                                                      boxShape:
                                                          NeumorphicBoxShape
                                                              .roundRect(
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: Text(
                                                            "Accomodation Comment :",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10,
                                                                  top: 10),
                                                          child: Container(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            height: 70,
                                                            child:
                                                                SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              child: Center(
                                                                child: Text(
                                                                    widget
                                                                        .mission[
                                                                            "accomodation"]
                                                                            [
                                                                            "accomodationComment"]
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 0),
                                                child: Container(
                                                  height: 50,
                                                  // color: Colors.grey[200],
                                                  child: Neumorphic(
                                                    style: NeumorphicStyle(
                                                      //     shape: NeumorphicShape.flat,
                                                      color: NeumorphicColors
                                                          .background,
                                                      boxShape:
                                                          NeumorphicBoxShape
                                                              .roundRect(
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: Text(
                                                            "rate Hotel Max :",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 10),
                                                          child: widget.mission["accomodation"][
                                                                      "cityCap"] ==
                                                                  null
                                                              ? Text("No CityCap",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black))
                                                              : Text(
                                                                  widget
                                                                      .mission["accomodation"]
                                                                          ["cityCap"][
                                                                          "Mximum_rate_per_night"]
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors.black)),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 0),
                                                child: Container(
                                                  height: 100,
                                                  // color: Colors.grey[200],
                                                  child: Neumorphic(
                                                    style: NeumorphicStyle(
                                                      //     shape: NeumorphicShape.flat,
                                                      color: NeumorphicColors
                                                          .background,
                                                      boxShape:
                                                          NeumorphicBoxShape
                                                              .roundRect(
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: Text(
                                                            "Expense Comment :",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10,
                                                                  top: 10),
                                                          child: Container(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            height: 70,
                                                            child:
                                                                SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              child: Center(
                                                                child: Text(
                                                                    widget
                                                                        .mission[
                                                                            "expenses"]
                                                                            [
                                                                            "expensesComment"]
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                          ]))),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                  padding: EdgeInsets.all(10),
                                  height: 470,
                                  child: Neumorphic(
                                      style: NeumorphicStyle(
                                        depth: 1,

                                        //shape: NeumorphicShape.convex,
                                        color: NeumorphicColors.background,
                                        boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.all(
                                                Radius.elliptical(20, 20))),
                                      ),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                "Visa & Vaccines ",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 0),
                                                child: Container(
                                                  height: 50,
                                                  // color: Colors.grey[200],
                                                  child: Neumorphic(
                                                    style: NeumorphicStyle(
                                                      //     shape: NeumorphicShape.flat,
                                                      color: NeumorphicColors
                                                          .background,
                                                      boxShape:
                                                          NeumorphicBoxShape
                                                              .roundRect(
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: Text(
                                                            "Passport validity :",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 10),
                                                          child: Text(
                                                              "Up to " +
                                                                  widget
                                                                      .mission[
                                                                          "visa"]
                                                                          [
                                                                          "validtePassport"]
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 0),
                                                child: Container(
                                                  height: 50,
                                                  // color: Colors.grey[200],
                                                  child: Neumorphic(
                                                    style: NeumorphicStyle(
                                                      //     shape: NeumorphicShape.flat,
                                                      color: NeumorphicColors
                                                          .background,
                                                      boxShape:
                                                          NeumorphicBoxShape
                                                              .roundRect(
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: Text(
                                                            "Destination visa :",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ),
                                                        widget.mission["visa"]
                                                                    ["visa"] ==
                                                                null
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            10),
                                                                child: Text(
                                                                    "null",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black)),
                                                              )
                                                            : Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            10),
                                                                child: Text(
                                                                    widget
                                                                        .mission[
                                                                            "visa"]
                                                                            [
                                                                            "visa"]
                                                                            [
                                                                            "name"]
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black)),
                                                              )
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 0),
                                                child: Container(
                                                  height: 120,
                                                  // color: Colors.grey[200],
                                                  child: Neumorphic(
                                                    style: NeumorphicStyle(
                                                      //     shape: NeumorphicShape.flat,
                                                      color: NeumorphicColors
                                                          .background,
                                                      boxShape:
                                                          NeumorphicBoxShape
                                                              .roundRect(
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10),
                                                              child: Text(
                                                                "Documents visa :",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black54),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 0,
                                                            ),
                                                            Container(
                                                              height: widget
                                                                          .mission[
                                                                              "visa"]
                                                                              [
                                                                              "visaDocuments"]
                                                                          .length *
                                                                      20.0 +
                                                                  35,
                                                              width: (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width) -
                                                                  50,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Center(
                                                                  child: ListView.builder(
                                                                      scrollDirection: Axis.vertical,
                                                                      //shrinkWrap: true,
                                                                      padding: EdgeInsets.only(top: 5.0),
                                                                      itemCount: widget.mission["visa"]["visaDocuments"].length,
                                                                      itemBuilder: (context, s) {
                                                                        return Container(
                                                                          padding:
                                                                              EdgeInsets.only(top: 5.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text(widget.mission["visa"]["visaDocuments"][s]["nbrDoc"].toString() + " " + widget.mission["visa"]["visaDocuments"][s]["name"].toString(),
                                                                                  textAlign: TextAlign.center,
                                                                                  style: TextStyle(
                                                                                    color: Colors.black,
                                                                                  )),
                                                                              widget.mission["visa"]["visaDocuments"][s]["isChecked"] == true
                                                                                  ? Icon(
                                                                                      Icons.check,
                                                                                      color: Colors.green,
                                                                                    )
                                                                                  : Icon(
                                                                                      Icons.clear_outlined,
                                                                                      color: Colors.red,
                                                                                    ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                        //Text("Rawen Mersani ",style: TextStyle(color: Colors.black)),
                                                                      }),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 0),
                                                child: Container(
                                                  height: 120,
                                                  // color: Colors.grey[200],
                                                  child: Neumorphic(
                                                    style: NeumorphicStyle(
                                                      //     shape: NeumorphicShape.flat,
                                                      color: NeumorphicColors
                                                          .background,
                                                      boxShape:
                                                          NeumorphicBoxShape
                                                              .roundRect(
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10),
                                                              child: Text(
                                                                "List vaccines :",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black54),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 0,
                                                            ),
                                                            Container(
                                                              height: widget
                                                                          .mission[
                                                                              "vaccine"]
                                                                              [
                                                                              "vaccines"]
                                                                          .length *
                                                                      20.0 +
                                                                  20,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width -
                                                                  50,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Expanded(
                                                                  child: ListView.builder(
                                                                      //    scrollDirection: Axis.vertical,
                                                                      shrinkWrap: true,
                                                                      padding: EdgeInsets.only(top: 5.0),
                                                                      itemCount: widget.mission["vaccine"]["vaccines"].length,
                                                                      itemBuilder: (context, s) {
                                                                        return Container(
                                                                          padding:
                                                                              EdgeInsets.only(top: 5.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text(widget.mission["vaccine"]["vaccines"][s]["name"].toString(),
                                                                                  textAlign: TextAlign.center,
                                                                                  style: TextStyle(
                                                                                    color: Colors.black,
                                                                                  )),
                                                                              widget.mission["vaccine"]["vaccines"][s]["isChecked"] == true
                                                                                  ? Icon(
                                                                                      Icons.check,
                                                                                      color: Colors.green,
                                                                                    )
                                                                                  : Icon(
                                                                                      Icons.clear_outlined,
                                                                                      color: Colors.red,
                                                                                    ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                        //Text("Rawen Mersani ",style: TextStyle(color: Colors.black)),
                                                                      }),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                          ]))),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                height: 350,
                                child: Neumorphic(
                                  style: NeumorphicStyle(
                                    depth: 5,
                                    shape: NeumorphicShape.flat,
                                    color: NeumorphicColors.background,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(8)),
                                  ),
                                  child: SfCalendar(
                                    view: CalendarView.workWeek,
                                    showWeekNumber: true,
                                    headerHeight: 30,

                                    minDate: new DateTime(2022, 04, 14),
                                    /*     minDate: (Operations[0]["OperationType"] ==
                                        "REMOTE_WORKING") ? new DateTime(
                                        DateTime
                                            .parse(
                                            Operations[0]["date_debut"])
                                            .year,
                                        DateTime
                                            .parse(
                                            Operations[0]["date_debut"])
                                            .month,
                                        DateTime
                                            .parse(
                                            Operations[0]["date_debut"])
                                            .day -
                                            DateTime
                                                .parse(
                                                Operations[0]["date_debut"])
                                                .weekday) : new DateTime(
                                        DateTime
                                            .parse(
                                            Operations[0]["date"])
                                            .year,
                                        DateTime
                                            .parse(
                                            Operations[0]["date"])
                                            .month,
                                        DateTime
                                            .parse(
                                            Operations[0]["date"])
                                            .day -
                                            DateTime
                                                .parse(
                                                Operations[0]["date"])
                                                .weekday),  */
                                    // minDate: Jiffy(DateTime.parse(Operations[0]["date"])).,

                                    // Jiffy(Dates[0]).week-1
                                    // onSelectionChanged: selectionChanged,
                                    // monthViewSettings: MonthViewSettings(showAgenda: true),
                                    timeSlotViewSettings: TimeSlotViewSettings(
                                        startHour: 6,
                                        endHour: 19,
                                        timeInterval: Duration(hours: 2)),
                                    controller: _controller,

                                    backgroundColor:
                                        NeumorphicColors.background,
                                    headerStyle: CalendarHeaderStyle(
                                        textAlign: TextAlign.start,
                                        textStyle: TextStyle(
                                            fontSize: 20,
                                            fontStyle: FontStyle.normal,
                                            letterSpacing: 2,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500)),
                                    dataSource: _getCalendarDataSource(),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                  padding: EdgeInsets.all(10),
                                  height: 80,
                                  child: Neumorphic(
                                      style: NeumorphicStyle(
                                        depth: 1,

                                        //shape: NeumorphicShape.convex,
                                        color: NeumorphicColors.background,
                                        boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.all(
                                                Radius.elliptical(20, 20))),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              "My Comment",
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ),
                                          ),
                                          Container(
                                              width: 130,
                                              child: Text(widget.commentUser
                                                              .toString() ==
                                                          "null" ||
                                                      widget.commentUser
                                                              .toString() ==
                                                          ""
                                                  ? "No comment"
                                                  : widget.commentUser
                                                      .toString())),
                                        ],
                                      ))),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Neumorphic(
                                    style: NeumorphicStyle(
                                      depth: 1,

                                      //shape: NeumorphicShape.convex,
                                      color: NeumorphicColors.background,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.all(
                                              Radius.elliptical(20, 20))),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            "Validator's comment",
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: commentController,
                                            minLines: 2,
                                            maxLines: 5,
                                            keyboardType:
                                                TextInputType.multiline,
                                            decoration: InputDecoration(
                                              hintText: 'Comment',
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      width: 60,
                                      height: 50,
                                      child: NeumorphicButton(
                                        //margin: EdgeInsets.fromLTRB(5,0,0,0),
                                        onPressed: () async {
                                          SweetAlert.show(context,
                                              subtitle:
                                                  "Do you want to Accepter this misssion",
                                              style: SweetAlertStyle.confirm,
                                              confirmButtonColor:
                                                  LightColors.kRed,
                                              cancelButtonColor: Colors.white12,
                                              showCancelButton: true,
                                              onPress: (bool isConfirm) {
                                            if (isConfirm) {
                                              _missionService
                                                  .stepManager(
                                                      commentController.text,
                                                      "Done",
                                                      widget.mission["_id"],
                                                      tokenLogin)
                                                  .then((value) {
                                                if (value["status"]
                                                        .toString() ==
                                                    "200") {
                                                  SweetAlert.show(context,
                                                      subtitle: "Deleting...",
                                                      style: SweetAlertStyle
                                                          .loading);
                                                  new Future.delayed(
                                                      new Duration(seconds: 2),
                                                      () {
                                                    SweetAlert.show(context,
                                                        subtitle: "Done !",
                                                        style: SweetAlertStyle
                                                            .success);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                RequestValidations()));
                                                  });
                                                } else {
                                                  SweetAlert.show(context,
                                                      subtitle:
                                                          "Ooops! Something Went Wrong!!",
                                                      style: SweetAlertStyle
                                                          .error);
                                                }
                                              });
                                            } else {
                                              print("aaaaaaaaaa : " +
                                                  Operations[0]["request"]
                                                          ["mission"]["_id"]
                                                      .toString());
                                              return true;
                                            }
                                            // return false to keep dialog
                                            return false;
                                          });
                                        },
                                        style: NeumorphicStyle(
                                          shape: NeumorphicShape.convex,
                                          color: NeumorphicColors.background,
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
                                                  BorderRadius.circular(8)),
                                        ),
                                        padding: const EdgeInsets.all(1.0),
                                        child: Center(
                                          child: Icon(Icons.check,
                                              color: Colors.green),
                                        ),

                                        // ListTile(
                                        //   leading: Icon(Icons.delete,color:LightColors.kRed) ,
                                        //   title: Text("Delete",style:TextStyle(fontSize: 18,color:LightColors.kRed,)),
                                        //
                                        //   // trailing: Text(mat.toString(),style: TextStyle(color: LightColors.kbluel,fontSize: 15),),
                                        //
                                        // ),
                                      )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                      width: 60,
                                      height: 50,
                                      child: NeumorphicButton(
                                        //margin: EdgeInsets.fromLTRB(5,0,0,0),
                                        onPressed: () async {
                                          SweetAlert.show(context,
                                              subtitle:
                                                  "Do you want to reject this misssion",
                                              style: SweetAlertStyle.confirm,
                                              confirmButtonColor:
                                                  LightColors.kRed,
                                              cancelButtonColor: Colors.white12,
                                              showCancelButton: true,
                                              onPress: (bool isConfirm) {
                                            if (isConfirm) {
                                              _missionService
                                                  .stepManager(
                                                      commentController.text,
                                                      "Rejected",
                                                      widget.mission["_id"],
                                                      tokenLogin)
                                                  .then((value) {
                                                if (value["status"]
                                                        .toString() ==
                                                    "200") {
                                                  SweetAlert.show(context,
                                                      subtitle: "Deleting...",
                                                      style: SweetAlertStyle
                                                          .loading);
                                                  new Future.delayed(
                                                      new Duration(seconds: 2),
                                                      () {
                                                    SweetAlert.show(context,
                                                        subtitle: "Done !",
                                                        style: SweetAlertStyle
                                                            .success);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                RequestValidations()));
                                                  });
                                                } else {
                                                  SweetAlert.show(context,
                                                      subtitle:
                                                          "Ooops! Something Went Wrong!!",
                                                      style: SweetAlertStyle
                                                          .error);
                                                }
                                              });
                                            } else {
                                              print("aaaaaaaaaa : " +
                                                  Operations[0]["request"]
                                                          ["mission"]["_id"]
                                                      .toString());
                                              return true;
                                            }
                                            // return false to keep dialog
                                            return false;
                                          });
                                        },
                                        style: NeumorphicStyle(
                                          shape: NeumorphicShape.convex,
                                          color: NeumorphicColors.background,
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
                                                  BorderRadius.circular(8)),
                                        ),
                                        padding: const EdgeInsets.all(1.0),
                                        child: Center(
                                          child: Icon(
                                            Icons.clear_outlined,
                                            color: Colors.red,
                                          ),
                                        ),

                                        // ListTile(
                                        //   leading: Icon(Icons.delete,color:LightColors.kRed) ,
                                        //   title: Text("Delete",style:TextStyle(fontSize: 18,color:LightColors.kRed,)),
                                        //
                                        //   // trailing: Text(mat.toString(),style: TextStyle(color: LightColors.kbluel,fontSize: 15),),
                                        //
                                        // ),
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: _height * 0.01,
                              ),
                            ],
                          ),
                        );
                    }
                    return Center(
                      child: LoadingAnimationWidget.hexagonDots(
                        color: LightColors.kDarkBlue,
                        size: 50,
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: LightColors.kDarkBlue,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => navigationScreen(
                      0, null, null, 0, null, selectedDate, "addmission")));
        },
      ),
    );
  }

  _AppointmentDataSource _getCalendarDataSource() {
    List<Appointment> appointments = <Appointment>[];
    var StartTime;
    var EndTime;
    Operations.forEach((element) async {
      if (element["OperationType"] == "WFH") {
        var Date = element["date"].toString().substring(0, 10);
        var month = DateTime.parse(Date).month;
        var day = DateTime.parse(Date).day;
        var year = DateTime.parse(Date).year;
        if (element["timeslot"] == "AM") {
          StartTime = 8;
          EndTime = 12;
        }
        if (element["timeslot"] == "PM") {
          StartTime = 14;
          EndTime = 18;
        }
        appointments.add(Appointment(
          startTime: new DateTime(year, month, day, StartTime),
          endTime: new DateTime(year, month, day, EndTime, 30),
          subject: element["OperationType"],
          color: LightColors.Telework,
          startTimeZone: '',
          endTimeZone: '',
          //  notes: 'Desk : 05.W.02.01 ',
          //  location:   "0"
        ));
      } else if (element["OperationType"].toString() == "TRAVEL") {
        var Start = element["date_debut"].toString().substring(0, 10);
        var Startmonth = DateTime.parse(Start).month;
        var Startday = DateTime.parse(Start).day;
        var Startyear = DateTime.parse(Start).year;

        var Fin = element["date_fin"].toString().substring(0, 10);
        var Finmonth = DateTime.parse(Fin).month;
        var Finday = DateTime.parse(Fin).day;
        var Finyear = DateTime.parse(Fin).year;
        appointments.add(Appointment(
            startTime: new DateTime(
              Startyear,
              Startmonth,
              Startday,
            ),
            endTime: new DateTime(
              Finyear,
              Finmonth,
              Finday,
            ),
            subject: (element["request"]["mission"]["title"] != null)
                ? element["request"]["mission"]["title"]
                : "",
            color: LightColors.LLviolet,
            startTimeZone: '',
            endTimeZone: '',
            location:
                widget.mission["transportation"]["needTransportation"] == true
                    ? (element["request"]["mission"]["transportation"]
                                    ["onewayDepartureCountry"]["name"] !=
                                null &&
                            element["request"]["mission"]["transportation"]
                                    ["onewayDestinationCountry"]["name"] !=
                                null)
                        ? element["request"]["mission"]["transportation"]
                                ["onewayDepartureCountry"]["name"] +
                            " To " +
                            element["request"]["mission"]["transportation"]
                                ["onewayDestinationCountry"]["name"]
                        : ""
                    : "Pas de Deplacemment",
            //      notes: element["idReciever"] ["firstname"] +" "+ element["idReciever"] ["lastname"],
            notes: element["_id"],
            isAllDay: true
            //  location:   "0"

            ));
      } else {
        var Datedebut = element["date_debut"].toString().substring(0, 10);
        var monthdebut = DateTime.parse(Datedebut).month;
        var daydebut = DateTime.parse(Datedebut).day;
        var yeardebut = DateTime.parse(Datedebut).year;

        var Datefin = element["date_fin"].toString().substring(0, 10);
        var monthfin = DateTime.parse(Datefin).month;
        var dayfin = DateTime.parse(Datefin).day;
        var yearfin = DateTime.parse(Datefin).year;

        appointments.add(Appointment(
            startTime: new DateTime(yeardebut, monthdebut, daydebut),
            endTime: new DateTime(yearfin, monthfin, dayfin),
            subject: element["OperationType"],
            color: LightColors.remote,
            startTimeZone: '',
            endTimeZone: '',
            isAllDay: true
            //  notes: 'Desk : 05.W.02.01 ',
            //  location:   "0"
            ));
      }
    });

    return _AppointmentDataSource(appointments);
  }
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
