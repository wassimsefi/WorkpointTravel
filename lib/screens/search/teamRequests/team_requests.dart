import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/screens/search/teamRequests/detail_team_request.dart';
import 'package:vato/services/RequestService.dart';
import 'package:vato/widgets/topContainerScan.dart';

class TeamRequests extends StatefulWidget {
  const TeamRequests({Key key}) : super(key: key);

  @override
  _TeamRequestsState createState() => _TeamRequestsState();
}

class _TeamRequestsState extends State<TeamRequests> {
  Future<SharedPreferences> _prefs;
  String tokenLogin;
  String idUser;
  RequestService _requestService = new RequestService();
  List<dynamic> Requests = [];
  List<dynamic> filtred = [];
  List<dynamic> managers = [];

  final List<DropdownMenuItem> notifier = [];
  List<int> selectedItemsMultiDialog = [];
  Future<dynamic> getteamRequets;

  int NBRequests;
  Future<dynamic> getRequestByManager;

  @override
  void initState() {
    _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      setState(() {
        this.idUser = prefs.get("_id").toString();
        this.tokenLogin = prefs.get("token").toString();
        getteamRequets = _requestService
            .getRequestByManager(idUser, tokenLogin)
            .then((value) {
          filtred = Requests = value["data"];
          setState(() {
            filtred.sort((a, b) => b["updatedAt"].compareTo(a["updatedAt"]));
          });

          if (value["data"] != null) {
            NBRequests = value["data"].length;
          }
          Requests.forEach((element) {

            managers.add({
              "name": element["idSender"]["firstname"] +
                  " " +
                  element["idSender"]["lastname"],
              "value": element["idSender"]["_id"]
            });

            if (managers.contains(managers[0])) {
            } else {
              setState(() {
                managers.add({
                  "name": element["idSender"]["firstname"] +
                      " " +
                      element["idSender"]["lastname"],
                  "value": element["idSender"]["_id"]
                });
              });
            }
          });

          managers.forEach((element) {
            setState(() {
              notifier.add(
                DropdownMenuItem(
                    child: Text(element["name"]), value: element["value"]),
              );
            });
          });
        });
      });
    });
    super.initState();
  }

  void _filterResources(value) {
    setState(() {
      filtred = Requests.where((element) =>
          element["idSender"]["lastname"]
              .toLowerCase()
              .contains(value.toString().toLowerCase()) ||
          element["idSender"]["firstname"]
              .toLowerCase()
              .contains(value.toString().toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: LightColors.kDarkBlue,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TopContainer(),

/*          (role=="manager")? TeamRequest()
              :*/
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
              decoration: BoxDecoration(
                  color: NeumorphicColors.background,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                      child: Text("My Pending requests",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 25,
                          ))),
                  Container(
                    color: NeumorphicColors.background,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Neumorphic(
                        style: NeumorphicStyle(
                          depth: 3,

                          //shape: NeumorphicShape.convex,
                          color: NeumorphicColors.background,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.all(Radius.elliptical(20, 20))),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            fillColor: NeumorphicColors.background,

                            //   hoverColor: Colors.red,
                            /*      border: new OutlineInputBorder(
                                 // borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
                                 // borderSide: new BorderSide(color: Colors.red,width: 20 ,style: BorderStyle.none)
                              ),*/
                            //isCollapsed: true,
                            // focusColor: Colors.red,
                            //  filled: true,

                            prefixIcon: const Icon(
                              Icons.search,
                              color: LightColors.kDarkBlue,
                            ),
                            // suffix:  const Icon(Icons.close, color: Colors.black,),

                            //icon: Icon(Icons.search,color: LightColors.kDarkBlue,)
                          ),
                          onChanged: (value) {
                            _filterResources(
                              value,
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  /*  SearchChoices.multiple(
                        items: notifier,
                        selectedItems: selectedItemsMultiDialog,
                        hint: "Employees",
                        searchHint:
                        "Select employees to notify",

                        onChanged: (value) {
                          setState(() {
                            selectedItemsMultiDialog = value;
                          });
                        },
                        closeButton: (selectedItems) {
                          return filterList(
                              selectedItemsMultiDialog);
                        },
                        //isExpanded: true,
                      ),*/
                  Expanded(
                      child: FutureBuilder(
                          future: getteamRequets,
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return Center(
                                    child: CircularProgressIndicator());
                              case ConnectionState.waiting:
                                return Center(
                                    child: CircularProgressIndicator());
                              case ConnectionState.done:
                                return (NBRequests == 0)
                                    ? Center(
                                        child: Text("No Requests"),
                                      )
                                    : ListView.builder(
                                        padding: EdgeInsets.all(1),
                                        itemCount: filtred.length,
                                        itemBuilder: (context, x) {
                                          return Padding(
                                            padding: EdgeInsets.only(bottom: 1),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => DetailTeamRequest(
                                                            Requests[x]["_id"],
                                                            Requests[x]["idSender"]["firstname"] +
                                                                " " +
                                                                Requests[x]["idSender"][
                                                                    "lastname"],
                                                            new DateFormat('yyyy-MM-dd HH:mm')
                                                                .format(DateTime.tryParse(
                                                                    Requests[x][
                                                                        "createdAt"]))
                                                                .toString(),
                                                            Requests[x]
                                                                ["UserNotif"],
                                                            Requests[x]["status"]
                                                                .toString(),
                                                            Requests[x]["idSender"]
                                                                ["photo"],
                                                            Requests[x]
                                                                ["commentUser"])));
                                              },
                                              child: Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      10, 25, 10, 10),
                                                  height: 100,
                                                  width: width,
                                                  child: Neumorphic(
                                                    style: NeumorphicStyle(
                                                      color: NeumorphicColors
                                                          .background,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          flex: 3,
                                                          child: Neumorphic(
                                                              style:
                                                                  NeumorphicStyle(
                                                                shape:
                                                                    NeumorphicShape
                                                                        .flat,
                                                                depth: 20,
                                                              ),
                                                              child: Container(
                                                                width: 80,
                                                                height: 80,
                                                                child: Center(
                                                                  child: filtred[x]["name"]
                                                                              .toString() ==
                                                                          "WFH"
                                                                      ? FittedBox(
                                                                          fit: BoxFit
                                                                              .fitWidth,
                                                                          child:
                                                                              Icon(
                                                                            Icons.home_work_outlined,
                                                                            color:
                                                                                LightColors.Telework,
                                                                            size:
                                                                                30,
                                                                          ),
                                                                        )
                                                                      : FittedBox(
                                                                          fit: BoxFit
                                                                              .fitWidth,
                                                                          child:
                                                                              Icon(
                                                                            Icons.home_work_outlined,
                                                                            color:
                                                                                LightColors.Telework,
                                                                            size:
                                                                                30,
                                                                          ),
                                                                        ),
                                                                ),
                                                              )),
                                                        ),
                                                        Expanded(
                                                          flex: 7,
                                                          child: Container(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            20.0),
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          AutoSizeText(
                                                                        filtred[x]
                                                                            [
                                                                            "name"],
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black54,
                                                                            fontWeight: FontWeight.bold),
                                                                        maxLines:
                                                                            1,
                                                                      ),
                                                                    )),
                                                                Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            20.0),
                                                                    child:
                                                                    Container(
                                                                      child:
                                                                          AutoSizeText(
                                                                        filtred[x]["idSender"]["firstname"] +
                                                                            " " +
                                                                            filtred[x]["idSender"]["lastname"],
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black54,
                                                                            fontWeight: FontWeight.w600),
                                                                        maxLines:
                                                                            1,
                                                                      ),
                                                                    )),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          20.0),
                                                                  child: Text(
                                                                      new DateFormat(
                                                                              'yyyy-MM-dd HH:mm')
                                                                          .format(DateTime.tryParse(filtred[x]
                                                                              [
                                                                              "createdAt"]))
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black54)),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Expanded(
                                                          flex: 4,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SizedBox(
                                                                height: 30,
                                                              ),
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  SizedBox(
                                                                    height:
                                                                        _height /
                                                                            50,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                        width: width *
                                                                            0.09,
                                                                        height: width *
                                                                            0.09,
                                                                        child: NeumorphicButton(
                                                                            //margin: EdgeInsets.fromLTRB(5,0,0,0),
                                                                            onPressed: () async {
                                                                              _requestService.ValidateRequet(filtred[x]["_id"], "refused", "", tokenLogin).then((value) async {
                                                                                SweetAlert.show(context, subtitle: "Loading ...", style: SweetAlertStyle.loading);
                                                                                setState(() {});
                                                                                await Future.delayed(new Duration(seconds: 1), () async {

                                                                                  if (value["message"] == "Succesfully updated") {
                                                                                    await SweetAlert.show(context, subtitle: " Done !", style: SweetAlertStyle.success);
                                                                                    setState(() {
                                                                                      filtred.removeAt(x);
                                                                                    });
                                                                                  } else {
                                                                                    await SweetAlert.show(context, subtitle: "Ooops! Something Went Wrong!", style: SweetAlertStyle.error);
                                                                                  }
                                                                                });
                                                                              });
                                                                            },
                                                                            style: NeumorphicStyle(
                                                                              shape: NeumorphicShape.flat,
                                                                              color: NeumorphicColors.background,
                                                                              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                                                                            ),
                                                                            padding: const EdgeInsets.all(1.0),
                                                                            child: Center(
                                                                              child: Icon(
                                                                                Icons.close,
                                                                                size: 22,
                                                                                color: LightColors.kRed,
                                                                              ),
                                                                            )),
                                                                      ),
                                                                      SizedBox(
                                                                        width: width *
                                                                            0.02,
                                                                      ),
                                                                      Container(
                                                                        width: width *
                                                                            0.09,
                                                                        height: width *
                                                                            0.09,
                                                                        child: NeumorphicButton(
                                                                            // margin: EdgeInsets.fromLTRB(5,0,0,0),
                                                                            onPressed: () async {
                                                                              _requestService.ValidateRequet(filtred[x]["_id"], "accepted", "", tokenLogin).then((value) async {
                                                                                SweetAlert.show(context, subtitle: "Loading ...", style: SweetAlertStyle.loading);

                                                                                await Future.delayed(new Duration(seconds: 1), () async {

                                                                                  if (value["message"] == "Succesfully updated") {
                                                                                    await SweetAlert.show(context, subtitle: " Done !", style: SweetAlertStyle.success);
                                                                                    setState(() {
                                                                                      filtred.removeAt(x);
                                                                                    });
                                                                                  } else {
                                                                                    await SweetAlert.show(context, subtitle: "Ooops! Something Went Wrong!", style: SweetAlertStyle.error);
                                                                                  }
                                                                                });
                                                                              });
                                                                            },
                                                                            style: NeumorphicStyle(
                                                                              shape: NeumorphicShape.flat,
                                                                              color: NeumorphicColors.background,
                                                                              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                                                                            ),
                                                                            padding: const EdgeInsets.all(1.0),
                                                                            child: Center(
                                                                              child: Icon(
                                                                                Icons.done,
                                                                                size: 22,
                                                                                color: LightColors.kgreenD,
                                                                              ),
                                                                            )),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              Spacer()
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                          );
                                        });
                            }
                            return CircularProgressIndicator();
                          })),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

/*  void filterList(selectedItemsMultiDialog) {

*//*    setState(() {
      filtred=Requests.where((element) => element["idSender"]["firstname"] +" " + element["idSender"]["lastname"].toLowerCase().contains(selectedItems)).toList();
    });*//*
  }*/
}
