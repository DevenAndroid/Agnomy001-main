import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:demandium/components/core_export.dart';

import '../../web_landing/widget/web_landing_search_box.dart';

class ProviderBookingRepo {
  final ApiClient apiClient;
  ProviderBookingRepo({required this.apiClient});


  Future<Response> getCategoryList() async {
    return await apiClient.getData('${AppConstants.categoryUrl}&limit=100&offset=1');
  }

  Future<Response> getProviderList({required int offset, int? distance , String? placeID,required  Map<String,dynamic> body}) async {
    AddressModel addressModel = Get.find<LocationController>().getUserAddress()!;

    return await apiClient.postData("${AppConstants.getProviderList}$offset&placeid$placeID&distance$distance&lat=${addressModel.latitude.toString()}&long=${addressModel.longitude.toString()}",body);
  }

  Future<Response> getProviderDetails(String providerId) async {
    return await apiClient.getData("${AppConstants.getProviderDetails}?id=$providerId");
  }
}