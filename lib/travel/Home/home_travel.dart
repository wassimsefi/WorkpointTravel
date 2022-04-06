import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/travel/Home/history.dart';
import 'package:vato/travel/Home/list_missions.dart';
import 'package:vato/widgets/top_container.dart';
import 'package:vato/widgets/top_container_travel.dart';

class HomeTravel extends StatelessWidget {

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
              child:  DefaultTabController(
                length: 2,
                child: Scaffold(
                    backgroundColor: NeumorphicColors.background,
                    appBar: TabBar(
                      indicatorWeight: 2,
                      indicatorColor: LightColors.violet,
                      tabs: [
                        Tab(child: Text("Missions",style: TextStyle(color: Colors.black),)),
                        Tab(child: Text("History",style: TextStyle(color: Colors.black))),
                      ],
                    ),
                    body: TabBarView(
                      children: [
                        ListMissions(),
                        History()

                      ],
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
