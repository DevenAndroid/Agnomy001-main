import 'package:demandium/data/provider/client_api.dart';
import 'package:demandium/feature/review/model/review_body.dart';
import 'package:demandium/feature/web_landing/widget/web_landing_search_box.dart';
import 'package:get/get.dart';
import 'package:demandium/utils/app_constants.dart';

import '../../home/widget/category_view.dart';

class ServiceRepo extends GetxService {
  final ApiClient apiClient;
  ServiceRepo({required this.apiClient});

  Future<Response> getAllServiceList({required int offset, int? distance , String? placeID ,required String lat, required String lng}) async {
    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAdistance${distance.toString()}");
    return await apiClient.getData('${AppConstants.allServiceUri}?limit=100&offset=$offset&placeid=$placeID&distance=${distance}&lat=${lat}&long=${lng}');
  }
  Future<Response> getPopularServiceList({required int offset, int? distance , String? placeID,required String lat, required String lng}) async {
    return await apiClient.getData('${AppConstants. popularServiceUri}?limit=100&offset=$offset&limit=10&placeid=$placeID&distance=$distance&lat=${lat}&long=${lng}');
  }

  Future<Response> getTrendingServiceList({required int offset, int? distance , String? placeID,required String lat, required String lng }) async {
    return await apiClient.getData('${AppConstants.trendingServiceUri}?limit=100&offset=$offset&limit=10&placeid=$placeID&distance=$distance&lat=${lat}&long=${lng}');
  }

  Future<Response> getRecentlyViewedServiceList(int offset) async {
    return await apiClient.getData('${AppConstants.recentlyViewedServiceUri}?offset=$offset&limit=10');
  }

  Future<Response> getFeatheredCategoryServiceList(
      {required String placeID, required int distance, required String lat, required String lng}) async {
    return await apiClient.getData('${AppConstants.getFeaturedCategoryService}&placeid=$placeID&distance=$distance&lat=${lat}&long=${lng}');
  }

  Future<Response> getRecommendedServiceList({required int offset, int? distance, String? placeID ,  required String lat, required String lng}) async {
    return await apiClient.getData('${AppConstants.recommendedServiceUri}?limit=100&offset=$offset&placeid=$placeID&distance=$distance&lat=${lat}&long=${lng}');
  }

  Future<Response> getRecommendedSearchList() async {
    return await apiClient.getData(AppConstants.recommendedSearchUri);
  }

  Future<Response> getOffersList(int offset) async {
    return await apiClient.getData('${AppConstants.offerListUri}?limit=10&offset=$offset');
  }

  Future<Response> getServiceListBasedOnSubCategory({required String subCategoryID, required int offset , required String lat, required String lng}) async {
    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA${subCategoryID}");
    return await apiClient.getData('${AppConstants.serviceBasedOnSubcategory}$subCategoryID?limit=30&offset=$offset&placeid=$placedIdGloabal&lat=${lat}&long=${lng}&distance=${int.parse(valueDrop.value)}');
  }
  Future<Response> getItemsBasedOnCampaignId({required String campaignID}) async {
    return await apiClient.getData('${AppConstants.itemsBasedOnCampaignId}$campaignID&limit=100&offset=1');
  }

  Future<Response> submitReview(ReviewBody reviewBody) async {
    return await apiClient.postData(AppConstants.serviceReview, reviewBody.toJson());
  }

}
