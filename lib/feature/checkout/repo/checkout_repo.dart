import 'dart:convert';
import 'package:demandium/components/core_export.dart';
import 'package:demandium/components/service_center_dialog1.dart';
import 'package:get/get.dart';


class CheckoutRepo extends GetxService {
  final ApiClient apiClient;
  CheckoutRepo({required this.apiClient});

  Future<Response> getPostDetails(String postId) async {
    return await apiClient.getData('${AppConstants.getPostDetails}/$postId');
  }

  Future<Response> placeBookingRequest({
    required String paymentMethod, String? serviceAddressID, required AddressModel serviceAddress,required String schedule,
    required String zoneId, required int isPartial, required String offlinePaymentId, required String customerInformation
  }) async {
    String address = jsonEncode(serviceAddress);
    print(" that is api in call 1 ");
    return await apiClient.postData(AppConstants.placeRequest, {
     // "payment_method" : paymentMethod,
     "payment_method": "offline_payment",
      "zone_id" : zoneId,
      "service_schedule" : schedule,
      "service_address_id" : serviceAddressID,
      "guest_id" : Get.find<SplashController>().getGuestId(),
      "service_address" : address,
      "is_partial" : isPartial,
      "offline_payment_id" : offlinePaymentId,
      "customer_information" : customerInformation,
      "quote_id":quote_id,
    });
  }
}
