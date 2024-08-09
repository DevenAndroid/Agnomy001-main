import 'dart:convert';
import 'package:demandium/components/core_export.dart';
import 'package:demandium/components/service_center_dialog1.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class CheckoutRepo extends GetxService {
  final ApiClient apiClient;
  CheckoutRepo({required this.apiClient});



     RxInt referesh =  Get.find<ScheduleController>().refreshIt;

  Future<Response> getPostDetails(String postId) async {
    print('post IDDDDDDDDDDDDDDDDDDDDD=>${postId.toString()}');
    return await apiClient.getData('${AppConstants.getPostDetails}/$postId');
  }

  Future<Response> placeBookingRequest({
    required String paymentMethod, String? serviceAddressID, required AddressModel serviceAddress,required String schedule,
    required String zoneId, required int isPartial, required String offlinePaymentId, required String customerInformation
  }) async {
    String address = jsonEncode(serviceAddress);
    print(" that is api in call 1 ");
    print(" zoneId${zoneId}");
    print("schedule${schedule}");
    print("serviceAddressID${serviceAddressID} ");
    print(" Get.find<SplashController>().getGuestId()${ Get.find<SplashController>().getGuestId()}");
    print("address${address}");
    print("isPartial${isPartial}");
    print("offlinePaymentId${offlinePaymentId}");
    print("customerInformation${customerInformation}");
    print("quote_id${quote_id}");

    DateTime selectedEndTime =  Get.find<ScheduleController>().sselectedEndDate;
    DateTime selectedStartTime =  Get.find<ScheduleController>().selectedData;
    // Define your date format
    DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

// Convert DateTime to String
    String formattedEndTime = dateFormat.format(selectedEndTime);
    String formattedStartTime = dateFormat.format(selectedStartTime);

    print('Formatted End Time: $formattedEndTime');
    print('Formatted Start Time: $formattedStartTime');
    print("enddate::::${selectedEndTime}");
    return await apiClient.postData(AppConstants.placeRequest, {
      "payment_method": "stripe",
      // "payment_method": "stripe",
      "quote_id":quote_id,
      "zone_id" : zoneId,
      "service_address_id" : serviceAddressID,
      "service_schedule" : formattedStartTime,
      "service_address" : address,
      "start_date":formattedStartTime,//schedule,
      "end_date":formattedEndTime
      // "guest_id" : Get.find<SplashController>().getGuestId(),
      // "is_partial" : isPartial,
      // "offline_payment_id" : offlinePaymentId,
      // "customer_information" : customerInformation,
    },headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization':'Bearer ${Get.find<SplashController>().splashRepo.apiClient.token.toString()}'
    }
    );
  }

}
