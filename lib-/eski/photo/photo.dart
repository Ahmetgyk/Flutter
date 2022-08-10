class Photo{
  int id;
  String photoName;

  Photo({this.id, this.photoName});

  Map<String, dynamic> toMap(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['photoName'] = this.photoName;
    return data;
  }

  Photo.fromMap(Map<String, dynamic> map){
    id = map['id'];
    photoName = map['photoName'];
  }
}