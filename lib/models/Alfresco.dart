import 'dart:io';

class Document {
  int id;
  File filedata;
  String filename;
  String destination;
  bool overwrite;

  Document.fromJsonMap(Map<String, dynamic> map)
      : id = map["nodeRef"],
        filename = map["filenamees"],
        destination = map["destination"],
        overwrite = map["overwrite"],
        filedata = map["filedata"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nodeRef'] = id;
    data["filenamees"] = filename;
    data["destination"] = destination;
    data["overwrite"] = overwrite;

    data["filedata"] = filedata;

    return data;
  }

  Document();
}
