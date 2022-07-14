class Historique {
  String user;

  String message;
  String TransactionType;

  Historique.fromJsonMap(Map<String, dynamic> map)
      : user = map["user"],
        message = map["message"],
        TransactionType = map["TransactionType"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["user"] = user;
    data["message"] = message;
    data["TransactionType"] = TransactionType;

    return data;
  }

  Historique();
}
