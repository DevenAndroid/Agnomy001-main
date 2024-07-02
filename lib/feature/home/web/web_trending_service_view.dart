import 'package:demandium/components/service_widget_vertical.dart';
import 'package:demandium/components/core_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebTrendingServiceView extends StatelessWidget {
  const WebTrendingServiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceController>(
        builder: (serviceController) {
         return
        //  serviceController.trendingServiceList!.length  == 0 ?
           Column(
           children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 serviceController.trendingServiceList!.length >= 1?
                 Text('trending_services'.tr, style: ubuntuMedium.copyWith(
                     fontSize: Dimensions.fontSizeExtraLarge)):
                 SizedBox(height: 0,width: 0,),
                 serviceController.trendingServiceList!.length >= 4 ?
                 InkWell(
                   onTap: () => Get.toNamed(RouteHelper.allServiceScreenRoute("trending_services")),
                   child: Text('see_all'.tr, style: ubuntuRegular.copyWith(
                     fontSize: Dimensions.fontSizeDefault,
                     decoration: TextDecoration.underline,
                     color: Get.isDarkMode ? Theme
                         .of(context)
                         .textTheme
                         .bodyLarge!
                         .color!
                         .withOpacity(.6) : Theme
                         .of(context)
                         .colorScheme
                         .primary,
                   )),
                 ):
                 const SizedBox(width: 0,height: 0,),
               ],
             ),
             const SizedBox(height: Dimensions.paddingSizeLarge,),

             GridView.builder(
               key: UniqueKey(),
               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisSpacing: Dimensions.paddingSizeDefault,
                 mainAxisSpacing: Dimensions.paddingSizeDefault,
                 childAspectRatio: ResponsiveHelper.isDesktop(context) ||
                     ResponsiveHelper.isTab(context) ? 0.92 : .70,
                 crossAxisCount: ResponsiveHelper.isMobile(context)
                     ? 2
                     : ResponsiveHelper.isTab(context) ? 3 : 5,
               ),
               physics: const NeverScrollableScrollPhysics(),
               shrinkWrap: true,
               itemCount: serviceController.trendingServiceList!.length,
               //serviceList.length,
               itemBuilder: (context, index) {
                 return ServiceWidgetVertical(service: serviceController
                       .trendingServiceList![index],
                     isAvailable: true,
                     fromType: '',);
               },
             )

           ],
         )
        // :const SizedBox(height: 0,width: 0,)
         ;
        }     )
    ;

  }
}
