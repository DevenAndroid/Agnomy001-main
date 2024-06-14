class CreatequoteModel {
  String? responseCode;
  String? message;
  Content? content;
 // List<Null>? errors;

  CreatequoteModel(
      {this.responseCode, this.message, this.content});

  CreatequoteModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content =
    json['content'] != null ? new Content.fromJson(json['content']) : null;
    // if (json['errors'] != null) {
    //   errors = <Null>[];
    //   json['errors'].forEach((v) {
    //     errors!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    // if (this.errors != null) {
    //   data['errors'] = this.errors!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Content {
  String? message;

  Content({this.message});

  Content.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
