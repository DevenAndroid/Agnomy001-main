import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:demandium/components/ripple_button.dart';
import 'package:demandium/components/service_center_dialog.dart';
import 'package:demandium/components/core_export.dart';

import '../feature/web_landing/widget/web_landing_search_box.dart';

class ServiceWidgetVertical extends StatelessWidget {


  final Service service;
  final bool isAvailable;
  final String fromType;
  final String fromPage;


  const ServiceWidgetVertical(
      {Key? key,
      required this.service,
      required this.isAvailable,

      required this.fromType,
      this.fromPage = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String distancesToShow = '';

    if (service.providers != null) {
      service.providers!.forEach((element) {
        if (element.distance! > (service.providers!.map((e) => e.distance!).reduce((value, element) => value > element! ? value : element))) {
          distancesToShow += '${element.distance.toString()}, ';
        }
      });
    }




    //log("provider:::::::"+service.providers![0].distance.toString());
    //
    // Rx<ServiceModel> model = ServiceModel().obs;
    //
    // var largestGeekValue = model.value.content!.serviceList[].providers[].distance;
    num lowestPrice = 0.0;

    if (fromType == 'fromCampaign') {
      if (service.variations != null) {
        lowestPrice = service.variations![0].price!;
        for (var i = 0; i < service.variations!.length; i++) {
          if (service.variations![i].price! < lowestPrice) {
            lowestPrice = service.variations![i].price!;
          }
        }
      }
    } else {
      if (service.variationsAppFormat != null) {
        if (service.variationsAppFormat!.zoneWiseVariations != null) {
          lowestPrice =
              service.variationsAppFormat!.zoneWiseVariations![0].price!;
          for (var i = 0;
              i < service.variationsAppFormat!.zoneWiseVariations!.length;
              i++) {
            if (service.variationsAppFormat!.zoneWiseVariations![i].price! <
                lowestPrice) {
              lowestPrice =
                  service.variationsAppFormat!.zoneWiseVariations![i].price!;
            }
          }
        }
      }
    }

    Discount discountModel = PriceConverter.discountCalculation(service);

    return
      Stack(
      alignment: Alignment.bottomRight,
      children: [
        Stack(
          children: [
             Container(
              decoration: BoxDecoration(
                 color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                boxShadow: Get.isDarkMode ? null : cardShadow2,
              ),
              child:  Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //cover image and service name

                    Column(
                      children: [
                        Stack(
                          children: [
                               ClipRRect(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(Dimensions.radiusSmall)),

                              child: CustomImage(
                                image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/service/${service.thumbnail}',
                                fit: BoxFit.cover,
                                width: double.maxFinite,
                                height: Dimensions.homeImageSize,
                              ),
                            ),
                            discountModel.discountAmount! > 0
                                ? Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      padding: const EdgeInsets.all(
                                          Dimensions.paddingSizeExtraSmall),
                                      decoration: BoxDecoration(
                                        color:
                                            Theme.of(context).colorScheme.error,
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(
                                              Dimensions.radiusDefault),
                                          topRight: Radius.circular(
                                              Dimensions.radiusSmall),
                                        ),
                                      ),
                                      child: Text(
                                        PriceConverter.percentageOrAmount(
                                            '${discountModel.discountAmount}',
                                            '${discountModel.discountAmountType}'),
                                        style: ubuntuRegular.copyWith(
                                            color: Theme.of(context)
                                                .primaryColorLight),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        const SizedBox(
                          height: Dimensions.paddingSizeEight,
                        ),
                          Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.paddingSizeExtraSmall),
                          child: Text(
                            service.name!,
                            style: ubuntuMedium.copyWith(
                                fontSize: Dimensions.fontSizeSmall),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    // if( fromPage == 'fromRecommendedScreen')
                    //   Expanded(
                    //     child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //
                    //
                    //               Text(
                    //                 'Service ${service.providerCount.toString()} Provider'.tr,
                    //                 style: ubuntuRegular.copyWith(
                    //                     fontSize: Dimensions.fontSizeExtraSmall,
                    //                     color: Theme.of(context)
                    //                         .textTheme
                    //                         .bodyLarge!
                    //                         .color!
                    //                         .withOpacity(.6)),
                    //               ),
                    //
                    //
                    //               service.maxDistanceProvider!=null&&service.maxDistanceProvider!=""?
                    //
                    //               Text(
                    //
                    //                 "Within ${service.maxDistanceProvider!.ceil().toString()} Miles",
                    //                 style: ubuntuRegular.copyWith(
                    //                     fontSize: Dimensions.fontSizeExtraSmall,
                    //                     color: Theme.of(context).colorScheme.primary),
                    //               ):   Text(
                    //
                    //                 "Within 0 Miles",
                    //                 style: ubuntuRegular.copyWith(
                    //                     fontSize: Dimensions.fontSizeExtraSmall,
                    //                     color: Theme.of(context).colorScheme.primary),
                    //               ),
                    //               // Column(
                    //               //   crossAxisAlignment: CrossAxisAlignment.start,
                    //               //   children: [
                    //               //     if(discountModel.discountAmount! > 0)
                    //               //       Directionality(
                    //               //         textDirection: TextDirection.ltr,
                    //               //         child: Text(
                    //               //           PriceConverter.convertPrice(lowestPrice.toDouble()),
                    //               //           maxLines: 2,
                    //               //           style: ubuntuRegular.copyWith(
                    //               //               fontSize: Dimensions.fontSizeSmall,
                    //               //               decoration: TextDecoration.lineThrough,
                    //               //               color: Theme.of(context).colorScheme.error.withOpacity(.8)),),
                    //               //       ),
                    //               //     discountModel.discountAmount! > 0?
                    //               //     Directionality(
                    //               //       textDirection: TextDirection.ltr,
                    //               //       child: Text(
                    //               //         PriceConverter.convertPrice(
                    //               //             lowestPrice.toDouble(),
                    //               //             discount: discountModel.discountAmount!.toDouble(),
                    //               //             discountType: discountModel.discountAmountType),
                    //               //         style: ubuntuMedium.copyWith(
                    //               //             fontSize: Dimensions.paddingSizeDefault,
                    //               //             color:  Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor),
                    //               //       ),
                    //               //     ):
                    //               //     Directionality(
                    //               //       textDirection: TextDirection.ltr,
                    //               //       child: Text(
                    //               //         PriceConverter.convertPrice(lowestPrice.toDouble()),
                    //               //         style: ubuntuMedium.copyWith(
                    //               //             fontSize:Dimensions.fontSizeDefault,
                    //               //             color: Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor),
                    //               //       ),
                    //               //     ),
                    //               //   ],
                    //               // ),
                    //             ]),
                    //       ],
                    //     ),
                    //   ),
                   if( fromPage == 'popular_services')
                    Expanded(
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [


                                Text(
                                  'Service ${service.providerCount.toString()} Provider'.tr,
                                  style: ubuntuRegular.copyWith(
                                      fontSize: Dimensions.fontSizeExtraSmall,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color!
                                          .withOpacity(.6)),
                                ),


                                service.maxDistanceProvider!=null&&service.maxDistanceProvider!=""?

                                Text(
                                  
                                  "Within ${service.maxDistanceProvider!.ceil().toString()} Miles",
                                  style: ubuntuRegular.copyWith(
                                      fontSize: Dimensions.fontSizeExtraSmall,
                                      color: Theme.of(context).colorScheme.primary),
                                ):   Text(

                                  "Within 0 Miles",
                                  style: ubuntuRegular.copyWith(
                                      fontSize: Dimensions.fontSizeExtraSmall,
                                      color: Theme.of(context).colorScheme.primary),
                                ),
                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     if(discountModel.discountAmount! > 0)
                                //       Directionality(
                                //         textDirection: TextDirection.ltr,
                                //         child: Text(
                                //           PriceConverter.convertPrice(lowestPrice.toDouble()),
                                //           maxLines: 2,
                                //           style: ubuntuRegular.copyWith(
                                //               fontSize: Dimensions.fontSizeSmall,
                                //               decoration: TextDecoration.lineThrough,
                                //               color: Theme.of(context).colorScheme.error.withOpacity(.8)),),
                                //       ),
                                //     discountModel.discountAmount! > 0?
                                //     Directionality(
                                //       textDirection: TextDirection.ltr,
                                //       child: Text(
                                //         PriceConverter.convertPrice(
                                //             lowestPrice.toDouble(),
                                //             discount: discountModel.discountAmount!.toDouble(),
                                //             discountType: discountModel.discountAmountType),
                                //         style: ubuntuMedium.copyWith(
                                //             fontSize: Dimensions.paddingSizeDefault,
                                //             color:  Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor),
                                //       ),
                                //     ):
                                //     Directionality(
                                //       textDirection: TextDirection.ltr,
                                //       child: Text(
                                //         PriceConverter.convertPrice(lowestPrice.toDouble()),
                                //         style: ubuntuMedium.copyWith(
                                //             fontSize:Dimensions.fontSizeDefault,
                                //             color: Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ]),
                        ],
                      ),
                    ),

                    if( fromPage == 'trending_services')
                      Expanded(
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Text(
                                    'Service ${service.providerCount.toString()} Provider'.tr,
                                    style: ubuntuRegular.copyWith(
                                        fontSize: Dimensions.fontSizeExtraSmall,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color!
                                            .withOpacity(.6)),
                                  ),


                                  service.maxDistanceProvider!=null&&service.maxDistanceProvider!=""?

                                  Text(

                                    "Withins ${service.maxDistanceProvider!.ceil().toString()} Miles",
                                    style: ubuntuRegular.copyWith(
                                        fontSize: Dimensions.fontSizeExtraSmall,
                                        color: Theme.of(context).colorScheme.primary),
                                  ):   Text(

                                    "Within 0 Miles",
                                    style: ubuntuRegular.copyWith(
                                        fontSize: Dimensions.fontSizeExtraSmall,
                                        color: Theme.of(context).colorScheme.primary),
                                  ),
                                  // Column(
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  //   children: [
                                  //     if(discountModel.discountAmount! > 0)
                                  //       Directionality(
                                  //         textDirection: TextDirection.ltr,
                                  //         child: Text(
                                  //           PriceConverter.convertPrice(lowestPrice.toDouble()),
                                  //           maxLines: 2,
                                  //           style: ubuntuRegular.copyWith(
                                  //               fontSize: Dimensions.fontSizeSmall,
                                  //               decoration: TextDecoration.lineThrough,
                                  //               color: Theme.of(context).colorScheme.error.withOpacity(.8)),),
                                  //       ),
                                  //     discountModel.discountAmount! > 0?
                                  //     Directionality(
                                  //       textDirection: TextDirection.ltr,
                                  //       child: Text(
                                  //         PriceConverter.convertPrice(
                                  //             lowestPrice.toDouble(),
                                  //             discount: discountModel.discountAmount!.toDouble(),
                                  //             discountType: discountModel.discountAmountType),
                                  //         style: ubuntuMedium.copyWith(
                                  //             fontSize: Dimensions.paddingSizeDefault,
                                  //             color:  Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor),
                                  //       ),
                                  //     ):
                                  //     Directionality(
                                  //       textDirection: TextDirection.ltr,
                                  //       child: Text(
                                  //         PriceConverter.convertPrice(lowestPrice.toDouble()),
                                  //         style: ubuntuMedium.copyWith(
                                  //             fontSize:Dimensions.fontSizeDefault,
                                  //             color: Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ]),
                          ],
                        ),
                      ),

                    Expanded(
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  Text(
                                  'Service ${service.providerCount.toString()} Provider'.tr,
                                  style: ubuntuRegular.copyWith(
                                      fontSize: Dimensions.fontSizeExtraSmall,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color!
                                          .withOpacity(.6)),
                                ),


                                service.maxDistanceProvider!=null&&service.maxDistanceProvider!=""?

                                Text(

                                  "Within${service.maxDistanceProvider!.ceil().toString()} Miles",
                                  style: ubuntuRegular.copyWith(
                                      fontSize: Dimensions.fontSizeExtraSmall,
                                      color: Theme.of(context).colorScheme.primary),
                                ):   Text(

                                  "Within 0 Miles",
                                  style: ubuntuRegular.copyWith(
                                      fontSize: Dimensions.fontSizeExtraSmall,
                                      color: Theme.of(context).colorScheme.primary),
                                ),
                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     if(discountModel.discountAmount! > 0)
                                //       Directionality(
                                //         textDirection: TextDirection.ltr,
                                //         child: Text(
                                //           PriceConverter.convertPrice(lowestPrice.toDouble()),
                                //           maxLines: 2,
                                //           style: ubuntuRegular.copyWith(
                                //               fontSize: Dimensions.fontSizeSmall,
                                //               decoration: TextDecoration.lineThrough,
                                //               color: Theme.of(context).colorScheme.error.withOpacity(.8)),),
                                //       ),
                                //     discountModel.discountAmount! > 0?
                                //     Directionality(
                                //       textDirection: TextDirection.ltr,
                                //       child: Text(
                                //         PriceConverter.convertPrice(
                                //             lowestPrice.toDouble(),
                                //             discount: discountModel.discountAmount!.toDouble(),
                                //             discountType: discountModel.discountAmountType),
                                //         style: ubuntuMedium.copyWith(
                                //             fontSize: Dimensions.paddingSizeDefault,
                                //             color:  Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor),
                                //       ),
                                //     ):
                                //     Directionality(
                                //       textDirection: TextDirection.ltr,
                                //       child: Text(
                                //         PriceConverter.convertPrice(lowestPrice.toDouble()),
                                //         style: ubuntuMedium.copyWith(
                                //             fontSize:Dimensions.fontSizeDefault,
                                //             color: Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(child: RippleButton(onTap: () {
              print("ANKURRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
              print("placeid:::${placedIdGloabal.value}");
              if (fromPage == "search_page") {
                print("search page");
                Get.toNamed(
                  RouteHelper.getServiceRoute(service.id!,
                      fromPage: "search_page"),
                );
              } else {
                print("RouteHelper.getServiceRoute(service.id!)");
                Get.toNamed(
                  RouteHelper.getServiceRoute(service.id!),
                );
              }
            }))
          ],
        ),
        //add to cart button
        if (fromType != 'fromCampaign')
          Align(
            alignment: Get.find<LocalizationController>().isLtr
                ? Alignment.bottomRight
                : Alignment.bottomLeft,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  child: Icon(Icons.add_box,
                      color:

                           Theme.of(context).colorScheme.primary,
                      size: Dimensions.paddingSizeExtraLarge),
                ),
                Positioned.fill(child: RippleButton(onTap: () {
                  if (fromType != "provider_details") {
                    Get.find<CartController>().resetPreselectedProviderInfo();
                  }
                  showModalBottomSheet(
                      useRootNavigator: true,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) =>
                          ServiceCenterDialog(service: service,));
                }))
              ],
            ),
          ),
      ],
    );
  }
}
