class ServicewiseProviderModel {
  String? responseCode;
  String? message;
  List<Content>? content;
  //List<Null>? errors;

  ServicewiseProviderModel(
      {this.responseCode, this.message, this.content,
      //  this.errors
      });

  ServicewiseProviderModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    if (json['content'] != null) {
      content = <Content>[];
      json['content'].forEach((v) {
        content!.add(new Content.fromJson(v));
      });
    }
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
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    // if (this.errors != null) {
    //   data['errors'] = this.errors!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Content {
  String? providerId;
  String? name;
  int? distance;

  Content({this.providerId, this.name, this.distance});

  Content.fromJson(Map<String, dynamic> json) {
    providerId = json['provider_id'];
    name = json['name'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provider_id'] = this.providerId;
    data['name'] = this.name;
    data['distance'] = this.distance;
    return data;
  }
}
