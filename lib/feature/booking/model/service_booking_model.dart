class ServiceBookingList {
  String? responseCode;
  String? message;
  BookingContent? content;

  ServiceBookingList({this.responseCode, this.message, this.content,});

  ServiceBookingList.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content = json['content'] != null ? BookingContent.fromJson(json['content']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    data['message'] = message;
    if (content != null) {
      data['content'] = content!.toJson();
    }

    return data;
  }
}

class BookingContent {
  int? currentPage;
  List<BookingModel>? bookingModel;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? path;
  String? perPage;
  int? to;
  int? total;

  BookingContent(
      {this.currentPage,
        this.bookingModel,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.path,
        this.perPage,
        this.to,
        this.total});

  BookingContent.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      bookingModel = <BookingModel>[];
      json['data'].forEach((v) {
        bookingModel!.add(BookingModel.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (bookingModel != null) {
      data['data'] = bookingModel!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class BookingModel {
  String? id;
  int? readableId;
  String? customerId;
  String? providerId;
  String? zoneId;
  String? bookingStatus;
  int? isPaid;
  String? paymentMethod;
  String? transactionId;
  num? totalBookingAmount;
  int? quoteOfferedPrice;
  num? totalTaxAmount;
  num? totalDiscountAmount;
  String? serviceSchedule;
  String? serviceAddressId;
  String? createdAt;
  String? updatedAt;
  String? categoryId;
  String? subCategoryId;
  String? servicemanId;
   Post? post;
  Providerss? providerss;


  BookingModel(
      {this.id,
        this.readableId,
        this.customerId,
        this.providerId,
        this.zoneId,
        this.bookingStatus,
        this.isPaid,
        this.paymentMethod,
        this.transactionId,
        this.totalBookingAmount,
        this.quoteOfferedPrice,
        this.totalTaxAmount,
        this.totalDiscountAmount,
        this.serviceSchedule,
        this.serviceAddressId,
        this.createdAt,
        this.updatedAt,
        this.categoryId,
        this.subCategoryId,
        this.servicemanId,
       this.post,
        this.providerss,
      });

  BookingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    readableId = json['readable_id'];
    customerId = json['customer_id'];
    providerId = json['provider_id'];
    zoneId = json['zone_id'];
    bookingStatus = json['booking_status'];
    isPaid = json['is_paid'];
    paymentMethod = json['payment_method'];
    transactionId = json['transaction_id'];
    totalBookingAmount = json['total_booking_amount'];
    quoteOfferedPrice = json['quote_offered_price'];
    totalTaxAmount = json['total_tax_amount'];
    totalDiscountAmount = json['total_discount_amount'];
    serviceSchedule = json['service_schedule'];
    serviceAddressId = json['service_address_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    servicemanId = json['serviceman_id'];
    post = json['post'] != null ? Post.fromJson(json['post']) : null;
     providerss = json['provider'] != null ? new Providerss.fromJson(json['provider']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['readable_id'] = readableId;
    data['customer_id'] = customerId;
    data['provider_id'] = providerId;
    data['zone_id'] = zoneId;
    data['booking_status'] = bookingStatus;
    data['is_paid'] = isPaid;
    data['payment_method'] = paymentMethod;
    data['transaction_id'] = transactionId;
    data['total_booking_amount'] = totalBookingAmount;
    data['quote_offered_price'] = quoteOfferedPrice;
    data['total_tax_amount'] = totalTaxAmount;
    data['total_discount_amount'] = totalDiscountAmount;
    data['service_schedule'] = serviceSchedule;
    data['service_address_id'] = serviceAddressId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['category_id'] = categoryId;
    data['sub_category_id'] = subCategoryId;
    data['serviceman_id'] = servicemanId;
    if (this.post != null) {
      data['post'] = this.post!.toJson();
    }
    if (this.providerss != null) {
      data['provider'] = this.providerss!.toJson();
    }

    return data;
  }
}

class Post {
  dynamic id;
  dynamic serviceDescription;
  dynamic serviceName;
  dynamic quoteProviderId;
  dynamic bookingSchedule;
  dynamic isBooked;
  dynamic  isChecked;
  dynamic customerUserId;
  dynamic providerId;
  dynamic serviceId;
  dynamic categoryId;
  dynamic subCategoryId;
  dynamic serviceAddressId;
  dynamic zoneId;
  dynamic  bookingId;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic isGuest;
  dynamic service;

  Post(
      {this.id,
        this.serviceDescription,
        this.serviceName,
        this.quoteProviderId,
        this.bookingSchedule,
        this.isBooked,
        this.isChecked,
        this.customerUserId,
        this.providerId,
        this.serviceId,
        this.categoryId,
        this.subCategoryId,
        this.serviceAddressId,
        this.zoneId,
        this.bookingId,
        this.createdAt,
        this.updatedAt,
        this.isGuest,
        this.service});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceDescription = json['service_description'];
    serviceName = json['service_name'];
    quoteProviderId = json['quote_provider_id'];
    bookingSchedule = json['booking_schedule'];
    isBooked = json['is_booked'];
    isChecked = json['is_checked'];
    customerUserId = json['customer_user_id'];
    providerId = json['provider_id'];
    serviceId = json['service_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    serviceAddressId = json['service_address_id'];
    zoneId = json['zone_id'];
    bookingId = json['booking_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isGuest = json['is_guest'];
    service = json['service'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_description'] = this.serviceDescription;
    data['service_name'] = this.serviceName;
    data['quote_provider_id'] = this.quoteProviderId;
    data['booking_schedule'] = this.bookingSchedule;
    data['is_booked'] = this.isBooked;
    data['is_checked'] = this.isChecked;
    data['customer_user_id'] = this.customerUserId;
    data['provider_id'] = this.providerId;
    data['service_id'] = this.serviceId;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['service_address_id'] = this.serviceAddressId;
    data['zone_id'] = this.zoneId;
    data['booking_id'] = this.bookingId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_guest'] = this.isGuest;
    data['service'] = this.service;
    return data;
  }
}
class Providerss {
  dynamic id;
  dynamic userId;
  dynamic companyType;
dynamic companyName;
dynamic companyPhone;
dynamic companyAddress;
  dynamic companyEmail;
  dynamic companyDescription;
  dynamic logo;
  dynamic contactPersonName;
  dynamic contactPersonPhone;
  dynamic contactPersonEmail;
  dynamic orderCount;
  dynamic serviceManCount;
  dynamic serviceCapacityPerDay;
  dynamic ratingCount;
  dynamic avgRating;
  dynamic commissionStatus;
  dynamic commissionPercentage;
  dynamic isActive;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic isApproved;
 dynamic zoneId;
 
 dynamic serviceDistanse;
 dynamic fullAddress;
 dynamic city;
 dynamic street;
 dynamic state;
 dynamic country;
 dynamic zipCode;
 dynamic isSuspended;
 dynamic  deletedAt;
 dynamic serviceAvailability;

  Providerss(
      {this.id,
        this.userId,
        this.companyType,
        this.companyName,
        this.companyPhone,
        this.companyAddress,
        this.companyEmail,
        this.companyDescription,
        this.logo,
        this.contactPersonName,
        this.contactPersonPhone,
        this.contactPersonEmail,
        this.orderCount,
        this.serviceManCount,
        this.serviceCapacityPerDay,
        this.ratingCount,
        this.avgRating,
        this.commissionStatus,
        this.commissionPercentage,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.isApproved,
        this.zoneId,

        this.serviceDistanse,
        this.fullAddress,
        this.city,
        this.street,
        this.state,
        this.country,
        this.zipCode,
        this.isSuspended,
        this.deletedAt,
        this.serviceAvailability});

  Providerss.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    companyType = json['company_type'];
    companyName = json['company_name'];
    companyPhone = json['company_phone'];
    companyAddress = json['company_address'];
    companyEmail = json['company_email'];
    companyDescription = json['company_description'];
    logo = json['logo'];
    contactPersonName = json['contact_person_name'];
    contactPersonPhone = json['contact_person_phone'];
    contactPersonEmail = json['contact_person_email'];
    orderCount = json['order_count'];
    serviceManCount = json['service_man_count'];
    serviceCapacityPerDay = json['service_capacity_per_day'];
    ratingCount = json['rating_count'];
    avgRating = json['avg_rating'];
    commissionStatus = json['commission_status'];
    commissionPercentage = json['commission_percentage'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isApproved = json['is_approved'];
    zoneId = json['zone_id'];
    serviceDistanse = json['service_distanse'];
    fullAddress = json['full_address'];
    city = json['city'];
    street = json['street'];
    state = json['state'];
    country = json['country'];
    zipCode = json['zip_code'];
    isSuspended = json['is_suspended'];
    deletedAt = json['deleted_at'];
    serviceAvailability = json['service_availability'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['company_type'] = this.companyType;
    data['company_name'] = this.companyName;
    data['company_phone'] = this.companyPhone;
    data['company_address'] = this.companyAddress;
    data['company_email'] = this.companyEmail;
    data['company_description'] = this.companyDescription;
    data['logo'] = this.logo;
    data['contact_person_name'] = this.contactPersonName;
    data['contact_person_phone'] = this.contactPersonPhone;
    data['contact_person_email'] = this.contactPersonEmail;
    data['order_count'] = this.orderCount;
    data['service_man_count'] = this.serviceManCount;
    data['service_capacity_per_day'] = this.serviceCapacityPerDay;
    data['rating_count'] = this.ratingCount;
    data['avg_rating'] = this.avgRating;
    data['commission_status'] = this.commissionStatus;
    data['commission_percentage'] = this.commissionPercentage;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_approved'] = this.isApproved;
    data['zone_id'] = this.zoneId;
    data['service_distanse'] = this.serviceDistanse;
    data['full_address'] = this.fullAddress;
    data['city'] = this.city;
    data['street'] = this.street;
    data['state'] = this.state;
    data['country'] = this.country;
    data['zip_code'] = this.zipCode;
    data['is_suspended'] = this.isSuspended;
    data['deleted_at'] = this.deletedAt;
    data['service_availability'] = this.serviceAvailability;
    return data;
  }
}

