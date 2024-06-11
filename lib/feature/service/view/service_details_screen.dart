import 'package:demandium/feature/service/widget/service_details_faq_section.dart';
import 'package:demandium/feature/service/widget/service_details_shimmer_widget.dart';
import 'package:demandium/feature/service/widget/service_info_card.dart';
import 'package:demandium/feature/service/widget/service_overview.dart';
import 'package:demandium/feature/web_landing/widget/web_landing_search_box.dart';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';
import 'package:demandium/core/helper/decorated_tab_bar.dart';

import '../../../components/service_center_dialog.dart';



class ServiceDetailsScreen extends StatefulWidget {
  final String serviceID;
  final String fromPage;
  const ServiceDetailsScreen({Key? key, required this.serviceID,this.fromPage="others"}) : super(key: key);

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  final ScrollController scrollController = ScrollController();
  final scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        int pageSize = Get.find<ServiceTabController>().pageSize??0;
        if (Get.find<ServiceTabController>().offset! < pageSize) {
          Get.find<ServiceTabController>().getServiceReview(widget.serviceID, Get.find<ServiceTabController>().offset!+1);
        }}
    });
    Get.find<ServiceController>().getRecentlyViewedServiceList(1,true,);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
      appBar: CustomAppBar(centerTitle: false, title: 'service_details'.tr,showCart: true,),
      body: GetBuilder<ServiceDetailsController>(
        initState: (state) {
          if (widget.fromPage == "search_page") {
            Get.find<ServiceDetailsController>().getServiceDetails(
                widget.serviceID,placedIdGloabal.value,fromPage: "search_page");
          } else {
            Get.find<ServiceDetailsController>().getServiceDetails(
                widget.serviceID,placedIdGloabal.value);
          }
        },

        builder: (serviceController) {
          if(serviceController.service != null){
            if(serviceController.service!.id != null){
              Service? service = serviceController.service;
              Discount discount = PriceConverter.discountCalculation(service!);
              double lowestPrice = 0.0;
              if(service.variationsAppFormat!.zoneWiseVariations != null){
                lowestPrice = service.variationsAppFormat!.zoneWiseVariations![0].price!.toDouble();
                for (var i = 0; i < service.variationsAppFormat!.zoneWiseVariations!.length; i++) {
                  if (service.variationsAppFormat!.zoneWiseVariations![i].price! < lowestPrice) {
                    lowestPrice = service.variationsAppFormat!.zoneWiseVariations![i].price!.toDouble();
                  }
                }
              }
              return  FooterBaseView(
                isScrollView:ResponsiveHelper.isMobile(context) ? false: true,
                child: SizedBox(
                  width: Dimensions.webMaxWidth,
                  child: DefaultTabController(
                    length: Get.find<ServiceDetailsController>().service!.faqs!.isNotEmpty ? 3 :2,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(!ResponsiveHelper.isMobile(context) && !ResponsiveHelper.isTab(context))
                        const SizedBox(height: Dimensions.paddingSizeDefault,),
                        Stack(
                          children: [
                            Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.all((!ResponsiveHelper.isMobile(context) && !ResponsiveHelper.isTab(context)) ?  const Radius.circular(8): const Radius.circular(0.0)),
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: SizedBox(
                                          width: Dimensions.webMaxWidth,
                                          height: ResponsiveHelper.isDesktop(context) ? 280:150,
                                          child: CustomImage(
                                            image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/service/${service.coverImage}',
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          width: Dimensions.webMaxWidth,
                                          height: ResponsiveHelper.isDesktop(context) ? 280:150,
                                          decoration: BoxDecoration(
                                              color: Colors.black.withOpacity(0.6)
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: Dimensions.webMaxWidth,
                                        height: ResponsiveHelper.isDesktop(context) ? 280:150,
                                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                        child: Center(child: Text(
                                            service.name ?? '',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.white))),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 120,)
                              ],
                            ),
                            Positioned(
                              bottom: -2,
                                left: Dimensions.paddingSizeSmall,
                                right: Dimensions.paddingSizeSmall,
                                child: ServiceInformationCard(discount: discount,service: service,lowestPrice: lowestPrice)),
                          ],
                        ),
                        //Tab Bar
                        GetBuilder<ServiceTabController>(
                          init: Get.find<ServiceTabController>(),
                          builder: (serviceTabController) {
                            return Container(
                              color:Theme.of(context).scaffoldBackgroundColor,
                              child: Center(
                                child: Container(
                                  width: ResponsiveHelper.isMobile(context) ?null : Get.width / 3,
                                  color: Get.isDarkMode?Theme.of(context).scaffoldBackgroundColor:Theme.of(context).cardColor,
                                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                                  child: DecoratedTabBar(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Theme.of(context).colorScheme.primary.withOpacity(.3),
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    tabBar: TabBar(
                                        padding: const EdgeInsets.only(top: Dimensions.paddingSizeMini),
                                        unselectedLabelColor: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.4),
                                        controller: serviceTabController.controller!,
                                        labelColor:Get.isDarkMode? Colors.white : Theme.of(context).primaryColor,
                                        labelStyle: ubuntuBold.copyWith(
                                          fontSize: Dimensions.fontSizeSmall,
                                        ),
                                        indicatorColor: Theme.of(context).colorScheme.primary,
                                        indicatorPadding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                                        labelPadding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
                                        indicatorWeight: 2,
                                        onTap: (int? index) {
                                          switch (index) {
                                            case 0:
                                              serviceTabController.updateServicePageCurrentState(ServiceTabControllerState.serviceOverview);
                                              break;
                                            case 1:
                                              serviceTabController.serviceDetailsTabs().length > 2 ?
                                              serviceTabController.updateServicePageCurrentState(ServiceTabControllerState.faq):
                                              serviceTabController.updateServicePageCurrentState(ServiceTabControllerState.review);
                                              break;
                                            case 2:
                                              serviceTabController.updateServicePageCurrentState(ServiceTabControllerState.review);
                                              break;
                                          }
                                        },
                                        tabs: serviceTabController.serviceDetailsTabs()
                                    ),


                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        //Tab Bar View
                        GetBuilder<ServiceTabController>(
                          initState: (state){
                            Get.find<ServiceTabController>().getServiceReview(serviceController.service!.id!,1);
                          },
                          builder: (controller){
                            Widget tabBarView = TabBarView(
                              controller: controller.controller,
                              children: [
                                SingleChildScrollView(child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ServiceOverview(
                                      description:service.description!,
                                        providers:service.providers!,
                                      variations: service.variations!,
                                      service: service,),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: Dimensions.paddingSizeDefault,
                                          vertical: Dimensions.paddingSizeEight),
                                      child: Text(
                                        "Service Provider in your area:",
                                        style: ubuntuRegular.copyWith(
                                            fontSize: Dimensions.fontSizeExtraLarge, color: Colors.black),
                                      ),
                                    ), const SizedBox(height: 20,),

                                    GridView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical, // Change this to Axis.horizontal if you want horizontal scrolling
                                      itemCount:service.providers!.length,
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 10.0,
                                        crossAxisSpacing: 10.0,
                                        childAspectRatio: 6 / 2,
                                      ),
                                      itemBuilder: (context, index) {
                                        return Container(
                                          // height: 10,
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                                            border: Border.all(color: Colors.grey),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    // height: 20,
                                                    // width: 25,
                                                    child: Image(
                                                      image: NetworkImage(
                                                          "${Get.find<SplashController>().configModel.content!.imageBaseUrl}/provider/logo/${service.providers![index].logo.toString()}"
                                                      ),
                                                      height: 30,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 20),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(service.providers![index].companyName.toString()),
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          RatingBar(rating: service.providers![index].avgRating),
                                                          Gaps.horizontalGapOf(5),
                                                          Directionality(
                                                            textDirection: TextDirection.ltr,
                                                            child:  Text('${service.providers![index].ratingCount} ${'reviews'.tr}', style: ubuntuRegular.copyWith(
                                                              fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).secondaryHeaderColor,
                                                            )),
                                                          ),
                                                          // const Text("0 Reviews"),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: Get.width*0.178,
                                                        child: Text(service.providers![index].companyDescription.toString(),
                                                          style: ubuntuRegular.copyWith(
                                                            overflow:TextOverflow.ellipsis,
                                                            fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).secondaryHeaderColor,
                                                          ),textAlign: TextAlign.start,maxLines:1,softWrap: true,overflow: TextOverflow.ellipsis,
                                                        ),
                                                      )// width: Get.width*0.2,
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Gaps.horizontalGapOf(6),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("with in ${service.providers![index].distance!.toInt()} miles"),

                                                  ElevatedButton(
                                                    onPressed: () {
                                                      var providerid= service.providers![index].id.toString();
                                                      print("ankur=>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${service.providers![index].id.toString()}");
                                                      Get.find<CartController>().resetPreselectedProviderInfo();
                                                      showModalBottomSheet(
                                                          context: context,
                                                          useRootNavigator: true,
                                                          isScrollControlled: true,
                                                          backgroundColor: Colors.transparent,
                                                          builder: (context) => ServiceCenterDialog(
                                                            service: service, isFromDetails: true,
                                                            providerId: service.providers![index].distance!.toInt(),
                                                            logoImage:"${Get.find<SplashController>().configModel.content!.imageBaseUrl}/provider/logo/${service.providers![index].logo.toString()}",
                                                          )
                                                      );
                                                    },
                                                    child: Text('${"Quote".tr}',style: ubuntuRegular.copyWith(color: Colors.white),),
                                                  ),
                                                  /*
                          SizedBox(
                            height: 30,
                            child:  GetBuilder<CartController>(builder: (cartControllerInit) {
                              return GetBuilder<CartController>(
                                  builder: (cartController) {
                                    bool addToCart = true;
                                    return cartController.isLoading
                                        ? const Center(
                                        child: CircularProgressIndicator())
                                        : ElevatedButton(
                                      onPressed: () {
                                        print("ADD CARD1");

                                        if(Get.find<SplashController>().configModel.content?.biddingStatus==1);

                                        cartController.updateQuantity(index, true);
                                        cartController.showMinimumAndMaximumOrderValueToaster();

                                          if (addToCart) {
                                            addToCart = false;
                                             cartController.addMultipleCartToServer();
                                             cartController.getCartListFromServer(shouldUpdate: true);
                                          }

                                        print("ADD CARD");
                                      },
                                      child:

                                    Text('${"add".tr} +',style: ubuntuRegular.copyWith(color: Colors.white),
                                    )
                                    );
                                  }
                              );
                            }
                          ),
                          )

                       */


                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    
                                    
                                  ],
                                )),

                                if(Get.find<ServiceDetailsController>().service!.faqs!.isNotEmpty)
                                  const SingleChildScrollView(child: ServiceDetailsFaqSection()),
                                if(controller.reviewList != null)
                                  SingleChildScrollView(
                                    child: ServiceDetailsReview(
                                      serviceID: serviceController.service!.id!,
                                      reviewList: controller.reviewList!, rating : controller.rating,),
                                  )
                                else
                                  const EmptyReviewWidget()
                              ],
                              
                            );

                            if(ResponsiveHelper.isMobile(context)){
                              return Expanded(
                                child: tabBarView,
                              );
                            }else{
                              return SizedBox(
                                height: 500,
                                child: tabBarView,);
                            }
                          },
                        ),

                      ],
                    ),
                  ),
                ),
              );
            }else{
              return NoDataScreen(text: 'no_service_available'.tr,type: NoDataType.service,);
            }
          }else{
            return const ServiceDetailsShimmerWidget();
          }

        },
      ),
    );
  }
}

