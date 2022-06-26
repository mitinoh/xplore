class ResponseModel {
  int? statuseCode;
  String? message;

  ResponseModel({this.statuseCode, this.message});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    statuseCode = json['statuseCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statuseCode'] = this.statuseCode;
    data['message'] = this.message;
    return data;
  }
}
