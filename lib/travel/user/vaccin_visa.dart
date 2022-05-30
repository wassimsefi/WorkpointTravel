import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jiffy/jiffy.dart';

class VaccinVisa extends StatefulWidget {
  List visas;
  List vaccines;
  VaccinVisa(this.visas, this.vaccines, {Key key}) : super(key: key);

  @override
  _VaccinVisaState createState() => _VaccinVisaState();
}

class _VaccinVisaState extends State<VaccinVisa> {
  @override
  void initState() {
    // TODO: implement initState

    print("object");
    print("object list" + widget.visas.toString());
    print("object list 2222" + widget.visas[0]["id"]["name"].toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(10),
              height: 200,
              child: Neumorphic(
                  style: NeumorphicStyle(
                    depth: 1,

                    //shape: NeumorphicShape.convex,
                    color: NeumorphicColors.background,
                    boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.all(Radius.elliptical(20, 20))),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  icon: Image.asset(
                                "assets/images/visa.png",
                                width: 30,
                                height: 30,
                              )),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Visa ",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        widget.visas.length == 0
                            ? Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: Neumorphic(
                                    style: NeumorphicStyle(
                                      //     shape: NeumorphicShape.flat,
                                      color: NeumorphicColors.background,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(8)),
                                    ),
                                    child: Center(
                                      child: Text("null",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey)),
                                    ),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.only(top: 5.0),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: widget.visas.length,
                                  itemBuilder: (context, i) {
                                    return Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 10, 0),
                                        child: Container(
                                          height: 50,
                                          // color: Colors.grey[200],
                                          child: Neumorphic(
                                            style: NeumorphicStyle(
                                              //     shape: NeumorphicShape.flat,
                                              color:
                                                  NeumorphicColors.background,
                                              boxShape:
                                                  NeumorphicBoxShape.roundRect(
                                                      BorderRadius.circular(8)),
                                            ),
                                            child: Center(
                                                child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10, left: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      widget.visas[i]["id"]
                                                              ["name"]
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black)),
                                                  Text(
                                                      Jiffy(widget.visas[i]
                                                              ["expiryDate"])
                                                          .yMMMMd
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black54)),
                                                ],
                                              ),
                                            )),
                                          ),
                                        ));
                                  },
                                ),
                              ),
                      ]))),
          SizedBox(
            height: 40,
          ),
          Container(
              padding: EdgeInsets.all(10),
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Neumorphic(
                  style: NeumorphicStyle(
                    depth: 1,

                    //shape: NeumorphicShape.convex,
                    color: NeumorphicColors.background,
                    boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.all(Radius.elliptical(20, 20))),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  icon: SvgPicture.asset(
                                "assets/images/vaccin.svg",
                                width: 30,
                                height: 30,
                              )),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Vaccine ",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        widget.vaccines.length == 0
                            ? Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: Neumorphic(
                                    style: NeumorphicStyle(
                                      //     shape: NeumorphicShape.flat,
                                      color: NeumorphicColors.background,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(8)),
                                    ),
                                    child: Center(
                                      child: Text("null",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey)),
                                    ),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: widget.vaccines.length,
                                  itemBuilder: (context, i) {
                                    return Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 10, 0),
                                        child: Container(
                                          height: 50,
                                          // color: Colors.grey[200],
                                          child: Neumorphic(
                                            style: NeumorphicStyle(
                                              //     shape: NeumorphicShape.flat,
                                              color:
                                                  NeumorphicColors.background,
                                              boxShape:
                                                  NeumorphicBoxShape.roundRect(
                                                      BorderRadius.circular(8)),
                                            ),
                                            child: Center(
                                                child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10, left: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      widget.vaccines[i]["id"]
                                                              ["name"]
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black)),
                                                  Text(
                                                      Jiffy(widget.vaccines[i]
                                                              ["expiryDate"])
                                                          .yMMMMd
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black54)),
                                                ],
                                              ),
                                            )),
                                          ),
                                        ));
                                  },
                                ),
                              ),
                      ]))),
        ],
      ),
    );
  }
}
