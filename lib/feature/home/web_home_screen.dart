import 'package:demandium/feature/home/widget/service_not_availavle.dart';
import 'package:demandium/feature/web_landing/widget/web_landing_search_box.dart';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';


class WebHomeScreen extends StatelessWidget {
  final ScrollController? scrollController;
  final int availableServiceCount;
  const WebHomeScreen({super.key, required this.scrollController, required this.availableServiceCount});

  @override
  Widget build(BuildContext context) {

    Get.find<BannerController>().setCurrentIndex(0, false);
    ConfigModel configModel = Get.find<SplashController>().configModel;

    return CustomScrollView(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: Dimensions.paddingSizeExtraLarge,)),
        SliverToBoxAdapter(
          child: Center(
            child: SizedBox(width: Dimensions.webMaxWidth,
              child: WebBannerView(),
            ),
          ),
        ),
        if(availableServiceCount > 0)
        const SliverToBoxAdapter(child: SizedBox(height: Dimensions.paddingSizeLarge)),
        if(availableServiceCount > 0)
        const SliverToBoxAdapter(child: CategoryView()),
        if(availableServiceCount > 0)
        const SliverToBoxAdapter(
          child: Center(
            child: SizedBox(width: Dimensions.webMaxWidth,
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                WebRecommendedServiceView(),
                SizedBox(width: Dimensions.paddingSizeLarge,),
                Expanded(child: WebPopularServiceView()),
              ],),
            ),
          ),
        ),

        if(availableServiceCount > 0)
        const SliverToBoxAdapter(
          child: SizedBox(height: Dimensions.paddingSizeLarge),
        ),

        if(availableServiceCount > 0)
        SliverToBoxAdapter(
          child: Center(
            child: GetBuilder<ProviderBookingController>(builder: (providerController){
              return SizedBox(
                width: Dimensions.webMaxWidth,
                child: GetBuilder<ServiceController>(
                  builder: (serviceController) {
                    return Row(
                      children:  [
                        if(configModel.content!.biddingStatus == 1)
                          (serviceController.serviceContent != null && serviceController.allService != null && serviceController.allService!.isEmpty) ? const SizedBox() :
                          SizedBox(
                            width: providerController.providerList != null && providerController.providerList!.isNotEmpty && configModel.content?.directProviderBooking==1
                                ? Dimensions.webMaxWidth/3.5 : Dimensions.webMaxWidth,
                            height:  240,
                            child: const HomeCreatePostView(),
                          ),
                        if(configModel.content?.directProviderBooking==1 && configModel.content!.biddingStatus == 1 && providerController.providerList != null && providerController.providerList!.isNotEmpty)
                          const SizedBox(width: Dimensions.paddingSizeLarge+55),
                       if(configModel.content?.directProviderBooking == 1 && serviceController.allService != null && serviceController.allService!.isNotEmpty)
                          Expanded(child: ClipRRect(
                            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                            child: const HomeRecommendProvider()),
                          ),
                      ],
                    );
                  }
                ),
              );
            }),
          ),
        ),
        if(availableServiceCount > 0)
        const SliverToBoxAdapter(child: SizedBox(height: Dimensions.paddingSizeLarge,),),

        if(availableServiceCount > 0)
        const SliverToBoxAdapter(
          child: Center(
            child: SizedBox(width: Dimensions.webMaxWidth,
                child: WebTrendingServiceView()
            ),
          ),
        ),
        if(availableServiceCount > 0)
        const SliverToBoxAdapter(child: SizedBox(height: Dimensions.paddingSizeLarge,),),

        if(Get.find<AuthController>().isLoggedIn() && availableServiceCount > 0)
        const SliverToBoxAdapter(child: Center(
          child: SizedBox(width: Dimensions.webMaxWidth,
            child: WebRecentlyServiceView(),
          ),
        )),

        if(availableServiceCount > 0)
        const SliverToBoxAdapter(child: SizedBox(height: Dimensions.paddingSizeLarge,),),

        if(availableServiceCount > 0)
        const SliverToBoxAdapter(
          child: Center(
            child: SizedBox(
              width: Dimensions.webMaxWidth,
              child: Column(
                children: [
                  SizedBox(height: Dimensions.paddingSizeLarge),
                  WebCampaignView(),
                  SizedBox(height: Dimensions.paddingSizeLarge),
                ],
              ),
            ),
          ),
        ),

        if(availableServiceCount > 0)
        const SliverToBoxAdapter(
          child: Center(
            child: SizedBox(
              width: Dimensions.webMaxWidth,
              child: WebFeatheredCategoryView(),
            ),
          ),
        ),
        if(availableServiceCount > 0)
        const SliverToBoxAdapter(child: SizedBox(height: Dimensions.paddingSizeLarge)),

        if(availableServiceCount > 0)
          SliverToBoxAdapter(child: Center(
            child: SizedBox(
              width: Dimensions.webMaxWidth,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0,
                      Dimensions.paddingSizeDefault,
                      Dimensions.paddingSizeSmall,
                    ),
                    child: TitleWidget(
                      title: 'all_service'.tr,
                    ),
                  ),
                  GetBuilder<ServiceController>(builder: (serviceController) {
                    return PaginatedListView(
                      showBottomSheet: true,
                      scrollController: scrollController!,
                      totalSize: serviceController.serviceContent?.total,
                      offset: serviceController.serviceContent?.currentPage,
                      onPaginate: (int offset) async => await serviceController.getAllServiceList(offset: offset,reload: false,placeId: placedIdGloabal.value,distance:int.parse (serviceController.servicevalue)),
                      itemView: ServiceViewVertical(
                        service: serviceController.serviceContent != null ? serviceController.allService : null,
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeSmall,
                          vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : 0,
                        ),
                        type: 'others',
                        noDataType: NoDataType.home,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),),
        if(availableServiceCount <= 0)
          SliverToBoxAdapter(child: SizedBox( height: MediaQuery.of(context).size.height*.8, child: const ServiceNotAvailableScreen())),

        const SliverToBoxAdapter(child: FooterView(),),
      ],
    );
  }
}
