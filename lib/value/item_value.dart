class ItemModel {
  String? id;
  String? name;
  String? singer;
  String? img;
  String? audio;

  ItemModel({this.id, this.name, this.singer, this.img});

  ItemModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['song'];
    singer = json['singer'];
    img = json['img'];
    audio = json['audio'];
  }
}
