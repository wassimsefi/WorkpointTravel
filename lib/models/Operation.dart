class Operation {
  String request;
  String status;
  String OperationType;
  String user;

  String date_debut;
  String date_fin;

  Operation.fromJsonMap(Map<String, dynamic> map)
      : request = map["request"],
        status = map["status"],
        OperationType = map["OperationType"],
        date_debut = map["date_debut"],
        user = map["user"],
        date_fin = map["date_fin"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["request"] = request;
    data["status"] = status;
    data["OperationType"] = OperationType;

    data["date_debut"] = date_debut;
    data["user"] = user;

    data["date_fin"] = date_fin;

    return data;
  }

  Operation();
}
