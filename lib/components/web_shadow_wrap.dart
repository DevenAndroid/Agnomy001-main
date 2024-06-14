import 'package:demandium/components/rating_bar.dart';
import 'package:demandium/components/service_center_dialog.dart';
import 'package:demandium/feature/service/model/service_model.dart';
import 'package:flutter/material.dart';
import 'package:demandium/core/helper/responsive_helper.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:get/get.dart';
import '../core/helper/decorated_tab_bar.dart';
import '../core/helper/price_converter.dart';
import '../feature/cart/controller/cart_controller.dart';
import '../feature/coupon/model/coupon_model.dart';
import '../feature/root/view/no_data_screen.dart';
import '../feature/service/controller/service_controller.dart';
import '../feature/service/controller/service_details_controller.dart';
import '../feature/service/controller/service_details_tab_controller.dart';
import '../feature/service/view/service_details_screen.dart';
import '../feature/service/widget/empty_review_widget.dart';
import '../feature/service/widget/service_details_faq_section.dart';
import '../feature/service/widget/service_details_review.dart';
import '../feature/service/widget/service_details_shimmer_widget.dart';
import '../feature/service/widget/service_info_card.dart';
import '../feature/service/widget/service_overview.dart';
import '../feature/splash/controller/splash_controller.dart';
import '../feature/web_landing/widget/web_landing_search_box.dart';
import '../utils/gaps.dart';
import '../utils/styles.dart';
import 'custom_image.dart';
import 'footer_base_view.dart';

class WebShadowWrap extends StatefulWidget {
  final Widget child;
  final double? width;
  final double? maxHeight;
  final double? minHeight;

  const WebShadowWrap({Key? key, required this.child, this.width = Dimensions.webMaxWidth, this.maxHeight, this.minHeight}) : super(key: key);

  @override
  State<WebShadowWrap> createState() => _WebShadowWrapState();
}

