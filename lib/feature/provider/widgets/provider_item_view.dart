// import 'package:demandium/components/core_export.dart';
// import 'package:demandium/feature/provider/model/provider_model.dart';
// import 'package:get/get.dart';
//
// class ProviderItemView extends StatelessWidget {
//   final  bool fromHomePage;
//   final ProviderData providerData;
//   const ProviderItemView({Key? key, this.fromHomePage = true, required this.providerData}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     List<String> subcategory=[];
//     providerData.subscribedServices?.forEach((element) {
//       if(element.subCategory!=null){
//         subcategory.add(element.subCategory?.name??"");
//       }
//     });
//
//     String subcategories = subcategory.toString().replaceAll('[', '');
//     subcategories = subcategories.replaceAll(']', '');
//     subcategories = subcategories.replaceAll('&', ' and ');
//
//     return GestureDetector(
//       onTap: ()=>Get.toNamed(RouteHelper.getProviderDetails(providerData.id!,subcategories)),
//       child: Padding(padding:EdgeInsets.symmetric(
//           horizontal: ResponsiveHelper.isDesktop(context) && fromHomePage?5:Dimensions.paddingSizeSmall,
//           vertical: fromHomePage?0:Dimensions.paddingSizeEight),
//         child: Container(
//           decoration: BoxDecoration(color: Theme.of(context).cardColor , borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
//             border: Border.all(color: Theme.of(context).hintColor.withOpacity(0.3)),
//           ),
//           padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
//           child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
//             Row(children: [
//
//               ClipRRect(borderRadius: BorderRadius.circular(Dimensions.radiusExtraMoreLarge),
//                 child: CustomImage(height: 70, width: 70, fit: BoxFit.cover,
//                     image: "${Get.find<SplashController>().configModel.content!.imageBaseUrl}/provider/logo/${providerData.logo}"),
//               ),
//
//               const SizedBox(width: Dimensions.paddingSizeSmall),
//
//               Expanded(
//                 child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,children: [
//                   Text(providerData.companyName??"", style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
//                     maxLines: 1, overflow: TextOverflow.ellipsis),
//                   // if(subcategories.isNotEmpty)
//                   // Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
//                   //   child: Text(subcategories,
//                   //     style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).secondaryHeaderColor),
//                   //     maxLines: 2,
//                   //     overflow: TextOverflow.ellipsis,
//                   //   ),
//                   // ),
//                   Row(children: [
//                       RatingBar(rating: providerData.avgRating),
//                       Gaps.horizontalGapOf(5),
//                       Directionality(
//                         textDirection: TextDirection.ltr,
//                         child:  Text('${providerData.ratingCount} ${'reviews'.tr}', style: ubuntuRegular.copyWith(
//                           fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).secondaryHeaderColor,
//                         )),
//
//
//                         // Text(
//                         //   providerData.avgRating!.toString(),
//                         //   style: TextStyle(
//                         //       fontWeight: FontWeight.w700,
//                         //       fontSize: Dimensions.fontSizeSmall,
//                         //       color: Colors.grey),
//                         // ),
//                       ),
//                     ],
//                   ),
//                 ],),
//               )
//             ],),
//
//
//
//             Text(subcategories,
//               style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).secondaryHeaderColor), maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
// SizedBox(height: 10,),
//             Row(children: [
//               Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
//                 child: Image.asset(Images.iconLocation, height:12)),
//
//               Flexible(
//                 child: Text("${providerData.distance!.ceil()} miles away",
//                   style: ubuntuLight.copyWith(color:Get.isDarkMode? Theme.of(context).secondaryHeaderColor:Theme.of(context).primaryColorDark,fontSize: 12),
//                   overflow: TextOverflow.ellipsis),
//               ),
//
//             ],)
//           ]),
//         ),
//       ),
//     );
//   }
// }
//
import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/provider/model/provider_model.dart';
import 'package:get/get.dart';

import '../../booking/model/invoice.dart';

