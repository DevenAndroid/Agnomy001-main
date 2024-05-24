import 'package:demandium/data/provider/client_api.dart';
import 'package:demandium/feature/review/model/review_body.dart';
import 'package:get/get.dart';
import 'package:demandium/utils/app_constants.dart';

class ServiceRepo extends GetxService {
  final ApiClient apiClient;
  ServiceRepo({required this.apiClient});

  Future<Response> getAllServiceList({required int offset, int? distance , String? placeID}) async {
    return await apiClient.getData('${AppConstants.allServiceUri}?offset=$offset&limit=10&placeid=$placeID&distance=$distance');
  }
  Future<Response> getPopularServiceList({required int offset, int? distance , String? placeID}) async {
    return await apiClient.getData('${AppConstants. popularServiceUri}?offset=$offset&limit=10&placeid=$placeID&distance=$distance');
  }

  Future<Response> getTrendingServiceList({required int offset, int? distance , String? placeID}) async {
    return await apiClient.getData('${AppConstants.trendingServiceUri}?offset=$offset&limit=10&placeid=$placeID&distance=$distance');
  }

  Future<Response> getRecentlyViewedServiceList(int offset) async {
    return await apiClient.getData('${AppConstants.recentlyViewedServiceUri}?offset=$offset&limit=10');
  }

  Future<Response> getFeatheredCategoryServiceList({required int offset, int? distance , String? placeID}) async {
    return await apiClient.getData('${AppConstants.getFeaturedCategoryService}?offset=$offset&limit=10&placeid=$placeID&distance=$distance');
  }

  Future<Response> getRecommendedServiceList({required int offset, int? distance, String? placeID}) async {
    return await apiClient.getData('${AppConstants.recommendedServiceUri}?limit=10&offset=$offset&placeid=$placeID&distance=$distance');
  }

  Future<Response> getRecommendedSearchList() async {
    return await apiClient.getData(AppConstants.recommendedSearchUri);
  }

  Future<Response> getOffersList(int offset) async {
    return await apiClient.getData('${AppConstants.offerListUri}?limit=10&offset=$offset');
  }

  Future<Response> getServiceListBasedOnSubCategory({required String subCategoryID, required int offset}) async {
    return await apiClient.getData('${AppConstants.serviceBasedOnSubcategory}$subCategoryID?limit=30&offset=$offset');
  }
  Future<Response> getItemsBasedOnCampaignId({required String campaignID}) async {
    return await apiClient.getData('${AppConstants.itemsBasedOnCampaignId}$campaignID&limit=100&offset=1');
  }

  Future<Response> submitReview(ReviewBody reviewBody) async {
    return await apiClient.postData(AppConstants.serviceReview, reviewBody.toJson());
  }

}