class _WebShadowWrapState extends State<WebShadowWrap> {
  final ScrollController scrollController = ScrollController();
  final scaffoldState = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        int pageSize = Get.find<ServiceTabController>().pageSize??0;
        if (Get.find<ServiceTabController>().offset! < pageSize) {
          Get.find<ServiceTabController>().getServiceReview(serviceID.value, Get.find<ServiceTabController>().offset!+1);
        }}
    });
    Get.find<ServiceController>().getRecentlyViewedServiceList(1,true,);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return ResponsiveHelper.isDesktop(context) ? Padding(
      padding: ResponsiveHelper.isMobile(context) ? EdgeInsets.zero : const EdgeInsets.symmetric(
        vertical: Dimensions.paddingSizeLarge, horizontal: Dimensions.paddingSizeExtraSmall,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                minHeight: widget.minHeight ?? MediaQuery.of(context).size.height * 0.4 ,
                maxHeight: widget.maxHeight !=null ? widget.maxHeight! : double.infinity,
              ),
              padding: !ResponsiveHelper.isMobile(context) ? const EdgeInsets.all(Dimensions.paddingSizeDefault) : null,
              decoration: !ResponsiveHelper.isMobile(context) ? BoxDecoration(
                color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(
                  offset: const Offset(1, 1),
                  blurRadius: 5,
                  color: Theme.of(context).primaryColor.withOpacity(0.12),
                )],
              ) : null,
              width: widget.width,
              child: widget.child,
            ),

            // SizedBox(height: MediaQuery.of(context).size.height*0.02),
            // Padding(
            //   padding: const EdgeInsets.symmetric(
            //       horizontal: Dimensions.paddingSizeDefault,
            //       vertical: Dimensions.paddingSizeEight),
            //   child: Text(
            //     "Service Provider in your area:",
            //     style: ubuntuRegular.copyWith(
            //         fontSize: Dimensions.fontSizeExtraLarge, color: Colors.black),
            //   ),
            // ),
            // const SizedBox(height: 20,),
            //
            //
            // GetBuilder<ServiceDetailsController>(
            //   initState: (state) {
            //
            //   },
            //
            //   builder: (serviceController) {
            //     if(serviceController.service != null){
            //       if(serviceController.service!.id != null){
            //         Service? service = serviceController.service;
            //         Discount discount = PriceConverter.discountCalculation(service! );
            //         double lowestPrice = 0.0;
            //         if(service.variationsAppFormat!.zoneWiseVariations != null){
            //           lowestPrice = service.variationsAppFormat!.zoneWiseVariations![0].price!.toDouble();
            //           for (var i = 0; i < service.variationsAppFormat!.zoneWiseVariations!.length; i++) {
            //             if (service.variationsAppFormat!.zoneWiseVariations![i].price! < lowestPrice) {
            //               lowestPrice = service.variationsAppFormat!.zoneWiseVariations![i].price!.toDouble();
            //             }
            //           }
            //         }
            //         return  SizedBox(
            //           width: Dimensions.webMaxWidth,
            //           child: DefaultTabController(
            //             length: Get.find<ServiceDetailsController>().service!.faqs!.isNotEmpty ? 3 :2,
            //             child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 if(!ResponsiveHelper.isMobile(context) && !ResponsiveHelper.isTab(context))
            //                   const SizedBox(height: Dimensions.paddingSizeDefault,),
            //
            //                 //Tab Bar View
            //                 GetBuilder<ServiceTabController>(
            //                   initState: (state){
            //                     Get.find<ServiceTabController>().getServiceReview(serviceController.service!.id!,1);
            //                   },
            //                   builder: (controller){
            //                     return
            //                       GridView.builder(
            //                       shrinkWrap: true,
            //                       scrollDirection: Axis.vertical, // Change this to Axis.horizontal if you want horizontal scrolling
            //                       itemCount:service.providers!.length,
            //                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //                         crossAxisCount: 3,
            //                         mainAxisSpacing: 10.0,
            //                         crossAxisSpacing: 10.0,
            //                         childAspectRatio: 6 / 2,
            //                       ),
            //                       itemBuilder: (context, index) {
            //                         return Container(
            //                           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            //                           decoration: BoxDecoration(
            //                             borderRadius: const BorderRadius.all(Radius.circular(10)),
            //                             border: Border.all(color: Colors.grey),
            //                           ),
            //                           child: Column(
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             mainAxisAlignment: MainAxisAlignment.start,
            //                             children: [
            //                               Row(
            //                                 mainAxisAlignment: MainAxisAlignment.start,
            //                                 crossAxisAlignment: CrossAxisAlignment.start,
            //                                 children: [
            //                                   CircleAvatar(
            //                                     minRadius:10,
            //                                     child: Container(
            //                                       width:30,
            //                                       color: Colors.transparent,
            //                                       child: ClipRRect(
            //                                         borderRadius: BorderRadius.circular(50),
            //                                         child: Image(
            //                                           image: NetworkImage(
            //                                               "${Get.find<SplashController>().configModel.content!.imageBaseUrl}/provider/logo/${service.providers![index].logo.toString()}"
            //                                           ),
            //                                           height: 30,
            //                                           width:30,fit: BoxFit.cover,
            //                                         ),
            //                                       ),
            //                                     ),
            //                                   ),
            //                                   const SizedBox(width: 20),
            //                                   Column(
            //                                     crossAxisAlignment: CrossAxisAlignment.start,
            //                                     children: [
            //                                       Text(service.providers![index].companyName.toString()),
            //                                       Row(
            //                                         crossAxisAlignment: CrossAxisAlignment.start,
            //                                         mainAxisAlignment: MainAxisAlignment.start,
            //                                         children: [
            //                                           RatingBar(rating: service.providers![index].avgRating),
            //                                           Gaps.horizontalGapOf(5),
            //                                           Directionality(
            //                                             textDirection: TextDirection.ltr,
            //                                             child:  Text('${service.providers![index].ratingCount} ${'reviews'.tr}', style: ubuntuRegular.copyWith(
            //                                               fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).secondaryHeaderColor,
            //                                             )),
            //                                           ),
            //                                           // const Text("0 Reviews"),
            //                                         ],
            //                                       ),
            //                                       SizedBox(
            //                                         width: Get.width*0.176,
            //                                         child: Text(service.providers![index].companyDescription.toString(),
            //                                           style: ubuntuRegular.copyWith(
            //                                             overflow:TextOverflow.ellipsis,
            //                                             fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).secondaryHeaderColor,
            //                                           ),textAlign: TextAlign.start,maxLines:1,softWrap: true,overflow: TextOverflow.ellipsis,
            //                                         ),
            //                                       )// width: Get.width*0.2,
            //                                     ],
            //                                   ),
            //                                 ],
            //                               ),
            //                               Gaps.horizontalGapOf(6),
            //                               Row(
            //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                                 children: [
            //                                   Text("with in ${service.providers![index].distance!.toInt()} miles"),
            //
            //                                   ElevatedButton(
            //                                     onPressed: () {
            //                                       var providerid= service.providers![index].id.toString();
            //                                       print("ankur=>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${service.providers![index].id.toString()}");
            //                                       Get.find<CartController>().resetPreselectedProviderInfo();
            //                                       showModalBottomSheet(
            //                                           context: context,
            //                                           useRootNavigator: true,
            //                                           isScrollControlled: true,
            //                                           backgroundColor: Colors.transparent,
            //                                           builder: (context) => ServiceCenterDialog(
            //                                             service: service, isFromDetails: true,
            //                                             providerId: service.providers![index].distance!.toInt(),
            //                                             logoImage:"${Get.find<SplashController>().configModel.content!.imageBaseUrl}/provider/logo/${service.providers![index].logo.toString()}",
            //                                           )
            //                                       );
            //                                     },
            //                                     child: Text('${"Quote".tr}',style: ubuntuRegular.copyWith(color: Colors.white),),
            //                                   ),
            //                                 ],
            //                               ),
            //                             ],
            //                           ),
            //                         );
            //                       },
            //                     );
            //
            //
            //                   },
            //                 ),
            //
            //               ],
            //             ),
            //           ),
            //         );
            //       }else{
            //         return NoDataScreen(text: 'no_service_available'.tr,type: NoDataType.service,);
            //       }
            //     }else{
            //       return const ServiceDetailsShimmerWidget();
            //     }
            //
            //   },
            // ),


          ],
        ),
      ),
    ) : widget.child;
  }
}