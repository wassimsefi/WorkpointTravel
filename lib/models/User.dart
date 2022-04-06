
class User {

  String id;
  List Accesses;
  String firstName;
  String lastName;
  String Email;
  String password;
  String role;
  String tokenDevice;






  User.fromJsonMap(Map<String, dynamic> map):
        id = map["_id"],
        firstName = map["firstName"],

        Accesses = map["Accesses"],
        lastName = map["lastName"],
        Email = map["Email"],
        password = map["password"],
        role = map["role"],
        tokenDevice = map["tokenDevice"];



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = id;
    data["Accesses"] = Accesses ;
    data["firstName"] = firstName ;
    data["lastName"] = lastName;
    data["Email"] = Email;
    data["password"] =  password ;
    data["role"] = role ;
    data["tokenDevice"] = tokenDevice ;

    return data;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      Accesses: json['Accesses'],
        firstName: json['firstName'],
        lastName: json['lastName'],

    );
  }

  User({id, Accesses, firstName, lastName});
}





