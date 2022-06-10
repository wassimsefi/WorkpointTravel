import 'package:cupertino_stepper/cupertino_stepper.dart';
import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:timeline_list2/timeline.dart';
import 'package:timeline_list2/timeline_model.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/travel/detail%20mission/data.dart';
import 'package:vato/widgets/top_container_travel.dart';

class Stepperpage extends StatefulWidget {
  dynamic mission;

  Stepperpage(this.mission, {Key key}) : super(key: key);

  @override
  _StepperpageState createState() => _StepperpageState();
}

class _StepperpageState extends State<Stepperpage> {
  List<Doodle> doodles = [];
  final List<String> listProcessing = [];
  final List<String> listValidation = [];
  final List<String> listProcessingEtat = [];
  final List<String> listValidationEtat = [];

  @override
  void initState() {
    listProcessing.add("Transport");
    listProcessing.add("Hotel");
    listProcessing.add("Visa");
    listProcessing.add("Per diem");
    listProcessing.add("Vaccine");

    listProcessingEtat.add(widget.mission["transportation"]["status"]);
    listProcessingEtat.add(widget.mission["accomodation"]["status"]);
    listProcessingEtat.add(widget.mission["visa"]["status"]);
    listProcessingEtat.add(widget.mission["expenses"]["status"]);
    listProcessingEtat.add(widget.mission["vaccine"]["status"]);

    listValidation.add("Partener");
    listValidation.add("Manager");
    listValidation.add("Facilite");
    listValidation.add("DG");

    listValidationEtat.add(widget.mission["stepPartener"]["status"]);
    listValidationEtat.add(widget.mission["stepManager"]["status"]);
    listValidationEtat.add(widget.mission["stepFacilite"]["status"]);
    listValidationEtat.add(widget.mission["stepDG"]["status"]);

    doodles.add(Doodle(
        name: "Draft",
        etat: "All",
        content: [],
        Etatcontent: [],
        doodle:
            "https://www.google.com/logos/doodles/2016/abd-al-rahman-al-sufis-azophi-1113th-birthday-5115602948587520-hp2x.jpg",
        icon: Icon(Icons.lock_outline, color: Colors.white),
        iconBackground: LightColors.kDarkBlue));

    doodles.add(Doodle(
        name: "Validation",
        etat: "Done",
        content: listValidation,
        Etatcontent: listValidationEtat,
        doodle:
            "https://www.google.com/logos/doodles/2015/abu-al-wafa-al-buzjanis-1075th-birthday-5436382608621568-hp2x.jpg",
        icon: Icon(
          Icons.done,
          color: Colors.white,
        ),
        iconBackground: LightColors.kDarkBlue));
    doodles.add(Doodle(
        name: "Processing",
        etat: "In progress",
        content: listProcessing,
        Etatcontent: listProcessingEtat,
        doodle:
            "https://lh3.googleusercontent.com/ZTlbHDpH59p-aH2h3ggUdhByhuq1AfviGuoQpt3QqaC7bROzbKuARKeEfggkjRmAwfB1p4yKbcjPusNDNIE9O7STbc9C0SAU0hmyTjA=s660",
        icon: Icon(
          Icons.lock_clock_outlined,
          color: Colors.white,
          size: 32.0,
        ),
        iconBackground: LightColors.kDarkBlue));
    doodles.add(Doodle(
        name: "Ending",
        etat: "Ending",
        content: [],
        Etatcontent: [],
        doodle:
            "https://lh3.googleusercontent.com/bFwiXFZEum_vVibMzkgPlaKZMDc66W-S_cz1aPKbU0wyNzL_ucN_kXzjOlygywvf6Bcn3ipSLTsszGieEZTLKn9NHXnw8VJs4-xU6Br9cg=s660",
        icon: Icon(
          Icons.radio_button_unchecked,
          color: Colors.white,
          size: 15,
        ),
        iconBackground: Colors.grey));

    super.initState();
  }

  int current_step = 0;
  int currentStep = 0;

  var drawerKey = GlobalKey<SwipeDrawerState>();
  final PageController pageController =
      PageController(initialPage: 1, keepPage: true);
  int pageIx = 1;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      timelineModel(TimelinePosition.Left),
      timelineModel(TimelinePosition.Center),
      timelineModel(TimelinePosition.Right)
    ];

    return Scaffold(
        backgroundColor: NeumorphicColors.background,
/*
        appBar: AppBar(
          title: Text("widget.title"),
        ),*/
        body: timelineModel(TimelinePosition.Left));
  }

  timelineModel(TimelinePosition position) => Timeline.builder(
      itemBuilder: centerTimelineBuilder,
      itemCount: doodles.length,
      physics: position == TimelinePosition.Left
          ? ClampingScrollPhysics()
          : BouncingScrollPhysics(),
      position: position);

  TimelineModel centerTimelineBuilder(BuildContext context, int i) {
    double _height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final doodle = doodles[i];
    final textTheme = Theme.of(context).textTheme;
    return TimelineModel(
        GestureDetector(
          onTap: () => print("name : " + doodle.name),
          child: Card(
            color: NeumorphicColors.background,
            margin: EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            clipBehavior: Clip.antiAlias,
            child: Container(
              width: width * 0.8,
              height: 120 * (doodle.content.length / 8 + 1) + 25,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Image.network(doodle.doodle),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Center(
                      child: Text(
                        doodle.name,
                        style: textTheme.title,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Center(child: Text(doodle.etat, style: textTheme.caption)),

                    const SizedBox(
                      height: 8.0,
                    ),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: doodle.content.length,
                      itemBuilder: (context, index) {
                        return doodle.name == "Validation"
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(doodle.content[index].toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                      )),
                                  doodle.Etatcontent[index] == "Done"
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        )
                                      : Icon(
                                          Icons.clear_outlined,
                                          color: Colors.red,
                                        ),
                                ],
                              )
                            : doodle.name == "Processing"
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(doodle.content[index].toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                          )),
                                      doodle.Etatcontent[index] == "Done"
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            )
                                          : doodle.Etatcontent[index] ==
                                                  "Processing"
                                              ? Icon(
                                                  Icons.pending_outlined,
                                                  color: Colors.orange,
                                                )
                                              : Icon(
                                                  Icons.clear_outlined,
                                                  color: Colors.red,
                                                ),
                                    ],
                                  )
                                : Text(doodle.content[index],
                                    //   textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ));
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        // leading: Text("gggg"),
        isFirst: i == 0,
        isLast: i == doodles.length,
        iconBackground: doodle.iconBackground,
        icon: doodle.icon);
  }
}
