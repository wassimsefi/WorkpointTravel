
import 'package:vato/models/Access.dart';
import 'package:vato/models/Grades.dart';
import 'package:vato/models/Reservations.dart';
import 'package:vato/models/ServicesLines.dart';

class UserLog {

  String _id;
  String firstName;
  String lastName;
  String Email;
  String role;

  UserLog.fromJsonMap(Map<String, dynamic> map):
        _id = map["_id"],
        firstName = map["firstName"],
        lastName = map["lastName"],
        Email = map["Email"],
        role = map["role"];


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = _id;
    data["firstName"] = firstName ;
    data["lastName"] = lastName;
    data["Email"] = Email;
    data["role"] = role ;
    return data;
  }

  UserLog();

}





