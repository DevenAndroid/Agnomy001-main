class CropTypesModel {
  String? responseCode;
  String? message;
  List<dynamic>? content;


  CropTypesModel({this.responseCode, this.message, this.content});

  CropTypesModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content = json['content'].cast<String>();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    data['content'] = this.content;
    return data;
  }
}
