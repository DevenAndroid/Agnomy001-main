class ApprovedModel {
  String? responseCode;
  String? message;
  Null? content;


  ApprovedModel({this.responseCode, this.message, this.content});

  ApprovedModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    data['content'] = this.content;
    return data;
  }
}
