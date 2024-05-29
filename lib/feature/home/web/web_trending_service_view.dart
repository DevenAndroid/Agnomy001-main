import 'package:demandium/components/service_widget_vertical.dart';
import 'package:demandium/components/core_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebTrendingServiceView extends StatelessWidget {
  const WebTrendingServiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceController>(
        builder: (serviceController){

          if(serviceController.trendingServiceList != null && serviceController.trendingServiceList!.isEmpty){
            return const SizedBox();
          }else{
            if(serviceController.trendingServiceList != null){
              List<Service>? serviceList = serviceController.trendingServiceList!.where((element) => element.providerCount!.toInt() !=0 ).toList();
              return  Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('trending_services'.tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),
                      InkWell(
                        onTap: () => Get.toNamed(RouteHelper.allServiceScreenRoute("trending_services")),
                        child: Text('see_all'.tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                          decoration: TextDecoration.underline,
                          color:Get.isDarkMode ?Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6) : Theme.of(context).colorScheme.primary,
                        )),
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimensions.paddingSizeLarge,),
                  InkWell(
                    onTap: (){
                      print("object::::::::::${serviceList}");
                    },
                    child: GridView.builder(
                      key: UniqueKey(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: Dimensions.paddingSizeDefault,
                        mainAxisSpacing:  Dimensions.paddingSizeDefault,
                        childAspectRatio: ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTab(context)  ? 0.92 : .70,
                        crossAxisCount: ResponsiveHelper.isMobile(context) ? 2 : ResponsiveHelper.isTab(context) ? 3 : 5,
                      ),
                      physics:const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: serviceList.length,
                      itemBuilder: (context, index) {
                        return ServiceWidgetVertical(service: serviceController.trendingServiceList![index],  isAvailable: true,fromType: '',);
                      },
                    ),
                  )
                ],
              );
            }else{
              return const SizedBox();
            }
          }
    });
  }
}
