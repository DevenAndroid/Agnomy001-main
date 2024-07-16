import 'package:demandium/core/common_model/provider_model.dart';
import 'package:demandium/core/common_model/serviceman_model.dart';
import 'package:demandium/core/common_model/user_model.dart';
import 'package:demandium/components/core_export.dart';

class BookingDetailsModel {
  String? responseCode;
  String? message;
  BookingDetailsContent? content;

  BookingDetailsModel({this.responseCode, this.message, this.content});

  BookingDetailsModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content = json['content'] != null ? BookingDetailsContent.fromJson(json['content']) : null;
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

class BookingDetailsContent {
  String? id;
  int? readableId;
  String? customerId;
  String? providerId;
  String? zoneId;
  String? bookingStatus;
  dynamic customerBookingStatus;
  int? isPaid;
  String? paymentMethod;
  String? transactionId;
  double? totalBookingAmount;
  int? quoteOfferedPrice;
  num? totalTaxAmount;
  num? totalDiscountAmount;
  String? serviceSchedule;
  String? serviceAddressId;
  String? createdAt;
  String? updatedAt;
  String? categoryId;
  String? subCategoryId;
  List<BookingContentDetailsItem>? detail;
  List<ScheduleHistories>? scheduleHistories;
  List<StatusHistories>? statusHistories;
  List<PartialPayment>? partialPayments;
  ServiceAddress? serviceAddress;
  Customer? customer;
  ProviderModel? provider;
  Serviceman? serviceman;
  num ? totalCampaignDiscountAmount;
  num? totalCouponDiscountAmount;
  String? bookingOtp;
  List<String>? photoEvidence;
  double? extraFee;
  double ? additionalCharge;
  Posts? posts;




  BookingDetailsContent(
      {this.id,
        this.readableId,
        this.customerId,
        this.providerId,
        this.zoneId,
        this.bookingStatus,
        this.customerBookingStatus,
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
        this.detail,
        this.scheduleHistories,
        this.statusHistories,
        this.partialPayments,
        this.serviceAddress,
        this.customer,
        this.provider,
        this.serviceman,
        this.totalCampaignDiscountAmount,
        this.totalCouponDiscountAmount,
        this.bookingOtp,
        this.photoEvidence,
        this.extraFee,
        this.additionalCharge,
        this.posts



      });

  BookingDetailsContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    readableId = json['readable_id'];
    customerId = json['customer_id'];
    providerId = json['provider_id'];
    zoneId = json['zone_id'];
    bookingStatus = json['booking_status'];
    customerBookingStatus = json['customer_booking_status'];
    isPaid = json['is_paid'];
    paymentMethod = json['payment_method'];
    transactionId = json['transaction_id'];
    totalBookingAmount = double.tryParse(json['total_booking_amount'].toString());
    quoteOfferedPrice = json['quote_offered_price'];
    totalTaxAmount = json['total_tax_amount'];
    totalDiscountAmount = json['total_discount_amount'];
    serviceSchedule = json['service_schedule'];
    serviceAddressId = json['service_address_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    if (json['detail'] != null) {
      detail = <BookingContentDetailsItem>[];
      json['detail'].forEach((v) {
        detail!.add(BookingContentDetailsItem.fromJson(v));
      });
    }
    if (json['schedule_histories'] != null) {
      scheduleHistories = <ScheduleHistories>[];
      json['schedule_histories'].forEach((v) {
        scheduleHistories!.add(ScheduleHistories.fromJson(v));
      });
    }
    if (json['status_histories'] != null) {
      statusHistories = <StatusHistories>[];
      json['status_histories'].forEach((v) {

        statusHistories!.add(StatusHistories.fromJson(v));
      });
    }

    if (json['booking_partial_payments'] != null) {
      partialPayments = <PartialPayment>[];
      json['booking_partial_payments'].forEach((v) {
        partialPayments!.add(PartialPayment.fromJson(v));
      });
    }

