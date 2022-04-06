import 'package:auto_size_text/auto_size_text.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:progress_timeline/progress_timeline.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:intl/intl.dart';
import 'package:vato/travel/simple_map.dart';

import 'package:vato/widgets/top_container_travel.dart';
class AddMissions extends StatefulWidget {
  AddMissions({Key key}) : super(key: key);

  @override
  _AddMissionsState createState() => _AddMissionsState();
}

class _AddMissionsState extends State<AddMissions> {
  String X;
  String adresse;


  String StartDate;
  String EndDate;

  int _activeStepIndex = 0;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();

  bool isChecked = false;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return LightColors.Lviolet;
  }
  String dropDownValue;
  String dropDownValue2;
  String dropDownValue3;
  @override
  void initState() {
    this.X="the full time of your mission";
    this.adresse="adresse of your destination";


    // TODO: implement initState
    super.initState();
  }

  List<String> Categorie = [
    "Audit", "Consulting"
  ];
  List<String> type = [
    "Local", "International"
  ];
  List<String> formula = [
    "Transportation" , "accomodation", "Training"
  ];
  List<Step> stepList() => [
    Step(
      state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
      isActive: _activeStepIndex >= 0,
      title: const Text('Informations',style: TextStyle(fontSize: 12),),
      content: Container(
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
            ),
            const SizedBox(
              height: 8,
            ),

            DropdownButtonFormField(
              decoration: InputDecoration(
                border:  OutlineInputBorder(),
                //   filled: true,
                // hintStyle: TextStyle(color: Colors.grey[800]),
                hintText: "Category ",
                // fillColor: Colors.blue[200]
              ),
              value: dropDownValue,
              onChanged: (String Value) {
                setState(() {
                  dropDownValue = Value;
                });
              },
              items: Categorie
                  .map((cityTitle) => DropdownMenuItem(
                  value: cityTitle, child:  Text("$cityTitle")))
                  .toList(),
            ),

            const SizedBox(
              height: 8,
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(
                border:  OutlineInputBorder(),
                //   filled: true,
                // hintStyle: TextStyle(color: Colors.grey[800]),
                hintText: "Type ",
                // fillColor: Colors.blue[200]
              ),
              value: dropDownValue2,
              onChanged: (String Value) {
                setState(() {
                  dropDownValue2 = Value;
                });
              },
              items: type
                  .map((cityTitle) => DropdownMenuItem(
                  value: cityTitle, child:  Text("$cityTitle")))
                  .toList(),
            ),

            const SizedBox(
              height: 8,
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(
                border:  OutlineInputBorder(),
                //   filled: true,
                // hintStyle: TextStyle(color: Colors.grey[800]),
                hintText: "Formula",
                // fillColor: Colors.blue[200]
              ),
              value: dropDownValue3,
              onChanged: (String Value) {
                setState(() {
                  dropDownValue3 = Value;
                });
              },
              items: formula
                  .map((cityTitle) => DropdownMenuItem(
                  value: cityTitle, child:  Text("$cityTitle")))
                  .toList(),
            ),

            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: email,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("Need Transport",style: TextStyle(fontSize: 18,color: Colors.black87),),
                ),
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: isChecked,
                  onChanged: (bool value) {
                    setState(() {
                      isChecked = value;
                    });
                    print(isChecked.toString());
                  },
                ),
              ],
            )
          ],
        ),
      ),
    ),
    Step(
        state:
        _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 1,
        title: const Text('Engagement',style: TextStyle(fontSize: 12)),
        content: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              DropdownSearch<String>(
                  mode: Mode.MENU,
                  label: "Manager",
                 // hint: "country in menu mode",
                  popupItemDisabled: (String s) => s.startsWith('I'),
                  onChanged: print,
                  selectedItem: "Engagement Manager"),

              const SizedBox(
                height: 8,
              ),
              DropdownSearch<String>(
                  mode: Mode.MENU,
                  label: "Partner",
                 // hint: "country in menu mode",
                  popupItemDisabled: (String s) => s.startsWith('I'),
                  onChanged: print,
                  selectedItem: "Engagement Partner"),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: address,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Engagement Code',
                ),
              )
            ],
          ),
        )),
    Step(
        state:
        _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 1,
        title: const Text('Location',style: TextStyle(fontSize: 12)),
        content: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              isChecked?
              TextField(
                controller: address,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contry',
                ),
              ):Container(),
              isChecked?

              const SizedBox(
                height: 8,
              ):Container(),
              isChecked?
              TextField(
                controller: address,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'City',
                ),
              ):Container(),


              const SizedBox(
                height: 8,
              ),
              Container(
                  child:Theme(
                    data: Theme.of(context).copyWith(
                        accentColor: Colors.deepPurpleAccent,
                        primaryColor: Colors.deepPurple,
                        buttonTheme: ButtonThemeData(
                          highlightColor: Colors.deepPurple,

                          colorScheme: Theme.of(context).colorScheme.copyWith(
                            secondary: Colors.purple,
                            primary: Colors.deepPurple,
                            primaryVariant: Colors.deepPurpleAccent,

                          ),
                        )),

                    child: Builder(
                        builder: (context) =>  TextButton.icon(
                          label: Text(this.X,style: TextStyle(color: Colors.black54),),
                          icon: Icon(Icons.date_range,color: Colors.black54,),
                          onPressed: () async {
                            final List<DateTime> picked = await DateRangePicker.showDatePicker(
                                context: context,
                                initialFirstDate: new DateTime.now(),
                                initialLastDate: (new DateTime.now()).add(new Duration(days: 7)),
                                firstDate: new DateTime(2015),
                                lastDate: new DateTime(DateTime.now().year + 2));
                            if (picked != null && picked.length == 2) {
                              print(picked.toList());
                              StartDate=DateFormat('yyyy-MM-dd').format(picked[0]);
                              EndDate=DateFormat('yyyy-MM-dd').format(picked[1]);

                              setState(() {
                                this.X="From "+this.StartDate+ "  To "+EndDate;
                              });
                            }

                          },
                        )
                    ),
                  )),
              const SizedBox(
                height: 8,
              ),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Commments',
                ),
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                minLines: 2,
                maxLines: 5, // If set to true and wrapped in a parent widget like [Expanded] or [SizedBox], the input will expand to fill the parent.
              )
            ],
          ),
        )),

