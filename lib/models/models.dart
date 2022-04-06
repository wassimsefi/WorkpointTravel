class Light {
  String location;
  String name;
  bool statusAM;
  bool statusPM;
  List<double> position;
  int tile;

  Light.fromMap(Map data) {
    this.location = data['location'] ?? 'No location.';
    this.name = data['name'] ?? 'No name.';
    this.statusAM = data['statusAM'] ?? false;
    this.statusPM = data['statusPM'] ?? false;
    this.position = data['position'] ?? [0.0];
    this.tile = data['tile'] ?? 0;
  }
}
