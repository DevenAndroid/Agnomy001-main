import 'dart:convert';
import 'package:demandium/components/service_center_dialog1.dart';
import 'package:demandium/utils/images.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../../components/service_center_dialog.dart';
import '../../../data/model/servicewiseprovider_model.dart';
import '../../web_landing/widget/web_landing_search_box.dart';


String quote_ids = '';

class ServiceOverview extends StatefulWidget {
  final String description;
  List<Providers> providers;
  List<Variations>? variations;
  final Service service;


   ServiceOverview({Key? key, required this.description, required this. providers, required this. variations, required this.service,})
      : super(key: key);

  @override
  State<ServiceOverview> createState() => _ServiceOverviewState();
}

class _ServiceOverviewState extends State<ServiceOverview> {
  List<dynamic>? serviceProviderIDss = [];
  // void addOneServiceIDs(int index) {
  //   if (!serviceProviderIDss!
  //       .contains(widget.providers[index].id)) {
  //     serviceProviderIDss!
  //         .add(widget.providers[index].id);
  //   }
  // }


  @override
  void initState() {
    // serviceProviderIDss = [];
    // serviceProviderIDss =  serviceProviderIDss!.map((provider) => provider.providerId).atoList();
   // addOneServiceIDs(1);



    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          WebShadowWrap(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeSmall,
                      vertical: Dimensions.paddingSizeEight),
                  width: Dimensions.webMaxWidth,
                  constraints: ResponsiveHelper.isDesktop(context)
                      ? BoxConstraints(
                          minHeight: !ResponsiveHelper.isDesktop(context) &&
                                  Get.size.height < 600
                              ? Get.size.height
                              : Get.size.height - 550,
                        )
                      : null,
                  child: Card(
                      elevation: ResponsiveHelper.isMobile(context) ? 1 : 0,
                      color: ResponsiveHelper.isMobile(context)
                          ? Theme.of(context).cardColor
                          : Colors.transparent,
                      child: HtmlWidget(widget.description)),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //       horizontal: Dimensions.paddingSizeDefault,
                //       vertical: Dimensions.paddingSizeEight),
                //   child: Text(
                //     "Service Provider in your area:",
                //     style: ubuntuRegular.copyWith(
                //         fontSize: Dimensions.fontSizeExtraLarge, color: Colors.black),
                //   ),
                // ), const SizedBox(height: 20,),
                //  GridView.builder(
                //   shrinkWrap: true,
                //   scrollDirection: Axis.vertical, // Change this to Axis.horizontal if you want horizontal scrolling
                //   itemCount: providers.length,
                //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 3,
                //     mainAxisSpacing: 10.0,
                //     crossAxisSpacing: 10.0,
                //      childAspectRatio: 6 / 2,
                //   ),
                //   itemBuilder: (context, index) {
                //     return Container(
                //       // height: 10,
                //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                //       decoration: BoxDecoration(
                //         borderRadius: const BorderRadius.all(Radius.circular(10)),
                //         border: Border.all(color: Colors.grey),
                //       ),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         children: [
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //                Container(
                //                  // height: 20,
                //                  // width: 25,
                //                  child: Image(
                //                   image: NetworkImage(
                //                     "${Get.find<SplashController>().configModel.content!.imageBaseUrl}/provider/logo/${providers![index].logo.toString()}"
                //                   ),
                //                   height: 30,
                //                                            ),
                //                ),
                //               const SizedBox(width: 20),
                //               Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   Text(providers![index].companyName.toString()),
                //                   Row(
                //                     crossAxisAlignment: CrossAxisAlignment.start,
                //                     mainAxisAlignment: MainAxisAlignment.start,
                //                     children: [
                //                        RatingBar(rating: providers![index].avgRating),
                //                       Gaps.horizontalGapOf(5),
                //                       Directionality(
                //                         textDirection: TextDirection.ltr,
                //                         child:  Text('${providers![index].ratingCount} ${'reviews'.tr}', style: ubuntuRegular.copyWith(
                //                           fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).secondaryHeaderColor,
                //                         )),
                //                       ),
                //                       // const Text("0 Reviews"),
                //                     ],
                //                   ),
                //                    SizedBox(
                //                      width: Get.width*0.178,
                //                      child: Text(providers![index].companyDescription.toString(),
                //                          style: ubuntuRegular.copyWith(
                //                            overflow:TextOverflow.ellipsis,
                //                            fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).secondaryHeaderColor,
                //                          ),textAlign: TextAlign.start,maxLines:1,softWrap: true,overflow: TextOverflow.ellipsis,
                //                      ),
                //                    )// width: Get.width*0.2,
                //                 ],
                //               ),
                //             ],
                //           ),
                //            Gaps.horizontalGapOf(6),
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //                Text("with in ${providers[index].distance!.toInt()} miles"),
                //
                //               ElevatedButton(
                //                 onPressed: () {
                //                   var providerid= providers[index].id.toString();
                //                   print("ankur=>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${providers[index].id.toString()}");
                //                   Get.find<CartController>().resetPreselectedProviderInfo();
                //                   showModalBottomSheet(
                //                       context: context,
                //                       useRootNavigator: true,
                //                       isScrollControlled: true,
                //                       backgroundColor: Colors.transparent,
                //                       builder: (context) => ServiceCenterDialog(
                //                         service: service, isFromDetails: true,
                //                         providerId: providers[index].distance!.toInt(),
                //                       logoImage:"${Get.find<SplashController>().configModel.content!.imageBaseUrl}/provider/logo/${providers![index].logo.toString()}",
                //                       )
                //                   );
                //                 },
                //                 child: Text('${"Quote".tr}',style: ubuntuRegular.copyWith(color: Colors.white),),
                //               ),
                //           /*
                //               SizedBox(
                //                 height: 30,
                //                 child:  GetBuilder<CartController>(builder: (cartControllerInit) {
                //                   return GetBuilder<CartController>(
                //                       builder: (cartController) {
                //                         bool addToCart = true;
                //                         return cartController.isLoading
                //                             ? const Center(
                //                             child: CircularProgressIndicator())
                //                             : ElevatedButton(
                //                           onPressed: () {
                //                             print("ADD CARD1");
                //
                //                             if(Get.find<SplashController>().configModel.content?.biddingStatus==1);
                //
                //                             cartController.updateQuantity(index, true);
                //                             cartController.showMinimumAndMaximumOrderValueToaster();
                //
                //                               if (addToCart) {
                //                                 addToCart = false;
                //                                  cartController.addMultipleCartToServer();
                //                                  cartController.getCartListFromServer(shouldUpdate: true);
                //                               }
                //
                //                             print("ADD CARD");
                //                           },
                //                           child:
                //
                //                         Text('${"add".tr} +',style: ubuntuRegular.copyWith(color: Colors.white),
                //                         )
                //                         );
                //                       }
                //                   );
                //                 }
                //               ),
                //               )
                //
                //            */
                //
                //
                //             ],
                //           ),
                //         ],
                //       ),
                //     );
                //   },
                // ),



                const SizedBox(height: 20,),
             /*   SizedBox(
                  height: 115,
                  child: GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical, // Change this to Axis.horizontal if you want horizontal scrolling
                    itemCount: 6,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Number of columns in the grid
                      mainAxisSpacing: 10.0, // Spacing between rows
                      crossAxisSpacing: 10.0, // Spacing between columns
                      // childAspectRatio: 3 / 2, // Aspect ratio of the items
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        height: 10,
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.red),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(
                                  image: AssetImage("assets/images/faming.webp"),
                                  height: 20,
                                ),
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Ag Inc LLc"),
                                    Row(
                                      children: [
                                        RatingBarIndicator(
                                          rating: 2.75,
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 5,
                                          itemSize: 10.0,
                                          direction: Axis.horizontal,
                                        ),
                                        SizedBox(width: 5),
                                        Text("0 Reviews"),
                                      ],
                                    ),
                                    Text("Ag Inc LLc"),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("within 12 miles"),
                                SizedBox(
                                  height: 30,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text("Quote"),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  // child: ListView.builder(
                  //   shrinkWrap: true,
                  //   scrollDirection: Axis.horizontal,
                  //   itemCount: 5,
                  //   itemBuilder: (context, index) {
                  //     return Row(
                  //       children: [
                  //         Padding(
                  //           padding: const EdgeInsets.symmetric(
                  //               horizontal: Dimensions.paddingSizeDefault,
                  //     ),
                  //           child: Container(
                  //             width: 290,
                  //             padding:
                  //                 EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  //
                  //             decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.all(Radius.circular(10)),
                  //                 border: Border.all(color: Colors.grey)),
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               mainAxisAlignment: MainAxisAlignment.start,
                  //               children: [
                  //                 Row(
                  //                   mainAxisAlignment: MainAxisAlignment.start,
                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                  //                   children: [
                  //                     Image(
                  //                       image: AssetImage(
                  //                         "assets/images/faming.webp",
                  //                       ),
                  //                       height: 20,
                  //                     ),
                  //                     SizedBox(width: 20,),
                  //                     Column(
                  //                       crossAxisAlignment: CrossAxisAlignment.start,
                  //                       children: [
                  //                         Text("Ag Inc LLc"),
                  //                         Row(
                  //                           children: [
                  //                             RatingBarIndicator(
                  //                               rating: 2.75,
                  //                               itemBuilder: (context, index) => Icon(
                  //                                 Icons.star,
                  //                                 color: Colors.amber,
                  //                               ),
                  //                               itemCount: 5,
                  //                               itemSize: 10.0,
                  //                               direction: Axis.horizontal,
                  //                             ),
                  //                             SizedBox(width:5),
                  //                             Text("0 Reviews")
                  //                           ],
                  //                         ),
                  //                         Text("Ag Inc LLc"),
                  //                       ],
                  //                     ),
                  //                   ],
                  //                 ),
                  //                 Row(
                  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Text("within 12 miles"),
                  //                    SizedBox(
                  //                      height: 30,
                  //                      child: ElevatedButton(
                  //
                  //                          onPressed: (){
                  //
                  //
                  //                          }, child: Text("Quato")),
                  //                    )
                  //                   ],
                  //                 )
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //         const SizedBox(
                  //           width: 5,
                  //         )
                  //       ],
                  //     );
                  //   },
                  // ),
                ),

              */
                // const SizedBox(height: 20,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault,
                vertical: Dimensions.paddingSizeEight),
            child: Text(
              "Service Provider in your area:",
              style: ubuntuRegular.copyWith(
                  fontSize: Dimensions.fontSizeExtraLarge, color: Colors.black),
            ),
          ),
           SizedBox(
             height:ResponsiveHelper.isMobile(context)?6:20,
            // height: 20
    ),

          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 6,
              horizontal: 8
            ),
            child: GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical, // Change this to Axis.horizontal if you want horizontal scrolling
              itemCount: widget.providers.length,
              // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //   crossAxisCount: 3,
              //   mainAxisSpacing: 10.0,
              //   crossAxisSpacing: 10.0,
              //   childAspectRatio: 6 / 2,
              // ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: ResponsiveHelper.isDesktop(context) ? 3 :1 ,
                crossAxisSpacing: ResponsiveHelper.isDesktop(context)? 10.0:Dimensions.paddingSizeSmall,
                mainAxisSpacing: ResponsiveHelper.isDesktop(context)? 10.0:Dimensions.paddingSizeSmall,
                childAspectRatio: ResponsiveHelper.isDesktop(context) ? 6/2  : 2/0.65 ,
              ),
              itemBuilder: (context, index) {
             // serviceProviderIDss = [widget.providers[index].id];
                return Container(
                  // height: 10,
                  padding:  EdgeInsets.symmetric(horizontal: 10,
                      vertical: ResponsiveHelper.isMobile(context)?4:10),
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
                          CircleAvatar(
                            minRadius:10,
                            child: Container(
                              width:30,
                              color: Colors.transparent,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image(
                                  image: NetworkImage(
                                      "${Get.find<SplashController>().configModel.content!.imageBaseUrl}/provider/logo/${widget.service.providers![index].logo.toString()}"
                                  ),
                                  // height: 30,
                                  // width:30,
                                  height: ResponsiveHelper.isMobile(context) ? 30: 30,
                                  width: ResponsiveHelper.isMobile(context) ? 40 : 30,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(widget.providers[index].companyName.toString()),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  RatingBar(rating: widget.providers[index].avgRating.toDouble()),
                                  Gaps.horizontalGapOf(5),
                                  Directionality(
                                    textDirection: TextDirection.ltr,
                                    child:  Text('${widget.providers[index].ratingCount} ${'reviews'.tr}', style: ubuntuRegular.copyWith(
                                      fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).secondaryHeaderColor,
                                    )),
                                  ),
                                  // const Text("0 Reviews"),
                                ],
                              ),
                              SizedBox(
                                width:ResponsiveHelper.isMobile(context)?Get.width*0.7: Get.width*0.18,
                                // SizedBox(height:ResponsiveHelper.isMobile(context)?6:20,),
                                child: Text('${widget.providers[index].city.toString()}, ${ widget.providers[index].state.toString()}',
                                  style: ubuntuRegular.copyWith(
                                    overflow:TextOverflow.ellipsis,
                                    fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).secondaryHeaderColor,
                                  ),textAlign: TextAlign.start,maxLines:1,softWrap: true,overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: ResponsiveHelper.isMobile(context)?0:6,),
                      // Gaps.horizontalGapOf(6),
                      // Text(serviceProviderIDss.toString()),
                      // Text(widget.providers[index].id.toString()),
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("with in ${widget.providers[index].distance!.toInt()} miles"),

                            ElevatedButton(

                              onPressed: () async {
                                serviceProviderIDss = [widget.providers[index].id];
                                print("Listttttttttttttttttt=>${jsonEncode(serviceProviderIDss)}");
                                if(Get.find<AuthController>().isLoggedIn()) {
                                  Get.find<CartController>().resetPreselectedProviderInfo();


                                  if (serviceProviderIDss!.isNotEmpty) {
                                    await createQuote();
                                    print("Get Quote Button first pop");
                                    if (Get.find<SplashController>()
                                        .configModel.content
                                        ?.guestCheckout ==
                                        0 &&
                                        !Get.find<AuthController>()
                                            .isLoggedIn()) {
                                      Get.toNamed(
                                          RouteHelper.getNotLoggedScreen(
                                              RouteHelper.cart, "cart"));
                                    } else {
                                      Get.find<CheckOutController>()
                                          .updateState(
                                          PageState.orderDetails);
                                       Get.toNamed(RouteHelper.getCheckoutRoute('cart', 'orderDetails', 'null'));
                                    }
                                    // Get.to(CheckoutScreen(
                                    //   Get.parameters.containsKey('flag') &&
                                    //           Get.parameters['flag']! ==
                                    //               'success'
                                    //       ? 'complete'
                                    //       : Get.parameters['currentPage']
                                    //           .toString(),
                                    //   Get.parameters['addressID'] != null
                                    //       ? Get.parameters['addressID']!
                                    //       : 'null',
                                    //   reload: Get.parameters['reload']
                                    //                   .toString() ==
                                    //               "true" ||
                                    //           Get.parameters['reload']
                                    //                   .toString() ==
                                    //               "null"
                                    //       ? true
                                    //       : false,
                                    //   token: Get.parameters["token"],
                                    // ));
                                  } else {
                                    customSnackBar(
                                        "please any one add to provider", duration: 2);
                                    //snackbar
                                  }
                                } else {
                                  customSnackBar("please login First",duration:2);
                                  Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.main));
                                }

                              },
                              // onPressed: () {
                              //   if (Get.find<AuthController>().isLoggedIn()) {
                              //     Get.find<CartController>()
                              //         .resetPreselectedProviderInfo();
                              //     showModalBottomSheet(
                              //         context: context,
                              //         useRootNavigator: true,
                              //         isScrollControlled: true,
                              //         backgroundColor: Colors.transparent,
                              //         builder: (context) => ServiceCenterDialog1(
                              //           service: service,
                              //           isFromDetails: true,
                              //         ));
                              //   } else {
                              //     customSnackBar("please login First",duration:2);
                              //     // Get.toNamed(RouteHelper.getSignInRoute(
                              //     //     Get.currentRoute));
                              //     Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.main));
                              //   }
                              //
                              //
                              //   // var providerid= providers[index].id.toString();
                              //   // print("ankur=>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${providers[index].id.toString()}");
                              //   // Get.find<CartController>().resetPreselectedProviderInfo();
                              //   // showModalBottomSheet(
                              //   //     context: context,
                              //   //     useRootNavigator: true,
                              //   //     isScrollControlled: true,
                              //   //     backgroundColor: Colors.transparent,
                              //   //     builder: (context) => ServiceCenterDialog(
                              //   //       service: service, isFromDetails: true,
                              //   //       providerId: providers[index].distance!.toInt(),
                              //   //       logoImage:"${Get.find<SplashController>().configModel.content!.imageBaseUrl}/provider/logo/${providers![index].logo.toString()}",
                              //   //     )
                              //   // );
                              // },
                              child: Text('${"Quote".tr}',style: ubuntuRegular.copyWith(color: Colors.white),),
                            ),

                            // ElevatedButton(
                            //   onPressed: () {
                            //     var providerid= providers[index].id.toString();
                            //     print("ankur=>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${providers[index].id.toString()}");
                            //     Get.find<CartController>().resetPreselectedProviderInfo();
                            //     showModalBottomSheet(
                            //         context: context,
                            //         useRootNavigator: true,
                            //         isScrollControlled: true,
                            //         backgroundColor: Colors.transparent,
                            //         builder: (context) => ServiceCenterDialog(
                            //           service: service, isFromDetails: true,
                            //           providerId: providers[index].distance!.toInt(),
                            //           logoImage:"${Get.find<SplashController>().configModel.content!.imageBaseUrl}/provider/logo/${providers![index].logo.toString()}",
                            //         )
                            //     );
                            //   },
                            //   child: Text('${"Quote".tr}',style: ubuntuRegular.copyWith(color: Colors.white),),
                            // ),
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
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          SizedBox(height:ResponsiveHelper.isMobile(context)?6:20,),

        ],
      ),
    );
  }







  Future<void> createQuote() async {
    final String serviceId = widget.service.id.toString();// widget.service!.id.toString();
    final String categoryID =widget.service.categoryId.toString(); //widget.service!.categoryId.toString();
    final String subCategoryID =widget.service.subCategoryId.toString(); //widget.service!.subCategoryId.toString();

    final url = Uri.parse('https://admin.agnomy.com/api/v1/customer/create-quote');
    print("token 3${ Get.find<SplashController>().splashRepo.apiClient.token.toString()}");
    print("getGuestId${ Get.find<SplashController>().getGuestId()}");

    final request = http.MultipartRequest('POST', url)
      ..headers['Accept'] = 'application/json'
      ..headers['Authorization'] = "Bearer ${Get.find<SplashController>().splashRepo.apiClient.token.toString()}"

      ..fields['service_id'] =
          serviceId //'0d6aa3e6-20f3-4d36-83b2-ebf024ddf39e'
      ..fields['category_id'] =
          categoryID //'33f46f95-e8c0-4e91-86fb-0819ba4adebc'
      ..fields['sub_category_id'] =
          subCategoryID //'eaa49fe9-ae1c-41de-862f-9753d7fa20da'
      ..fields['guest_id'] = Get.find<SplashController>().getGuestId();

    print("Listttttttttttttttttt=>${jsonEncode(serviceProviderIDss)}");
    request.fields['provider'] = serviceProviderIDss != null
                     ? jsonEncode(serviceProviderIDss):
                       jsonEncode(serviceProviderIDss);

    // request.fields['provider'] = serviceProviderIDss != null
    //     ? jsonEncode(serviceProviderIDss)
    //     : jsonEncode(serviceProviderIDss);


    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final responseData = jsonDecode(responseBody);
        print('Response data single: $responseData');
        quote_ids = responseData['content']['quote_id'];
        print('quote_id is: $quote_ids');
      } else {
        print('Failed to create quote. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
