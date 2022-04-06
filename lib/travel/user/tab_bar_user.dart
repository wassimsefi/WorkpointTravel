import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/travel/user/profil%20travel.dart';
import 'package:vato/travel/user/vaccin_visa.dart';
import 'package:vato/widgets/top_container_travel.dart';

class TabBarUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return Scaffold(
      backgroundColor: LightColors.violet,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainerTravel(
              height: height/4.5,
              width: width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CircularPercentIndicator(
                            footer: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  hint:Align(alignment: Alignment.topRight,
                                      child: Icon(Icons.camera_alt_outlined,color: Colors.white,)) ,
                                  isExpanded: false,
                                  icon: Visibility (visible:false, child: Icon(Icons.arrow_downward)),

                                  onChanged: (String newValue) async {

                                  },
                                  items: <String>['From Gallery', 'From Camera', ]
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,style: TextStyle(color: LightColors.kDarkBlue),),
                                    );
                                  })
                                      .toList(),
                                )),
                            radius: height/6.5,
                            lineWidth: 1.5,
                            animation: true,
                            percent: 0.75,
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: Colors.white,
                            backgroundColor: LightColors.violet,
                            center: CircleAvatar(
                              backgroundColor: LightColors.kLavender,
                              radius: height/15,
                              backgroundImage:AssetImage("assets/images/10.jpeg"),

                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: AutoSizeText(
                                  "Firas Salem",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),maxLines: 1,
                                  maxFontSize: 25.0,
                                  minFontSize: 8,
                                ),
                              ),
                              SizedBox(height: height/70,),
                              Container(
                                margin: new EdgeInsets.only(left: 5),
                                child: AutoSizeText(
                                  "firassalemm@gmail.com",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),maxLines: 1,
                                  maxFontSize: 20.0,
                                  minFontSize: 6,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ]),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
                decoration: BoxDecoration(
                    color: NeumorphicColors.background,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                child:  DefaultTabController(
                  length: 3,
                  child: Scaffold(
                      backgroundColor: NeumorphicColors.background,
                      appBar: TabBar(
                        indicatorWeight: 2,
                        indicatorColor: LightColors.violet,
                        tabs: [
                          Tab(child: Text("Information",style: TextStyle(color: Colors.black),)),
                          Tab(child: Text("Visas & Vaccines",style: TextStyle(color: Colors.black))),
                          Tab(child: Text("Histories",style: TextStyle(color: Colors.black))),

                        ],
                      ),
                      body: TabBarView(
                        children: [
                          Profiltravel(),
                          VaccinVisa(),
                          VaccinVisa()


                        ],
                      )),
                ),
              ),
            )

          ],
        ),
      ),

    );
  }
}
