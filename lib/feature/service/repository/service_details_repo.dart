import 'package:demandium/data/provider/client_api.dart';
import 'package:get/get.dart';
import 'package:demandium/utils/app_constants.dart';

import '../../address/model/address_model.dart';
import '../../location/controller/location_controller.dart';
import '../../web_landing/widget/web_landing_search_box.dart';

class ServiceDetailsRepo {
  final ApiClient apiClient;
  ServiceDetailsRepo({required this.apiClient});

  Future<Response> getServiceDetails(
      {required String serviceID, String? fromPage, String? placeID}) async {
    AddressModel addressModel = Get.find<LocationController>().getUserAddress()!;
    //lat:addressModel.latitude.toString() ,lng:addressModel.longitude.toString()

    if(fromPage=="search_page"){
      return await apiClient.getData('${AppConstants.serviceDetailsUri}/$serviceID?placeid=$placeID&lat=${addressModel.latitude.toString()}&long=${addressModel.longitude.toString()}');
    }else{
      return await apiClient.getData('${AppConstants.serviceDetailsUri}/$serviceID?placeid=$placeID&lat=${addressModel.latitude.toString()}&long=${addressModel.longitude.toString()}');
    }

  }

  Future<Response> getServiceReviewList(String serviceID,int offset) async {
    return await apiClient.getData('${AppConstants.getServiceReviewList}$serviceID?offset=$offset&limit=10');
  }

}