    serviceAddress = json['service_address'] != null
        ? ServiceAddress.fromJson(json['service_address'])
        : null;
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;
    provider = json['provider'] != null
        ? ProviderModel.fromJson(json['provider'])
        : null;
    serviceman = json['serviceman'] != null
        ? Serviceman.fromJson(json['serviceman'])
        : null;
    totalCampaignDiscountAmount = json['total_campaign_discount_amount'];
    totalCouponDiscountAmount =json['total_coupon_discount_amount'];
    bookingOtp = json["booking_otp"].toString();
    photoEvidence = json["evidence_photos"]!=null? json["evidence_photos"].cast<String>(): [];
    extraFee = double.tryParse(json["extra_fee"].toString());
    additionalCharge = double.tryParse(json['additional_charge'].toString());
    posts = json['post'] != null ? new Posts.fromJson(json['post']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['readable_id'] = readableId;
    data['customer_id'] = customerId;
    data['provider_id'] = providerId;
    data['zone_id'] = zoneId;
    data['booking_status'] = bookingStatus;
    data['customer_booking_status'] = customerBookingStatus;
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
    if (detail != null) {
      data['detail'] = detail!.map((v) => v.toJson()).toList();
    }
    if (scheduleHistories != null) {
      data['schedule_histories'] =
          scheduleHistories!.map((v) => v.toJson()).toList();
    }
    if (statusHistories != null) {
      data['status_histories'] =
          statusHistories!.map((v) => v.toJson()).toList();
    }

    if (partialPayments != null) {
      data['booking_partial_payments'] =
          partialPayments!.map((v) => v.toJson()).toList();
    }
    if (serviceAddress != null) {
      data['service_address'] = serviceAddress!.toJson();
    }
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (provider != null) {
      data['provider'] = provider!.toJson();
    }
    if (serviceman != null) {
      data['serviceman'] = serviceman!.toJson();
    }
    if (this.posts != null) {
      data['post'] = this.posts!.toJson();
    }

    return data;
  }
}

class BookingContentDetailsItem {
  int? id;
  String? bookingId;
  String? serviceId;
  String? variantKey;
  num? serviceCost;
  int? quantity;
  num? discountAmount;
  num? taxAmount;
  num? totalCost;
  String? createdAt;
  String? updatedAt;
  Service? service;
  num? campaignDiscountAmount;
  num? overallCouponDiscountAmount;
  String? serviceName;


  BookingContentDetailsItem(
      {this.id,
        this.bookingId,
        this.serviceId,
        this.variantKey,
        this.serviceCost,
        this.quantity,
        this.discountAmount,
        this.taxAmount,
        this.totalCost,
        this.createdAt,
        this.updatedAt,
        this.service,
        this.campaignDiscountAmount,
        this.overallCouponDiscountAmount,
        this.serviceName,
      });

  BookingContentDetailsItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    serviceId = json['service_id'];
    variantKey = json['variant_key'];
    serviceCost = json['service_cost'];
    quantity = json['quantity'];
    discountAmount = json['discount_amount'];
    taxAmount = json['tax_amount'];
    totalCost = json['total_cost'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    service = json['service'] != null ? Service.fromJson(json['service']) : null;
    campaignDiscountAmount = json['campaign_discount_amount'];
    overallCouponDiscountAmount =json['overall_coupon_discount_amount'];
    serviceName = json['service_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['booking_id'] = bookingId;
    data['service_id'] = serviceId;
    data['variant_key'] = variantKey;
    data['service_cost'] = serviceCost;
    data['quantity'] = quantity;
    data['discount_amount'] = discountAmount;
    data['tax_amount'] = taxAmount;
    data['total_cost'] = totalCost;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;

    if (service != null) {
      data['service'] = service!.toJson();
    }

    data['service_name'] = serviceName;
    return data;
  }
}

class ScheduleHistories {
  int? id;
  String? bookingId;
  String? changedBy;
  String? schedule;
  String? createdAt;
  String? updatedAt;
  User? user;

  ScheduleHistories(
      {this.id,
        this.bookingId,
        this.changedBy,
        this.schedule,
        this.createdAt,
        this.updatedAt,
        this.user});