/*
    Step(
        state: StepState.complete,
        isActive: _activeStepIndex >= 2,
        title: const Text('Confirm'),
        content: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Name: ${name.text}'),
                Text('Email: ${email.text}'),
                const Text('Password: *****'),
                Text('Address : ${address.text}'),
                Text('PinCode : ${pincode.text}'),
              ],
            )))
*/
  ];

    @override
    Widget build(BuildContext context) {
      double _height = MediaQuery.of(context).size.height;
      double width = MediaQuery.of(context).size.width;
      return Scaffold(
        backgroundColor: LightColors.violet,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TopContainerTravel(
              height: _height/5.5,
              width: width,
              child:Padding(
                padding: const EdgeInsets.only(top:20.0),
                child: Row(

                  children: [
                    Expanded(
                      flex:2,
                      child: Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: _height*0.035,
                              ),
                              Container(
                                width: width/2.5,
                                height: _height/20,
                                child: Image(
                                  image: AssetImage("assets/images/top.png"),
                                ),
                              ),
                              SizedBox(
                                height: _height*0.01,

                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  width: width/3,
                                  height: _height/25,
                                  child: Image(
                                    image: AssetImage("assets/images/travelblanc.png"),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: _height*0.005,

                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: PopupMenuButton<int>(
                          icon: Icon(Icons.adaptive.more,color: Colors.white,),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 1,
                              child: Text("Workpoint"),
                            ),
                            PopupMenuItem(
                              value: 2,
                              child: Text("Notification"),
                            ),
                            PopupMenuItem(
                              value: 1,
                              child: Text("Déconnexion"),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
                decoration: BoxDecoration(
                    color: NeumorphicColors.background,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                child: Container(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      //Center(child: Text("Applied policies",style: TextStyle(color:Colors.black87,fontSize: 28,fontWeight: FontWeight.bold),)),
                      Center(child: Text("Add Mission",style: TextStyle(color:Colors.black54,fontSize: 25,))),
                      SizedBox(height: _height/20),

                    Expanded(
                      child:Container(
                       // color: Colors.red,
                        child: Theme(
                          data: ThemeData(canvasColor: NeumorphicColors.background),
                        child: Stepper(

                          type: StepperType.horizontal,
                          currentStep: _activeStepIndex,
                          steps: stepList(),
                          onStepContinue: () {
                            if (_activeStepIndex < (stepList().length - 1)) {
                              setState(() {
                                _activeStepIndex += 1;
                              });
                            } else {
                              print('Submited');
                            }
                          },
                          onStepCancel: () {
                            if (_activeStepIndex == 0) {
                              return;
                            }
                            setState(() {
                              _activeStepIndex -= 1;
                            });
                          },
                          onStepTapped: (int index) {
                            setState(() {
                              _activeStepIndex = index;
                            });
                          },
                          controlsBuilder: (context, {onStepContinue, onStepCancel}) {
                            final isLastStep = _activeStepIndex == stepList().length - 1;
                            return Container(
                           //   color: Colors.purpleAccent,
                              child: Row(
                                children: [


                                  if (_activeStepIndex > 0)
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: LightColors.Lviolet
                                        ),
                                        onPressed: onStepCancel,
                                        child: const Text('Back'),
                                      ),
                                    ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: LightColors.Lviolet
                                      ),
                                      onPressed: onStepContinue,
                                      child: (isLastStep)
                                          ? const Text('Submit')
                                          : const Text('Next'),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        )
                      ),
                    )

                    ],
                  ),
                ),
              ),
            )
          ],
        ),

        // This trailing comma makes auto-formatting nicer for build methods.
      );
    }



  }



