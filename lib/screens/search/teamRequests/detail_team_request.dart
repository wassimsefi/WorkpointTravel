import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:vato/constants/light_colors.dart';
import 'package:vato/constants/link.dart';
import 'package:vato/screens/search/teamRequests/team_requests.dart';
import 'package:vato/services/OperationsService.dart';
import 'package:vato/services/RequestService.dart';
import 'package:vato/widgets/topContainerBack.dart';

class DetailTeamRequest extends StatefulWidget {
  String Request_id;
  String manager;
  String Date ;
  List UserTonotif;
  String StatusRequest;
  String image;
  String commentUser;
  DetailTeamRequest(this.Request_id,this.manager,this.Date,this.UserTonotif,this.StatusRequest,this.image,this.commentUser,{Key key}) : super(key: key);


  @override
  _DetailTeamRequestState createState() => _DetailTeamRequestState();
}

class _DetailTeamRequestState extends State<DetailTeamRequest>{
  Future<SharedPreferences> _prefs;
  String tokenLogin;
  String idUser;
  OperationService _operationService = new OperationService();
  RequestService _requestService = new RequestService();

  List<dynamic> Operations = [];
  TextEditingController commentManagerController = new TextEditingController();
Future <dynamic>  getOperationsbyRequest;
var image;
  ImageProvider decideImage()
  {
    {if(widget.image==null)
    {return AssetImage("assets/images/user3.png");}
    else{
      return NetworkImage(link.linkw+"/uploads/"+widget.image);
    }
    }

  }
  @override
  void initState() {
    _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      setState(() {

        this.idUser= prefs.get("_id").toString();
        this.tokenLogin=prefs.get("token").toString();
        getOperationsbyRequest =_operationService.getOperationsbyRequest(widget.Request_id, tokenLogin).then((value) {
          setState(() {
            Operations = value["data"];
            Operations.sort((a,b) => b["updatedAt"].compareTo(a["updatedAt"]));
          });


        });
      });});
    image = decideImage();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    CalendarController _controller = CalendarController();

    return Scaffold(
      backgroundColor: LightColors.kDarkBlue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TopContainerBack(),
          Expanded(
            child:Container(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
              decoration: BoxDecoration(
                  color: NeumorphicColors.background,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))),
              child:FutureBuilder(
                  future: getOperationsbyRequest,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Center(child: CircularProgressIndicator());
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      case ConnectionState.done:
                        return (Operations.length != 0)
                            ? SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            //SizedBox(width: 10,),
                                            Neumorphic(
                                        style: NeumorphicStyle(
                                          depth: 3,

                                          //shape: NeumorphicShape.convex,
                                          color: NeumorphicColors.background,
                                          boxShape:
                                          NeumorphicBoxShape.circle(),
                                        ),
                                        child: Container(
                                            width:70,
                                            height:100,child:Image(
                                          image: image,
                                        ))),
                                    Text(widget.manager),

                                    //     Spacer(),

                                  ],
                                ),
                                Spacer(),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,

                                    children: <Widget>[
                                      SizedBox(height: 70,),
                                      //   Spacer(),
                                      //  SizedBox(width: 10,),
                                      ( widget.StatusRequest=="pending")?
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(30, 0, 40, 10),
                                        child: Text(widget.StatusRequest,style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.w600,fontSize: 17),textAlign: TextAlign.center,),
                                      ):
                                      ( widget.StatusRequest=="accepted")? Padding(
                                        padding: const EdgeInsets.fromLTRB(30, 10, 10, 10),
                                        child: Text(widget.StatusRequest,style: TextStyle(color: Colors.green,fontWeight: FontWeight.w600),),
                                      ):
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(30, 10, 10, 10),
                                        child: Text(widget.StatusRequest,style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600),),
                                      ),
                                      // Spacer(),
                                      // SizedBox(height: 5,),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(" At  "+widget.Date,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 13 )),
                                      ),
                                    ]
                                ),],),
                              SizedBox(height: 10,),


                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[

                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: Card(
                                          color: NeumorphicColors.background,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10),
                                                child: Text("List of people to notify ",style: TextStyle(color: Colors.black54),),
                                              ),
                                              Container(
                                                height: widget.UserTonotif.length*10.0+30,
                                                width: 100,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: ListView.builder(
                                                      scrollDirection: Axis.vertical,
                                                      //shrinkWrap: true,
                                                      padding: EdgeInsets.all(2.0),

                                                      itemCount: widget.UserTonotif.length,
                                                      itemBuilder: (context, s) {
                                                        return  Container(

                                                          child: Text(widget
                                                              .UserTonotif[s]["firstname"] +
                                                              " " + widget
                                                              .UserTonotif[s]["lastname"],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                        );
                                                        //Text("Rawen Mersani ",style: TextStyle(color: Colors.black)),
                                                      }),
                                                ),
                                              ),



                                            ],
                                          ),
                                        )

                                    ),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                        child: Card(
                                          //  height: 30,
                                          color: NeumorphicColors.background,
                                          child: Container(
                                            height: 40,

                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10),
                                                  child: Text("Number of requested days",style: TextStyle(color: Colors.black54),),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(
                                                      right: 10),
                                                  child: (Operations[0]["OperationType"] ==
                                                      "REMOTE_WORKING")
                                                      ? Text(
                                                      DateTime.parse(Operations[0]["date_fin"])
                                                          .difference(DateTime.parse(Operations[0][
                                                      "date_debut"]))
                                                          .inDays
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black))
                                                      : Text(((Operations.length) / 2).toString(),
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black)),
                                                )



                                              ],
                                            ),
                                          ),
                                        )

                                    ),

                                  ]
                              ),
                              SizedBox(height: 5,),
                              Card(
                                child: Container(
                                  height: 350,
                                  child: SfCalendar(
                                    view: CalendarView.workWeek,
                                    showWeekNumber: true,
                                    headerHeight: 30,

                                    minDate:(Operations[0]["OperationType"]=="REMOTE_WORKING")? new DateTime(
                                        DateTime.parse(
                                            Operations[0]["date_debut"])
                                            .year,
                                        DateTime.parse(
                                            Operations[0]["date_debut"])
                                            .month,
                                        DateTime.parse(
                                            Operations[0]["date_debut"])
                                            .day -
                                            DateTime.parse(
                                                Operations[0]["date_debut"])
                                                .weekday):new DateTime(
                                        DateTime.parse(
                                            Operations[0]["date"])
                                            .year,
                                        DateTime.parse(
                                            Operations[0]["date"])
                                            .month,
                                        DateTime.parse(
                                            Operations[0]["date"])
                                            .day -
                                            DateTime.parse(
                                                Operations[0]["date"])
                                                .weekday),                                    // minDate: Jiffy(DateTime.parse(Operations[0]["date"])).,

                                    // Jiffy(Dates[0]).week-1
                                    // onSelectionChanged: selectionChanged,
                                    // monthViewSettings: MonthViewSettings(showAgenda: true),
                                    timeSlotViewSettings:
                                    TimeSlotViewSettings(
                                        startHour: 6,
                                        endHour: 19,
                                        timeInterval: Duration(hours: 2)),
                                    controller: _controller,

                                    backgroundColor: NeumorphicColors.background,
                                    headerStyle: CalendarHeaderStyle(
                                        textAlign: TextAlign.start,
                                        textStyle: TextStyle(
                                            fontSize: 20,
                                            fontStyle: FontStyle.normal,
                                            letterSpacing: 2,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500)
                                    ),
                                    dataSource: _getCalendarDataSource(),


                                  ),
                                ),
                              ),
                              SizedBox(height:5),
                              Container(
                                  padding: EdgeInsets.all(10),
                                  height: 80,
                                  child: Neumorphic(
                                      style: NeumorphicStyle(
                                        depth: 1,

                                        //shape: NeumorphicShape.convex,
                                        color: NeumorphicColors.background,
                                        boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.all(
                                                Radius.elliptical(20, 20))),
                                      ),
                                      child:  Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                left: 10),
                                            child: Text(
                                              "User's comment",
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ),
                                          ),
                                          Container(
                                              width: 130,
                                              child: Text(widget.commentUser.toString() == "null"|| widget.commentUser.toString()==""? "No comment":widget.commentUser.toString())
                                          ),
                                        ],
                                      )
                                  )),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: commentManagerController,
                                  minLines: 2,
                                  maxLines: 5,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    hintText: 'Comment',
                                    hintStyle: TextStyle(
                                        color: Colors.grey
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: width*0.09,
                                      height: width*0.09,
                                      child: NeumorphicButton(
                                        //margin: EdgeInsets.fromLTRB(5,0,0,0),
                                          onPressed: () async {
                                            _requestService.ValidateRequet(widget.Request_id, "refused",commentManagerController.text, tokenLogin).then((value) async {
                                              SweetAlert.show(context,subtitle: "Loading ...", style: SweetAlertStyle.loading);
                                              setState(() {

                                              });
                                              await Future.delayed(new Duration(seconds:1 ),() async {

                                                if(value["message"]=="Succesfully updated")
                                                { await SweetAlert.show(context,
                                                    subtitle: " Done !",
                                                    style: SweetAlertStyle.success,
                                                    onPress: (bool isConfirm) {
                                                      if (isConfirm) {
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    TeamRequests()));

                                                        // return false to keep dialog
                                                      }
                                                    });}

                                                else{
                                                  await   SweetAlert.show(context,subtitle: "Ooops! Something Went Wrong!", style: SweetAlertStyle.error);

                                                }



                                              });
                                            });

                                          },
                                          style: NeumorphicStyle(
                                            shape: NeumorphicShape.flat,
                                            color: NeumorphicColors.background,
                                            boxShape:
                                            NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                                          ),
                                          padding: const EdgeInsets.all(1.0),
                                          child:Center(child: Icon(Icons.close,size: 22,color:LightColors.kRed,),

                                          )
                                      ),
                                    ), SizedBox(width: width*0.05,),
                                    Container(
                                      width: width*0.09,
                                      height: width*0.09,
                                      child: NeumorphicButton(
                                        // margin: EdgeInsets.fromLTRB(5,0,0,0),
                                          onPressed: () async {
                                            _requestService.ValidateRequet(widget.Request_id, "accepted", commentManagerController.text,tokenLogin).then((value) async {
                                              SweetAlert.show(context,subtitle: "Loading ...", style: SweetAlertStyle.loading);
                                              setState(() {

                                              });
                                              await Future.delayed(new Duration(seconds:1 ),() async {

                                                if(value["message"]=="Succesfully updated")
                                                {  await SweetAlert.show(context,
                                                    subtitle: " Done !",
                                                    style: SweetAlertStyle.success,
                                                    onPress: (bool isConfirm) {
                                                      if (isConfirm) {
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    TeamRequests()));

                                                        // return false to keep dialog
                                                      }
                                                    });}

                                                else{
                                                  await   SweetAlert.show(context,subtitle: "Ooops! Something Went Wrong!", style: SweetAlertStyle.error);

                                                }



                                              });
                                            });

                                          },
                                          style: NeumorphicStyle(
                                            shape: NeumorphicShape.flat,
                                            color: NeumorphicColors.background,
                                            boxShape:
                                            NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                                          ),
                                          padding: const EdgeInsets.all(1.0),
                                          child: Center(child: Icon(
                                            Icons.done, size: 22,
                                            color: LightColors.kgreenD,),

                                          )
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),

                              //  SizedBox(height: _height*0.01,),
                            ],
                          ),


                        ) : Center(child: Text("ERROR"),);
                    }
                    return CircularProgressIndicator();

                  }),
            ),
          )


        ],
      ),
    );
  }
  _AppointmentDataSource _getCalendarDataSource() {
    List<Appointment> appointments = <Appointment>[];
    var StartTime;
    var EndTime;
    Operations.forEach((element) async {

      if (element["OperationType"] == "WFH") {
        var Date = element["date"].toString().substring(0, 10);
        var month = DateTime.parse(Date).month;
        var day = DateTime.parse(Date).day;
        var year = DateTime.parse(Date).year;
        if (element["timeslot"] == "AM") {
          StartTime = 8;
          EndTime = 12;
        }
        if (element["timeslot"] == "PM") {
          StartTime = 14;
          EndTime = 18;
        }
        appointments.add(Appointment(
          startTime: new DateTime(year, month, day, StartTime),
          endTime: new DateTime(year, month, day, EndTime, 30),
          subject: element["OperationType"],
          color: LightColors.Telework,
          startTimeZone: '',
          endTimeZone: '',
          //  notes: 'Desk : 05.W.02.01 ',
          //  location:   "0"
        ));
      } else {
        var Datedebut = element["date_debut"].toString().substring(0, 10);
        var monthdebut = DateTime.parse(Datedebut).month;
        var daydebut = DateTime.parse(Datedebut).day;
        var yeardebut = DateTime.parse(Datedebut).year;

        var Datefin = element["date_fin"].toString().substring(0, 10);
        var monthfin = DateTime.parse(Datefin).month;
        var dayfin = DateTime.parse(Datefin).day;
        var yearfin = DateTime.parse(Datefin).year;

        appointments.add(Appointment(
            startTime: new DateTime(yeardebut, monthdebut, daydebut),
            endTime: new DateTime(yearfin, monthfin, dayfin),
            subject: element["OperationType"],
            color: LightColors.remote,
            startTimeZone: '',
            endTimeZone: '',
            isAllDay: true
          //  notes: 'Desk : 05.W.02.01 ',
          //  location:   "0"
        ));
      }
    });

    return _AppointmentDataSource(appointments);
  }

}

class _AppointmentDataSource extends CalendarDataSource {

  _AppointmentDataSource(List<Appointment> source){
    appointments = source;
  }
}
