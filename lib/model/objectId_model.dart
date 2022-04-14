class ObjectId {
  String? oid;

  ObjectId({this.oid});

  ObjectId.fromJson(Map<String, dynamic> json) {
    oid = json['\$oid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$oid'] = this.oid;
    return data;
  }
}
