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

  @override
  void initState() {
    if (widget.mission["transportValidation"] == false) {
      listProcessing.add("Transport");
    } else {
      listValidation.add("Transport");
    }
    if (widget.mission["hotelValidation"] == false) {
      listProcessing.add("Hotel");
    } else {
      listValidation.add("Hotel");
    }
    if (widget.mission["visaValidation"] == false) {
      listProcessing.add("Visa");
    } else {
      listValidation.add("Visa");
    }
    if (widget.mission["CostsValidation"] == false) {
      listProcessing.add("Per diem");
    } else {
      listValidation.add("Per diem");
    }
    if (widget.mission["vaccineValidation"] == false) {
      listProcessing.add("Vaccine");
    } else {
      listValidation.add("Vaccine");
    }
    //listProcessing.addAll(["Transport", "Hotel", "Visa", "Per diem", "Vaccine"]);

    doodles.add(Doodle(
        name: "Draft",
        etat: "All",
        content: [],
        doodle:
            "https://www.google.com/logos/doodles/2016/abd-al-rahman-al-sufis-azophi-1113th-birthday-5115602948587520-hp2x.jpg",
        icon: Icon(Icons.lock_outline, color: Colors.white),
        iconBackground: LightColors.kDarkBlue));
    doodles.add(Doodle(
        name: "Processing ",
        etat: "In progress",
        content: listProcessing,
        doodle:
            "https://lh3.googleusercontent.com/ZTlbHDpH59p-aH2h3ggUdhByhuq1AfviGuoQpt3QqaC7bROzbKuARKeEfggkjRmAwfB1p4yKbcjPusNDNIE9O7STbc9C0SAU0hmyTjA=s660",
        icon: Icon(
          Icons.lock_clock_outlined,
          color: Colors.white,
          size: 32.0,
        ),
        iconBackground: LightColors.kDarkBlue));
    doodles.add(Doodle(
        name: "Validation",
        etat: "Done",
        content: listValidation,
        doodle:
            "https://www.google.com/logos/doodles/2015/abu-al-wafa-al-buzjanis-1075th-birthday-5436382608621568-hp2x.jpg",
        icon: Icon(
          Icons.done,
          color: Colors.white,
        ),
        iconBackground: LightColors.kDarkBlue));
    doodles.add(Doodle(
        name: "Ending",
        etat: "Ending",
        content: [],
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
              height: 120 * (doodle.content.length / 8 + 1),
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
                        return Text(doodle.content[index]);
                      },
                    )
                    /*   ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: doodle.content.length,
                      itemBuilder: (context, index) {
                        return Text(doodle.content[index]);
                      },
                    )*/
                    /*                (doodle.content.length!=0) ?
                        ListView.builder(
                        itemCount: doodle.content.length,
                        itemBuilder: (context, x) {
                   return  Text(doodle.content[x]);
                        })
                        :
                        Text("")*/
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

/*  List<Step> steps = [
    Step(
      title: Text('Step 1'),
      content: Text('Hello!'),
      isActive: true,
    ),
    Step(
      title: Text('Step 2'),
      content: Text('World!'),
      isActive: true,
    ),
    Step(
      title: Text('Step 3'),
      content: Text('Hello World!'),
      state: StepState.complete,
      isActive: true,
    ),
  ];*/

/*  @override
  Widget build(BuildContext context) {

    double _height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

   return CupertinoPageScaffold(
     backgroundColor: NeumorphicColors.background,
     navigationBar: CupertinoNavigationBar(
       backgroundColor: NeumorphicColors.background,
       middle: Text('Audit SG'),
     ),
     child: SafeArea(
       child: OrientationBuilder(
         builder: (BuildContext context, Orientation orientation) {
           switch (orientation) {
             case Orientation.portrait:
               return _buildStepper(StepperType.vertical);
             case Orientation.landscape:
               return _buildStepper(StepperType.horizontal);
             default:
               throw UnimplementedError(orientation.toString());
           }
         },
       ),
     ),
   );
  }
  CupertinoStepper _buildStepper(StepperType type) {
    final canCancel = currentStep > 0;
    final canContinue = currentStep < 3;
    return CupertinoStepper(
      type: type,
      currentStep: currentStep,
      onStepTapped: (step) => setState(() => currentStep = step),
      onStepCancel: null,
      onStepContinue:  null,
      steps: [
        for (var i = 0; i < 3; ++i)
          _buildStep(
            title: Text('Step ${i + 1}'),
            isActive: i == currentStep,
            state: i == currentStep
                ? StepState.editing
                : i < currentStep ? StepState.complete : StepState.indexed,
          ),
        _buildStep(
          title: Text('Error'),
          state: StepState.error,
        ),
        _buildStep(
          title: Text('Disabled'),
          state: StepState.disabled,
        )
      ],
    );
  }

  Step _buildStep(
      {
    Widget title,
    StepState state = StepState.indexed,
    bool isActive = false,
  }
  )*/
/*  {
    return Step(
      title: title,
      subtitle: Text('Subtitle'),
      state: state,
      isActive: isActive,
      content: Column(
        children: <Widget>[
          Text("heelooo1"),
          Text("heelooo2"),
          Text("heelooo3"),

        ],
      ),
    );
  }*/
}




/*
Widget _steps() => Container(

  color: NeumorphicColors.background,
  child: Stepper(
    steps: [
      Step(
        title: Text("First Step"),
        subtitle: Text("Done "),
          content: Text("you've completed the first step successfully"),
          isActive: true,
        state: StepState.complete
      ),
      Step(
          title: Text("Second"),
          subtitle: Text("waitting"),
          content: Text("Let's look at its construtor."),
          state: StepState.editing,
          isActive: true
     ),
      Step(
          title: Text("Third"),
          subtitle: Text("Constructor"),
          content: Text("Let's look at its construtor."),
          state: StepState.disabled),

    ],
    controlsBuilder: (BuildContext context,
        {VoidCallback onStepContinue, VoidCallback onStepCancel}) =>
        Container(),
  ),
);*/
