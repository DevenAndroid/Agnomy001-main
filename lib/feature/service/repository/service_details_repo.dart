import 'package:demandium/data/provider/client_api.dart';
import 'package:get/get.dart';
import 'package:demandium/utils/app_constants.dart';

class ServiceDetailsRepo {
  final ApiClient apiClient;
  ServiceDetailsRepo({required this.apiClient});

  Future<Response> getServiceDetails(
      {required String serviceID, String? fromPage, String? placeID}) async {


    if(fromPage=="search_page"){
      return await apiClient.getData('${AppConstants.serviceDetailsUri}/$serviceID?placeid=$placeID');
    }else{
      return await apiClient.getData('${AppConstants.serviceDetailsUri}/$serviceID?placeid=$placeID');
    }

  }

  Future<Response> getServiceReviewList(String serviceID,int offset) async {
    return await apiClient.getData('${AppConstants.getServiceReviewList}$serviceID?offset=$offset&limit=10');
  }

}
