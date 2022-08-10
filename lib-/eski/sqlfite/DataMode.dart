class PlanModel {
  String name;
  String baslangc;
  String bitis;
  String planlar;

  PlanModel({this.name, this.baslangc, this.bitis, this.planlar});

  PlanModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    baslangc = json['baslangıc'];
    bitis = json['bitis'];
    planlar = json['planlar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['baslangıc'] = this.baslangc;
    data['bitis'] = this.bitis;
    data['planlar'] = this.planlar;
    return data;
  }
}

class EventModel {
  String yer;
  String baslangic;
  String bitis;

  EventModel({this.yer, this.baslangic, this.bitis});

  EventModel.fromJson(Map<String, dynamic> json) {
    yer = json['yer'];
    baslangic = json['baslangic'];
    bitis = json['bitis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['yer'] = this.yer;
    data['baslangic'] = this.baslangic;
    data['bitis'] = this.bitis;
    return data;
  }
}

class UserModel {
  String name;
  String email;
  String photo;
  String birth;
  String password;

  UserModel(this.name, this.email, this.photo, this.birth, this.password);

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    photo = json['photo'];
    birth = json['birth'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['photo'] = this.photo;
    data['birth'] = this.birth;
    data['password'] = this.password;
    return data;
  }
}