import 'package:demandium/feature/home/widget/service_not_availavle.dart';
import 'package:get/get.dart';
import 'package:demandium/components/service_widget_vertical.dart';
import 'package:demandium/components/core_export.dart';

import '../../web_landing/widget/web_landing_search_box.dart';

class AllServiceView extends StatefulWidget {
  final String fromPage;
  final String campaignID;
  const AllServiceView({super.key, required this.fromPage,required this.campaignID});

  @override
  State<AllServiceView> createState() => _AllServiceViewState();
}

class _AllServiceViewState extends State<AllServiceView> {

  final serviceController = Get.put(ServiceController(serviceRepo: ServiceRepo(apiClient:Get.find())));

  int availableServiceCount = 0;
  var servicevalue = '10';



// List of items in our dropdown menu

  var items = [
    '10',
    '20',
    '30',
    '40',
    '50',
  ];

  @override
  void initState() {
    super.initState();
    if(Get.find<LocationController>().getUserAddress() !=null){
      availableServiceCount = Get.find<LocationController>().getUserAddress()!.availableServiceCountInZone!;
    }
  }
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();


    return Scaffold(
      appBar: CustomAppBar(
        title:widget.fromPage == 'allServices' ? 'all_service'.tr
            : widget.fromPage == 'fromRecommendedScreen' ? 'recommended_for_you'.tr
            : widget.fromPage == 'popular_services' ? 'popular_services'.tr
            : widget.fromPage == 'recently_view_services' ? 'recently_view_services'.tr
            : widget.fromPage == 'trending_services' ? 'trending_services'.tr
            : 'available_service'.tr,showCart: true,),
      endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
      body: availableServiceCount> 0 ?  _buildBody(widget.fromPage,context,scrollController) :
      FooterBaseView(
        child: Center(
          child: SizedBox(
            width: Dimensions.webMaxWidth,
            height: MediaQuery.of(context).size.height*.6,
            child: const ServiceNotAvailableScreen(),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(String fromPage,BuildContext context,ScrollController scrollController){
    if(fromPage == 'popular_services') {
      return GetBuilder<ServiceController>(
        initState: (state){
          Get.find<ServiceController>().getPopularServiceList(offset: 1,reload: true);
          Get.find<ServiceController>().getPopularServiceList;
        },
        builder: (serviceController){
          return FooterBaseView(
            scrollController: scrollController,
            child: SizedBox(
              width: Dimensions.webMaxWidth,
              child: Column(
                children: [
                  if(ResponsiveHelper.isDesktop(context))
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      Dimensions.paddingSizeDefault,
                      Dimensions.fontSizeDefault,
                      Dimensions.paddingSizeDefault,
                      Dimensions.paddingSizeSmall,
                    ),
                    child: TitleWidget(
                      title: 'popular_services'.tr,
                    ),
                  ),
                  PaginatedListView(
                    scrollController: scrollController,
                    totalSize: serviceController.popularBasedServiceContent?.total,
                    offset: serviceController.popularBasedServiceContent?.currentPage ,
                    onPaginate: (int offset) async {

                      return await serviceController.getPopularServiceList(offset: offset, reload: false );


                    },
                    itemView: ServiceViewVertical(
                      service: serviceController.popularBasedServiceContent != null ? serviceController.popularServiceList : null,
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeSmall,
                        vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall :  Dimensions.paddingSizeSmall,
                      ),
                      type: 'others',
                      noDataType: NoDataType.home,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
    else if(fromPage == 'trending_services') {
      return GetBuilder<ServiceController>(
        initState: (state){
          Get.find<ServiceController>().getTrendingServiceList(offset: 1,reload: true);
        },
        builder: (serviceController){
          return FooterBaseView(
            scrollController: scrollController,
            child: SizedBox(
              width: Dimensions.webMaxWidth,
              child: Column(
                children: [
                  if(ResponsiveHelper.isDesktop(context))
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        Dimensions.paddingSizeDefault,
                        Dimensions.fontSizeDefault,
                        Dimensions.paddingSizeDefault,
                        Dimensions.paddingSizeSmall,
                      ),
                      child: TitleWidget(
                        title: 'trending_services'.tr,
                      ),
                    ),
                  PaginatedListView(
                    scrollController: scrollController,
                    totalSize: serviceController.trendingServiceContent?.total,
                    offset: serviceController.trendingServiceContent?.currentPage ,
                    onPaginate: (int offset) async {
                      return await serviceController.getTrendingServiceList(offset: offset, reload: false);
                    },
                    itemView: ServiceViewVertical(
                      service: serviceController.trendingServiceContent != null ? serviceController.trendingServiceList : null,
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeSmall,
                        vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall :  Dimensions.paddingSizeSmall,
                      ),
                      type: 'others',
                      noDataType: NoDataType.home,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
    else if(fromPage == 'recently_view_services') {
      return GetBuilder<ServiceController>(
        initState: (state){
          Get.find<ServiceController>().getRecentlyViewedServiceList(1,true);
        },
        builder: (serviceController){
          return FooterBaseView(
            scrollController: scrollController,
            child: SizedBox(
              width: Dimensions.webMaxWidth,
              child: Column(
                children: [
                  if(ResponsiveHelper.isDesktop(context))
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        Dimensions.paddingSizeDefault,
                        Dimensions.fontSizeDefault,
                        Dimensions.paddingSizeDefault,
                        Dimensions.paddingSizeSmall,
                      ),
                      child: TitleWidget(
                        title: 'recently_view_services'.tr,
                      ),
                    ),
                  PaginatedListView(
                    scrollController: scrollController,
                    totalSize: serviceController.recentlyViewServiceContent?.total,
                    offset: serviceController.recentlyViewServiceContent?.currentPage,
                    onPaginate: (int offset) async {
                      return await serviceController.getRecentlyViewedServiceList(offset, false);
                    },
                    itemView: ServiceViewVertical(
                      service: serviceController.recentlyViewServiceContent != null ? serviceController.recentlyViewServiceList : null,
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeSmall,
                        vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall :  Dimensions.paddingSizeSmall,
                      ),
                      type: 'others',
                      noDataType: NoDataType.home,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
    else if(fromPage == 'fromCampaign') {
      return GetBuilder<ServiceController>(
        initState: (state){

          Get.find<ServiceController>().getEmptyCampaignService();
          Get.find<ServiceController>().getCampaignBasedServiceList(widget.campaignID,true);
        },
        builder: (serviceController){
          return _buildWidget(serviceController.campaignBasedServiceList,context);
        },
      );
    }
    else if(fromPage == 'fromRecommendedScreen'){
      return GetBuilder<ServiceController>(
        initState: (state){
          Get.find<ServiceController>().getRecommendedServiceList(offset: 1,reload: true);
        },
        builder: (serviceController){
          return FooterBaseView(
            scrollController: scrollController,
            child: SizedBox(
              width: Dimensions.webMaxWidth,
              child: Column(
                children: [
                  if(ResponsiveHelper.isDesktop(context))
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      Dimensions.paddingSizeDefault,
                      Dimensions.fontSizeDefault,
                      Dimensions.paddingSizeDefault,
                      Dimensions.paddingSizeSmall,
                    ),
                    child: TitleWidget(
                      title: 'recommended_for_you'.tr,
                    ),
                  ),
                  PaginatedListView(
                    scrollController: scrollController,
                    totalSize: serviceController.recommendedBasedServiceContent?.total,
                    offset:  serviceController.recommendedBasedServiceContent?.currentPage,
                    onPaginate: (int offset) async {
                      return await serviceController.getRecommendedServiceList(offset: offset, reload: false,placeId: placedIdGloabal.value,distance: int.parse(serviceController.dropdownvalue));
                    },
                    itemView: ServiceViewVertical(
                      service: serviceController.recommendedBasedServiceContent != null ? serviceController.recommendedServiceList : null,
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeSmall,
                        vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall :  Dimensions.paddingSizeSmall,
                      ),
                      type: 'others',
                      noDataType: NoDataType.home,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
    else if(fromPage == 'all_service'){
      return GetBuilder<ServiceController>(
          initState: (state){
            Get.find<ServiceController>().getAllServiceList(offset: 1,reload: true,placeId: placedIdGloabal.value,distance: int.parse(serviceController.servicevalue));
          },
          builder: (serviceController) {
        return FooterBaseView(
          scrollController: scrollController,
          child: SizedBox(
            width: Dimensions.webMaxWidth,
            child: Column(
              children: [
                if(ResponsiveHelper.isDesktop(context))
                  Padding(
                  padding: const EdgeInsets.fromLTRB(
                    Dimensions.paddingSizeDefault,
                    Dimensions.paddingSizeDefault,
                    Dimensions.paddingSizeDefault,
                    Dimensions.paddingSizeSmall,
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TitleWidget(
                        title: 'all_service'.tr,
                      ),
                      DropdownButton(
                        // Initial Value
                        value: serviceController.servicevalue,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: serviceController.serviceItem.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            serviceController.servicevalue = newValue!;
                            Get.find<ServiceController>().getAllServiceList(offset: 1,reload: true,placeId: placedIdGloabal.value,distance: int.parse(serviceController.servicevalue));

                            // String largestValue = getLargestValue(dropdownvalue).toString();
                            // print('Largest value: $largestValue');
                            // dropValue.value = servicevalue;
                           });
                        },
                      ),
                    ],
                  ),

                ),
                const SizedBox(height: Dimensions.paddingSizeDefault,),
                PaginatedListView(
                  scrollController: scrollController,
                  totalSize: serviceController.serviceContent?.total,
                  offset:  serviceController.serviceContent?.currentPage,
                  onPaginate: (int offset) async => await serviceController.getAllServiceList(offset: offset,reload:  false,placeId: placedIdGloabal.value,distance: int.parse(serviceController.servicevalue)),
                  itemView: ServiceViewVertical(
                    service: serviceController.serviceContent != null ? serviceController.allService : null,
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeSmall,
                      vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : 0,
                    ),
                    type: 'others',
                    noDataType: NoDataType.home,
                  ),
                ),

              ],
            ),
          ),
        );
      });
    }
    else{
      return GetBuilder<ServiceController>(
        initState: (state){
          Get.find<ServiceController>().getSubCategoryBasedServiceList(fromPage,false,isShouldUpdate: true);
        },
        builder: (serviceController){
          return _buildWidget(serviceController.subCategoryBasedServiceList ,context);
        },
      );
    }
  }

  Widget _buildWidget(List<Service>? serviceList,BuildContext context){
    return FooterBaseView(
      isCenter:(serviceList == null || serviceList.isEmpty),
      child: SizedBox(
        width: Dimensions.webMaxWidth,
        child: (serviceList != null && serviceList.isEmpty) ?  NoDataScreen(text: 'no_services_found'.tr,type: NoDataType.service,) :  serviceList != null ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeDefault),
          child: CustomScrollView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              if(ResponsiveHelper.isWeb())
              const SliverToBoxAdapter(child: SizedBox(height: Dimensions.paddingSizeExtraMoreLarge,)),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: Dimensions.paddingSizeDefault,
                  mainAxisSpacing:  Dimensions.paddingSizeDefault,
                  childAspectRatio: ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTab(context)  ? .9 : .75,
                  crossAxisCount: ResponsiveHelper.isMobile(context) ? 2 : ResponsiveHelper.isTab(context) ? 3 : 5,
                  mainAxisExtent: 240,
                ),
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    Get.find<ServiceController>().getServiceDiscount(serviceList[index]);
                    return ServiceWidgetVertical(service: serviceList[index],  isAvailable: true,fromType: widget.fromPage,);
                  },
                  childCount: serviceList.length,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: Dimensions.webCategorySize,)),
            ],
          ),
        ) : GridView.builder(
          key: UniqueKey(),
          padding: const EdgeInsets.only(
            top: Dimensions.paddingSizeDefault,
            bottom: Dimensions.paddingSizeDefault,
            left: Dimensions.paddingSizeDefault,
            right: Dimensions.paddingSizeDefault,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: Dimensions.paddingSizeDefault,
            mainAxisSpacing:  Dimensions.paddingSizeDefault,
            childAspectRatio: ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTab(context)  ? 1 : .70,
            crossAxisCount: ResponsiveHelper.isMobile(context) ? 2 : ResponsiveHelper.isTab(context) ? 3 : 5,
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) {
            return const ServiceShimmer(isEnabled: true, hasDivider: false);
          },
        ),
      ),
    );
  }
}

