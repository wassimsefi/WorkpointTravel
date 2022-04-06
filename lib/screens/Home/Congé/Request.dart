import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/widgets/topContainerScan.dart';

class CongeRequest extends StatefulWidget {
  @override
  _CongeRequestState createState() => _CongeRequestState();
}

class _CongeRequestState extends State<CongeRequest> {
  String dropDownValue3;
  int _selectedIndex = 1;

  List<String> type = ["Casual", "Sick", "Comensatory"];
  String X;

  String StartDate;
  String EndDate;

  @override
  void initState() {
    this.X = "The full time of leave";
    //this.adresse="adresse of your destination";

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    TextEditingController address = TextEditingController();

    return Scaffold(
      backgroundColor: LightColors.kDarkBlue,
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TopContainer(),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
              decoration: BoxDecoration(
                  color: NeumorphicColors.background,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))),
              child: Column(
                children: [
                  Center(
                      child: Text("Leave request",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 25,
                          ))),
                  SizedBox(height: _height * 0.07),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NeumorphicToggle(
                      height: 50,
                      /* style: NeumorphicToggleStyle(
                        //backgroundColor: Colors.red,
                        border:NeumorphicBorder(width:0.6)
                      ),*/
                      selectedIndex: _selectedIndex,
                      displayForegroundOnlyIfSelected: true,
                      alphaAnimationCurve: Curves.easeInCirc,
                      children: [
/*                        ToggleElement(
                          background: Center(
                              child: Text(
                                "Casual",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )),
                          foreground: Center(
                              child: Text(
                              "Casual",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              )),
                        ),*/
                        ToggleElement(
                          background: Center(
                              child: Text(
                            "Casual",
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w400),
                          )),
                          foreground: Center(
                              child: Text(
                            "Casual",
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w800),
                          )),
                        ),
                        ToggleElement(
                          background: Center(
                              child: Text(
                            "Sick",
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w400),
                          )),
                          foreground: Center(
                              child: Text(
                            "Sick",
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w800),
                          )),
                        )
                      ],
                      thumb: Neumorphic(
                        style: NeumorphicStyle(
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.all(Radius.circular(12))),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _selectedIndex = value;
                        });
                      },
                    ),

                  ),
                  SizedBox(height: _height * 0.01),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Comments',
                      ),
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      minLines: 2,
                      maxLines:
                          5, // If set to true and wrapped in a parent widget like [Expanded] or [SizedBox], the input will expand to fill the parent.
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                      child: Theme(
                    data: Theme.of(context).copyWith(
                        accentColor: LightColors.kDarkBlue,
                        primaryColor: LightColors.kDarkBlue,
                        buttonTheme: ButtonThemeData(
                          highlightColor: LightColors.kDarkBlue,
                          colorScheme: Theme.of(context).colorScheme.copyWith(
                                secondary: LightColors.kDarkBlue,
                                primary: LightColors.kDarkBlue,
                                primaryVariant: LightColors.kDarkBlue,
                              ),
                        )),
                    child: Builder(
                        builder: (context) => Align(
                              alignment: Alignment.bottomLeft,
                              child: TextButton.icon(
                                label: Text(
                                  this.X,
                                  style: TextStyle(color: Colors.black54),
                                ),
                                icon: Icon(
                                  Icons.date_range,
                                  color: Colors.black54,
                                ),
                                onPressed: () async {
                                  final List<DateTime> picked =
                                      await DateRangePicker.showDatePicker(
                                          context: context,
                                          initialFirstDate: new DateTime.now(),
                                          initialLastDate: (new DateTime.now())
                                              .add(new Duration(days: 7)),
                                          firstDate: new DateTime(2015),
                                          lastDate: new DateTime(
                                              DateTime.now().year + 2));
                                  if (picked != null && picked.length == 2) {
                                    StartDate = DateFormat('yyyy-MM-dd')
                                        .format(picked[0]);
                                    EndDate = DateFormat('yyyy-MM-dd')
                                        .format(picked[1]);

                                    setState(() {
                                      this.X = "From " +
                                          this.StartDate +
                                          "  To " +
                                          EndDate;
                                    });
                                  }
                                },
                              ),
                            )),
                  )),
                  SizedBox(height: _height * 0.01),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(13, 8, 8, 8),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('Leave balance :  23 days',
                          style: TextStyle(
                              color: Colors
                                  .black54) // If set to true and wrapped in a parent widget like [Expanded] or [SizedBox], the input will expand to fill the parent.
                          ),
                    ),
                  ),
                  SizedBox(height: _height * 0.02),
                  _selectedIndex == 1
                      ? GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(13, 0, 0, 0),
                            child: Row(
                              children: [
                                SizedBox(height: _height * 0.01),
                                Text('Medical certificate',
                                    style: TextStyle(
                                      color: Colors.black54,
                                    )),
                                SizedBox(width: width * 0.03),
                                NeumorphicIcon(
                                  Icons.attach_file_outlined,
                                  style: NeumorphicStyle(
                                    shape: NeumorphicShape.flat,
                                    color: LightColors.kDarkBlue,
                                    shadowDarkColor: LightColors.kDarkBlue,
                                    shadowLightColorEmboss:
                                        LightColors.kDarkBlue,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(8)),
                                  ),
                                )
                              ],
                            ),
                          ))
/*                  NeumorphicButton(
                    margin: EdgeInsets.fromLTRB(80,20,80,0),
                    onPressed: () async {

                    },
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      color: NeumorphicColors.background,
                      boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                    ),
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      width: 180,
                      child: ListTile(
                        title: AutoSizeText('Medical certificate',style:TextStyle(color: LightColors.kDarkBlue,fontWeight: FontWeight.bold,),maxLines: 1,),
                        trailing: Icon(Icons.attach_file_outlined,color: LightColors.kDarkBlue,size: 20,),
                      ),
                    ),
                  )*/
                      : Container(),
                  SizedBox(
                    height: _height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        child: NeumorphicButton(
                            //  margin: EdgeInsets.fromLTRB(0,30,0,0),
                            onPressed: () async {},
                            style: NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              color: LightColors.kgreenw,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(8)),
                            ),
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                            child: Center(
                              child: AutoSizeText(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                              ),
                            )),
                      ),
                      SizedBox(
                        width: width * 0.05,
                      ),
                      Container(
                        height: 50,
                        child: NeumorphicButton(
                            //  margin: EdgeInsets.fromLTRB(0,30,0,0),
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            style: NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              color: NeumorphicColors.background,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(8)),
                            ),
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                            child: Center(
                              child: AutoSizeText(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                              ),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _height * 0.01,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
