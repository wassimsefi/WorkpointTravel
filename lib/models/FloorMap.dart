class FloorMap {
  String id;
  String statusAM;
  String userAM;
  String statusPM;
  String userPM;
  String deskname;
  String positionX;
  String positionY;

  FloorMap.fromMap(Map data) {
    this.id= data['id'] ?? 'No zoneid.';
    this.statusAM= data['statusAM'] ?? 'No statusAM.';
    this.userAM= data['userAM'] ?? 'No userAM.';
    this.statusPM= data['statusPM'] ?? 'No statusPM.';
    this.userPM= data['userPM'] ?? 'No userPM.';
    this.deskname= data['deskname'] ?? 'No deskname.';
    this.positionX= data['positionX'] ?? 'No positionX.';
    this.positionY= data['positionY'] ?? 'No positionY.';

  //  this.tile = data['tile'] ?? 0;
  }
}
