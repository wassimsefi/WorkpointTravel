import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/widgets/topContainerScan.dart';

class Comensatory extends StatefulWidget {
  const Comensatory({Key key}) : super(key: key);

  @override
  _ComensatoryState createState() => _ComensatoryState();
}

class _ComensatoryState extends State<Comensatory> {
  String X;

  String StartDate;
  String EndDate;

  @override
  void initState() {
    this.X = "The full time of Casual";
    //this.adresse="adresse of your destination";

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: LightColors.kDarkBlue,
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
                      child: Text("Comensatory",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 25,
                          ))),
                  SizedBox(height: _height * 0.07),
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
                  SizedBox(
                    height: _height * 0.05,
                  ),
                  Container(
                    width: 110,
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
                        padding: const EdgeInsets.all(1.0),
                        child: Center(
                          child: AutoSizeText(
                            'Send Request',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                        )),
                  ),
                  SizedBox(
                    height: _height * 0.01,
                  ),
                  Container(
                    width: 110,
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
                        padding: const EdgeInsets.all(1.0),
                        child: Center(
                          child: AutoSizeText(
                            'Cancel',
                            style: TextStyle(
                              color: LightColors.kgreenw,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                        )),
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