  ScheduleHistories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    changedBy = json['changed_by'];
    schedule = json['schedule'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['booking_id'] = bookingId;
    data['changed_by'] = changedBy;
    data['schedule'] = schedule;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class StatusHistories {
  int? id;
  String? bookingId;
  String? changedBy;
  String? bookingStatus;
  String? schedule;
  String? createdAt;
  String? updatedAt;
  User? user;

  StatusHistories(
      {this.id,
        this.bookingId,
        this.changedBy,
        this.bookingStatus,
        this.schedule,
        this.createdAt,
        this.updatedAt,
        this.user});

  StatusHistories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    changedBy = json['changed_by'];
    bookingStatus = json['booking_status'];
    schedule = json['schedule'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['booking_id'] = bookingId;
    data['changed_by'] = changedBy;
    data['booking_status'] = bookingStatus;
    data['schedule'] = schedule;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}



class ServiceAddress {
  int? id;
  String? userId;
  String? lat;
  String? lon;
  String? city;
  String? street;
  String? zipCode;
  String? country;
  String? address;
  String? createdAt;
  String? updatedAt;
  String? addressType;
  String? contactPersonName;
  String? contactPersonNumber;
  String? addressLabel;

  ServiceAddress(
      {this.id,
        this.userId,
        this.lat,
        this.lon,
        this.city,
        this.street,
        this.zipCode,
        this.country,
        this.address,
        this.createdAt,
        this.updatedAt,
        this.addressType,
        this.contactPersonName,
        this.contactPersonNumber,
        this.addressLabel});

  ServiceAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    lat = json['lat'];
    lon = json['lon'];
    city = json['city'];
    street = json['street'];
    zipCode = json['zip_code'];
    country = json['country'];
    address = json['address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    addressType = json['address_type'];
    contactPersonName = json['contact_person_name'];
    contactPersonNumber = json['contact_person_number'];
    addressLabel = json['address_label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['lat'] = lat;
    data['lon'] = lon;
    data['city'] = city;
    data['street'] = street;
    data['zip_code'] = zipCode;
    data['country'] = country;
    data['address'] = address;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['address_type'] = addressType;
    data['contact_person_name'] = contactPersonName;
    data['contact_person_number'] = contactPersonNumber;
    data['address_label'] = addressLabel;
    return data;
  }
}

class PartialPayment {
  String? id;
  String? bookingId;
  String? paidWith;
  double? paidAmount;
  double? dueAmount;
  String? createdAt;
  String? updatedAt;

  PartialPayment(
      {this.id,
        this.bookingId,
        this.paidWith,
        this.paidAmount,
        this.dueAmount,
        this.createdAt,
        this.updatedAt});

  PartialPayment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    paidWith = json['paid_with'];
    paidAmount = double.tryParse(json['paid_amount'].toString());
    dueAmount = double.tryParse(json['due_amount'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['booking_id'] = bookingId;
    data['paid_with'] = paidWith;
    data['paid_amount'] = paidAmount;
    data['due_amount'] = dueAmount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Posts {
  dynamic id;
  dynamic serviceDescription;
  dynamic serviceName;
  dynamic quoteProviderId;
  dynamic bookingSchedule;
 dynamic isBooked;
 dynamic isChecked;
 dynamic customerUserId;
 dynamic providerId;
 dynamic serviceId;
 dynamic categoryId;
 dynamic subCategoryId;
 dynamic serviceAddressId;
 dynamic zoneId;
  dynamic bookingId;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic isGuest;
  Latestbid? latestbid;

  Posts(
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
        this.latestbid});

  Posts.fromJson(Map<String, dynamic> json) {
    print("anKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK${json['latestbid']}");
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
    latestbid = json['latestbid'] != null
        ? new Latestbid.fromJson(json['latestbid'])
        : null;
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
    if (this.latestbid != null) {
      data['latestbid'] = this.latestbid!.toJson();
    }
    return data;
  }
}

class Latestbid {
  dynamic id;
  dynamic offeredPrice;
  dynamic providerNote;
  dynamic status;
  dynamic postId;
  dynamic providerId;
  dynamic createdAt;
  dynamic updatedAt;

  Latestbid(
      {this.id,
        this.offeredPrice,
        this.providerNote,
        this.status,
        this.postId,
        this.providerId,
        this.createdAt,
        this.updatedAt});

  Latestbid.fromJson(Map<String, dynamic> json) {
    providerNote = json['provider_note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['offered_price'] = this.offeredPrice;
    data['provider_note'] = this.providerNote;
    data['status'] = this.status;
    data['post_id'] = this.postId;
    data['provider_id'] = this.providerId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}