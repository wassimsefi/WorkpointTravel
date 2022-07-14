class Notifications {
  String request;
  String idReciever;
  String idSender;
  String Action;

  String message;
  String title;

  Notifications.fromJsonMap(Map<String, dynamic> map)
      : request = map["request"],
        idReciever = map["idReciever"],
        idSender = map["idSender"],
        Action = map["Action"],
        message = map["message"],
        title = map["title"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["request"] = request;
    data["idReciever"] = idReciever;
    data["idSender"] = idSender;
    data["Action"] = Action;
    data["message"] = message;
    data["title"] = title;

    return data;
  }

  Notifications();
}
