class QuotesListModel {
  String? responseCode;
  String? message;
  Content? content;
  // List<Null>? errors;

  QuotesListModel({this.responseCode, this.message, this.content});

  QuotesListModel.fromJson(Map<String, dynamic> json) {
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
  QuoteData? quoteData;

  Content({this.quoteData});

  Content.fromJson(Map<String, dynamic> json) {
    quoteData = json['quote_data'] != null
        ? new QuoteData.fromJson(json['quote_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.quoteData != null) {
      data['quote_data'] = this.quoteData!.toJson();
    }
    return data;
  }
}

class QuoteData {
  String? id;
  String? userId;
  Null? guestId;
  String? serviceId;
  String? serviceName;
  String? serviceShortDescription;
  String? subCategoryId;
  String? subCategoryName;
  List<QuoteProviders>? quoteProviders;

  QuoteData(
      {this.id,
        this.userId,
        this.guestId,
        this.serviceId,
        this.serviceName,
        this.serviceShortDescription,
        this.subCategoryId,
        this.subCategoryName,
        this.quoteProviders});

  QuoteData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    guestId = json['guest_id'];
    serviceId = json['service_id'];
    serviceName = json['service_name'];
    serviceShortDescription = json['service_short_description'];
    subCategoryId = json['sub_category_id'];
    subCategoryName = json['sub_category_name'];
    if (json['quote_providers'] != null) {
      quoteProviders = <QuoteProviders>[];
      json['quote_providers'].forEach((v) {
        quoteProviders!.add(new QuoteProviders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['guest_id'] = this.guestId;
    data['service_id'] = this.serviceId;
    data['service_name'] = this.serviceName;
    data['service_short_description'] = this.serviceShortDescription;
    data['sub_category_id'] = this.subCategoryId;
    data['sub_category_name'] = this.subCategoryName;
    if (this.quoteProviders != null) {
      data['quote_providers'] =
          this.quoteProviders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuoteProviders {
  String? id;
  String? providerId;
  String? providerName;
  String? logo;
  String? cropTypes;

  QuoteProviders({this.id, this.providerId, this.providerName, this.logo});

  QuoteProviders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['provider_id'];
    providerName = json['provider_name'];
    logo = json['logo'];
    cropTypes = json['crop_types'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provider_id'] = this.providerId;
    data['provider_name'] = this.providerName;
    data['logo'] = this.logo;
    data['crop_types'] = this.cropTypes;
    return data;
  }
}
