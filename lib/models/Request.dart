
class Requests {
  String name;
  String idSender;
  String idReciever;
  List UserNotif=[];
  List date=[];
  int week;

  int month;
  double countWeek;
  double countMonth;
  int monthTwo;
  double countMonthTwo;
  bool isManager;
  String commentUser;
  String start;
  String end;


  Requests.fromJsonMap(Map<String, dynamic> map):
        name = map["name"],
        idSender = map["idSender"],
        idReciever = map["idReciever"],
        UserNotif = map["sUerNotif"],
        date = map["date"],
        week = map["week"],

         month=map["month"],
   countWeek=map["countWeek"],
   countMonth=map["countMonth"],
   monthTwo=map["monthTwo"],
   countMonthTwo=map["countMonthTwo"],
        commentUser=map["commentUser"],


        isManager=map["isManager"],
  start=map["start"],
  end=map["end"];




  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["name"] = name;
    data["idSender"] = idSender ;
    data["idReciever"] =  idReciever ;
    data["UserNotif"] = UserNotif ;
    data["date"] = date ;
    data["week"] = week ;
    data["month"]=month;
    data["countWeek"]=countWeek;
    data["countMonth"]=countMonth;
    data["monthTwo"]=monthTwo;
    data["countMonthTwo"]= countMonthTwo;
    data["isManager"]= isManager;
    data["commentUser"]= commentUser;
    data["start"]= start;
    data["end"]= end;





    return data;
  }

  Requests();
}





