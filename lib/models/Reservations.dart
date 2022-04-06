
  import 'package:vato/models/Desk.dart';
import 'package:vato/models/DeskReservation.dart';

  import 'package:vato/models/User.dart';
import 'package:vato/models/UserReservation.dart';
  class Reservations {

  String timeslot;
  String user;
  String desk;
  String reservationdate;





  Reservations.fromJsonMap(Map<String, dynamic> map):
  timeslot = map["timeslot"],
  user = map["user"],
  desk = map["desk"],
  reservationdate = map["reservationdate"];


  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data["timeslot"] = timeslot;
  data["user"] = user ;
  data["desk"] =  desk ;
  data["reservationdate"] = reservationdate ;

  return data;
  }

  Reservations();
  }





