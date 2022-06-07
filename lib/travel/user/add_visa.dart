import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/services/MissionService.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:intl/intl.dart';
import 'dart:io';

class AddVisa extends StatefulWidget {
  List visas;
  AddVisa(this.visas, {Key key}) : super(key: key);

  @override
  State<AddVisa> createState() => _AddVisaState();
}

class _AddVisaState extends State<AddVisa> {
  MissionService _missionService = new MissionService();
  List<dynamic> visaObject;
  final List<DropdownMenuItem> listVisa = [];
  dynamic object;
  String labeDateVisa;
  String StartDate;
  String EndDate;

  File _image = File("not yet");
  File _pickedIamages = File("not yet");

  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      if (pickedFile != null) {
        print("object1111111111111111111" + pickedFile.path);

        _image = File(pickedFile.path);

        setState(() {
          _pickedIamages = File(pickedFile.path);
        });
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    this.labeDateVisa = "the expiration date of your visa";
    _missionService.getAllVisa().then((value) {
      setState(() {
        visaObject = value["data"];
      });

      print("*****" + widget.visas.toString());

      visaObject.asMap().forEach((index, element) {
        //    if (widget.visas[0]["_id"].toString() != element["_id"].toString()) {
        setState(() {
          listVisa.add(
            DropdownMenuItem(child: Text(element["name"]), value: element),
          );
        });
        //   }
      });
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicColors.background,
      appBar: AppBar(
        title: Text('Add Visa'),
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              "assets/images/vaccin.svg",
              width: 30,
              height: 30,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Container(
                    height: 105,
                    // color: Colors.grey[200],
                    child: Neumorphic(
                      style: NeumorphicStyle(
                        //     shape: NeumorphicShape.flat,
                        color: NeumorphicColors.background,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(8)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "List of visa :",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SearchChoices.single(
                              items: listVisa,
                              value: object,
                              hint: "visa",
                              searchHint: "Select your Visa to add ",
                              onChanged: (value) {
                                setState(() {
                                  object = value;
                                  print("-----------" + object.toString());
                                });
                              },
                              isExpanded: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              SizedBox(
                height: 40,
              ),
              Container(
                  // width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height ,
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
                    builder: (context) => TextButton.icon(
                          label: Text(
                            this.labeDateVisa,
                            style: TextStyle(color: Colors.black54),
                          ),
                          icon: Icon(
                            Icons.date_range,
                            color: Colors.black54,
                          ),
                          onPressed: () async {
                            final DateTime picked = await showDatePicker(
                                context: context,
                                initialDate: new DateTime.now(),
                                firstDate: DateTime(2015, 8),
                                lastDate: DateTime(2101));
                            if (picked != null && picked != StartDate) {
                              setState(() {
                                StartDate =
                                    DateFormat('yyyy-MM-dd').format(picked);
                                this.labeDateVisa = "From " + this.StartDate;
                              });
                            }
                          },
                        )),
              )),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.camera_alt_outlined,
                      // color: Colors.white,
                    )),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext bc) {
                        return Container(
                          padding: const EdgeInsets.all(0),
                          child: Wrap(
                            children: <Widget>[
                              ListTile(
                                  leading: const Icon(Icons.camera),
                                  title: const Text('Camera'),
                                  onTap: () {
                                    getImage(ImageSource.camera);
                                    Navigator.pop(context);
                                  }),
                              ListTile(
                                leading: const Icon(Icons.image),
                                title: const Text('Gallery'),
                                onTap: () {
                                  getImage(ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      });
                },
              ),
              Container(
                  height: (MediaQuery.of(context).size.height - 270) / 2,
                  padding: const EdgeInsets.all(0),
                  child: _image.path == "not yet"
                      ? Center(
                          child: const Text(
                              "cliquer sur l'icone de l'upload au dessus ."))
                      : Container(
                          color: Colors.amberAccent,
                          child: Image.file(
                            _pickedIamages,
                            fit: BoxFit.cover,
                          ),
                        )),
              SizedBox(height: 50),
              GestureDetector(
                child: Container(
                    height: 50,
                    child: NeumorphicButton(
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
                      ),
                    )),
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