class ProviderItemView extends StatelessWidget {
  final  bool fromHomePage;
  final ProviderData providerData;
  const ProviderItemView({Key? key, this.fromHomePage = true, required this.providerData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> subcategory=[];
    providerData.subscribedServices?.forEach((element) {
      if(element.subCategory!=null){
        subcategory.add(element.subCategory?.name??"");
      }
    });


    String subcategories = subcategory.toString().replaceAll('[', '');
    subcategories = subcategories.replaceAll(']', '');
    subcategories = subcategories.replaceAll('&', ' and ');

    return GestureDetector(
      onTap: ()=>Get.toNamed(RouteHelper.getProviderDetails(providerData.id!,subcategories)),
      child: Padding(padding:EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.isDesktop(context) && fromHomePage?5:Dimensions.paddingSizeSmall,
          vertical: fromHomePage?0:Dimensions.paddingSizeEight),
        child: Container(
          decoration: BoxDecoration(color: Theme.of(context).cardColor , borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
            border: Border.all(color: Theme.of(context).hintColor.withOpacity(0.3)),
          ),
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Row(children: [

              ClipRRect(borderRadius: BorderRadius.circular(Dimensions.radiusExtraMoreLarge),
                child: CustomImage(
                    // height: 70,
                    height:ResponsiveHelper.isMobile(context)? 26 : 70,
                    width:ResponsiveHelper.isMobile(context)? 26 : 70,
                    // width: 70,
                    fit: BoxFit.cover,
                    image: "${Get.find<SplashController>().configModel.content!.imageBaseUrl}/provider/logo/${providerData.logo}"),
              ),

              const SizedBox(width: Dimensions.paddingSizeSmall),

              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,children: [
                  Text(providerData.companyName??"", style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  // if(subcategories.isNotEmpty)
                  // Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                  //   child: Text(subcategories,
                  //     style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).secondaryHeaderColor),
                  //     maxLines: 2,
                  //     overflow: TextOverflow.ellipsis,
                  //   ),
                  // ),
                  Row(children: [
                    RatingBar(rating: providerData.avgRating),
                    Gaps.horizontalGapOf(5),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child:  Text('${providerData.ratingCount} ${'reviews'.tr}', style: ubuntuRegular.copyWith(
                        fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).secondaryHeaderColor,
                      )),




                      // Text(
                      //   providerData.avgRating!.toString(),
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.w700,
                      //       fontSize: Dimensions.fontSizeSmall,
                      //       color: Colors.grey),
                      // ),
                    ),
                  ],

                  ),
                  // SizedBox(
                  //   // color: Colors.red,
                  //   height: 20,width: Get.width,
                  //   child: GetBuilder<ProviderBookingController>(
                  //   builder: (providerController) {
                  //     Provider providerDetails = providerController.providerDetailsContent!.provider! as Provider;
                  //     return
                  //       ListView.builder(
                  //         scrollDirection: Axis.horizontal,
                  //         shrinkWrap: true,
                  //         physics: const NeverScrollableScrollPhysics(),
                  //         itemCount: providerController.providerDetailsContent!
                  //             .subscribedServices!.length,
                  //         // itemCount: providerController.providerDetailsContent!.subscribedServices!.length,
                  //         itemBuilder: (context, index) {
                  //           return Text(
                  //               '${providerController.providerDetailsContent!
                  //                   .subscribedServices![index].name
                  //                   .toString()}, ');
                  //         },)
                  //     ;
                  //   },
                  //   ),
                  // ),
                 Text(providerData.cropTypes.toString().replaceAll(",",", ") ?? "", style: ubuntuRegular.copyWith(
                    fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).secondaryHeaderColor,
                  )),
                ],),
              )
            ],),



            // Text(
            //   subcategories,
            //   style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).secondaryHeaderColor), maxLines: 1,
            //   overflow: TextOverflow.ellipsis,
            // ),
            SizedBox(height: 10,),
            Row(children: [
              Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  child: Image.asset(Images.iconLocation, height:12)),

              Flexible(
                child: Text(
                    //'${providerData.distance!.toString()} miles away',
                    "${providerData.distance!.ceil()} miles away",
                    style: ubuntuLight.copyWith(color:Get.isDarkMode? Theme.of(context).secondaryHeaderColor:Theme.of(context).primaryColorDark,fontSize: 12),
                    overflow: TextOverflow.ellipsis),
              ),

            ],),
            SizedBox(height: ResponsiveHelper.isMobile(context)? Get.height*0.001 : Get.height*0.001,)
            ,  Align(
              alignment: Alignment.topLeft,
              child: Text('${providerData.city.toString()}, ${providerData.state.toString()}', style: ubuntuRegular.copyWith(
                fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).secondaryHeaderColor,
              )),
            ),
          ]),
        ),
      ),
    );
  }
}