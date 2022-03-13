class UserModel {
  Id? iId;
  String? fid;
  String? a;
  Cdate? cdate;

  UserModel({this.iId, this.fid, this.a, this.cdate});

  UserModel.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] != null ? new Id.fromJson(json['_id']) : null;
    fid = json['fid'];
    a = json['a'];
    cdate = json['cdate'] != null ? new Cdate.fromJson(json['cdate']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.iId != null) {
      data['_id'] = this.iId!.toJson();
    }
    data['fid'] = this.fid;
    data['a'] = this.a;
    if (this.cdate != null) {
      data['cdate'] = this.cdate!.toJson();
    }
    return data;
  }
}

class Id {
  String? oid;

  Id({this.oid});

  Id.fromJson(Map<String, dynamic> json) {
    oid = json['$oid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$oid'] = this.oid;
    return data;
  }
}

class Cdate {
  int? date;

  Cdate({this.date});

  Cdate.fromJson(Map<String, dynamic> json) {
    date = json['$date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$date'] = this.date;
    return data;
  }
}
