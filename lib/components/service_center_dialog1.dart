import 'dart:convert';
import 'package:demandium/feature/web_landing/widget/web_landing_search_box.dart';
import 'package:demandium/utils/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import '../data/model/servicewiseprovider_model.dart';

class ServiceCenterDialog1 extends StatefulWidget {
  final Service? service;
  final CartModel? cart;
  final int? cartIndex;
  final int? providerId;
  final bool? isFromDetails;

  const ServiceCenterDialog1(
      {super.key,
      required this.service,
      this.cart,
      this.providerId,
      this.cartIndex,
      this.isFromDetails = false});

  @override
  State<ServiceCenterDialog1> createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<ServiceCenterDialog1> {
  AddressModel? addressModel;
  RxInt refereshInt = 0.obs;

  int value = 0;
  bool isRemove = false;
  bool isAdding = false;
  // Map<int, int> itemCounts = {};

  List<dynamic>? serviceProviderIDs;

  List<dynamic> servesProviderIds = [];

  // List<dynamic>? serviceProviderSingleIDs;


  @override
  void initState() {
   // Get.find<CartController>().setInitialCartList(widget.service!, widget.providerId);

    print("placeID => ${placedIdGloabal.value}");
    print("serviceId => ${widget.service!.id.toString()}");

    getZoneId();

    super.initState();
  }

  getZoneId() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    try {
      addressModel = AddressModel.fromJson(
          jsonDecode(sharedPreferences.getString(AppConstants.userAddress)!));
      fetchServiceProviders().then((value) {
        servicewiseProviderModel.value = value;
        RxInt refereshInt = 0.obs;
      });

      print("zoin id ==>>>> ${addressModel?.zoneId}");
      print("zoin id ==>>>> ${addressModel!.zoneId!}");
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ResponsiveHelper.isDesktop(context)) {
      return Obx(() {
        if (refereshInt.value > 0) {}
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge)),
          insetPadding: const EdgeInsets.all(30),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: pointerInterceptor(),
        );
      });
    }
    return pointerInterceptor();
  }

  pointerInterceptor() {
    return Obx(() {
      if (refereshInt.value > 0) {}

      return Padding(
        padding: EdgeInsets.only(
            top: ResponsiveHelper.isWeb() ? 0 : Dimensions.cartDialogPadding),
        child: PointerInterceptor(
          child: Container(
            width: ResponsiveHelper.isDesktop(context)
                ? Dimensions.webMaxWidth / 2
                : Dimensions.webMaxWidth,
            padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            decoration: BoxDecoration(
              color: Theme
                  .of(context)
                  .cardColor,
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(Dimensions.radiusExtraLarge)),
            ),
            child: GetBuilder<CartController>(builder: (cartControllerInit) {
              return servicewiseProviderModel.value.message != null
                  ? GetBuilder<ServiceController>(builder: (serviceController) {
                if (widget.service!.variationsAppFormat!
                    .zoneWiseVariations !=
                    null) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: Dimensions.paddingSizeLarge,
                          ),
                          ClipRRect(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(
                                    Dimensions.paddingSizeDefault)),
                            child: CustomImage(
                              image:
                              '${Get
                                  .find<SplashController>()
                                  .configModel
                                  .content!
                                  .imageBaseUrl!}/service/${widget.service!
                                  .thumbnail}',
                              height: Dimensions.imageSizeButton,
                              width: Dimensions.imageSizeButton,
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white70.withOpacity(0.6),
                                boxShadow: Get.isDarkMode
                                    ? null
                                    : [
                                  BoxShadow(
                                    color: Colors.grey[300]!,
                                    blurRadius: 2,
                                    spreadRadius: 1,
                                  )
                                ]),
                            child: InkWell(
                                onTap: () => Get.back(),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.black54,
                                )),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.paddingSizeEight,
                      ),
                      Text(
                        widget.service!.name!,
                        style: ubuntuMedium.copyWith(
                            fontSize: Dimensions.fontSizeDefault),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                      const SizedBox(
                        height: Dimensions.paddingSizeMini,
                      ),
                      Text(
                        "${servicewiseProviderModel.value.content!.length == 0
                            ? 1
                            : servicewiseProviderModel.value.content!
                            .length} ${'options_available'.tr}",
                        style: ubuntuRegular.copyWith(
                            color: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge!
                                .color!
                                .withOpacity(.5)),
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                  minHeight: Get.height * 0.2,
                                  maxHeight: Get.height * 0.5),
                              child:
                              servicewiseProviderModel
                                  .value.message !=
                                  null
                                  ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: Dimensions.paddingSizeSmall),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: Dimensions
                                              .paddingSizeExtraSmall),
                                      decoration: BoxDecoration(color: Theme
                                          .of(context)
                                          .hoverColor,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(Dimensions
                                                  .paddingSizeDefault))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                          "Get quote from all provider",
                                                          style: ubuntuMedium
                                                              .copyWith(
                                                              fontSize:
                                                              Dimensions
                                                                  .fontSizeSmall),
                                                          maxLines: 2,
                                                          overflow:
                                                          TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Spacer(),
                                                        InkWell(
                                                          onTap: () {
                                                            print("Add button");
                                                            // value == 0 ? createQuote() : null;


                                                            setState(() {
                                                              if (isAdding) {
                                                                value++;
                                                              } else {
                                                                value--;
                                                              }
                                                              isAdding =
                                                              !isAdding;
                                                            });
                                                          },
                                                          child:
                                                          Container(
                                                            height:
                                                            30,
                                                            width: 30,
                                                            margin: const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                Dimensions
                                                                    .paddingSizeSmall),
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Theme
                                                                    .of(context)
                                                                    .colorScheme
                                                                    .secondary),
                                                            alignment:
                                                            Alignment
                                                                .center,
                                                            child: value == 0 ?
                                                            Icon(Icons.add, size: 15, color: Theme.of(context).cardColor,):
                                                            Icon(Icons.remove, size: 15, color: Theme.of(context).cardColor,)
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                      servicewiseProviderModel.value.content!
                                          .length,
                                      itemBuilder: (context, index) {
                                        serviceProviderIDs = servicewiseProviderModel.value.content!.map((provider) => provider.providerId).toList();

                                        var provider = servicewiseProviderModel.value.content![index].providerId;

                                        return Padding(
                                          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                                          child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: Dimensions.paddingSizeExtraSmall),
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context).hoverColor,
                                                  borderRadius: const BorderRadius
                                                      .all(Radius.circular(Dimensions.paddingSizeDefault))),
                                              child: Padding(padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  servicewiseProviderModel
                                                                      .value
                                                                      .content![index]
                                                                      .name
                                                                      .toString(),
                                                                  style: ubuntuMedium
                                                                      .copyWith(
                                                                      fontSize: Dimensions
                                                                          .fontSizeSmall),
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow
                                                                      .ellipsis,
                                                                ),
                                                                Spacer(),
                                                                Text(
                                                                  '${servicewiseProviderModel
                                                                      .value
                                                                      .content![index]
                                                                      .distance
                                                                      .toString()} miles away',
                                                                  style: ubuntuMedium
                                                                      .copyWith(
                                                                      fontSize: Dimensions
                                                                          .fontSizeSmall),
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow
                                                                      .ellipsis,),
                                                                SizedBox(
                                                                  width: 6,
                                                                ),


                                                                InkWell(
                                                                  onTap: () {

                                                                    if (servicewiseProviderModel.value.content![index].value > 0) {
                                                                      setState(() {
                                                                        servicewiseProviderModel.value.content![index].value--;
                                                                        servicewiseProviderModel.value.content![index].isRemove = !servicewiseProviderModel.value.content![index].isRemove;

                                                                      });
                                                                    }
                                                                  },
                                                                  child: Container(
                                                                    height: 30,
                                                                    width: 30,
                                                                    margin: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal: Dimensions
                                                                            .paddingSizeSmall),
                                                                    decoration: BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: Theme
                                                                            .of(
                                                                            context)
                                                                            .colorScheme
                                                                            .secondary),
                                                                    alignment: Alignment
                                                                        .center,
                                                                    child: Icon(
                                                                      Icons
                                                                          .remove,
                                                                      size: 15,
                                                                      color: Theme
                                                                          .of(
                                                                          context)
                                                                          .cardColor,
                                                                    ),
                                                                  ),
                                                                ),


                                                                Text('${servicewiseProviderModel.value.content![index].value}',),

                                                                InkWell(
                                                                    onTap: () {
                                                                      dynamic id;
                                                                      if (servicewiseProviderModel.value.content![index].value < 1) {
                                                                        setState(() {
                                                                          id = servicewiseProviderModel.value.content![index].providerId;
                                                                          // print("IDS${id}");
                                                                          servicewiseProviderModel.value.content![index].value ++;
                                                                          servicewiseProviderModel.value.content![index].isAdding = !servicewiseProviderModel.value.content![index].isAdding;
                                                                          // servicewiseProviderModel.value.content![index].value =  ;
                                                                        });
                                                                        print("Add button");
                                                                      }
                                                                 servesProviderIds.add(id);
                                                                     print(servesProviderIds);
                                                                    },
                                                                    child: Container(
                                                                      height: 30,
                                                                      width: 30,
                                                                      margin: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal: Dimensions
                                                                              .paddingSizeSmall),
                                                                      decoration: BoxDecoration(
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          color: Theme
                                                                              .of(
                                                                              context)
                                                                              .colorScheme
                                                                              .secondary),
                                                                      alignment: Alignment
                                                                          .center,
                                                                      child: Icon(
                                                                        Icons
                                                                            .add,
                                                                        size: 15,
                                                                        color: Theme
                                                                            .of(
                                                                            context)
                                                                            .cardColor,
                                                                      ),
                                                                    )
                                                                )






                                                              ],
                                                            ),

                                                          ],
                                                        ),
                                                      ),

                                                    ]),
                                              )
                                          ),
                                        );
                                      }),
                                ],
                              )
                                  : const Center(
                                child:
                                CircularProgressIndicator(),
                              ),
                            ),
                            const SizedBox(
                                height: Dimensions.paddingSizeLarge),
                          ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomButton(
                              onPressed: () {
                                createQuote();
                                print("Get Quote Button first pop");
                                // Get.to(CheckoutScreen(
                                //   Get.parameters.containsKey('flag') && Get.parameters['flag']! == 'success' ? 'complete' : Get.parameters['currentPage'].toString(),
                                //   Get.parameters['addressID'] != null ? Get.parameters['addressID']! :'null' ,
                                //   reload : Get.parameters['reload'].toString() == "true" || Get.parameters['reload'].toString() == "null" ? true : false,
                                //   token: Get.parameters["token"],
                                // ));

                                }, backgroundColor: Theme.of(context).colorScheme.secondary,
                              height: ResponsiveHelper.isDesktop(context) ? 50 : 45,
                              width: ResponsiveHelper.isDesktop(context) ? 300 : 200,
                              buttonText: 'Get Quote'),
                        ],
                      )
                      // GetBuilder<CartController>(builder: (cartController) {
                      //   bool addToCart = true;
                      //   return cartController.isLoading
                      //       ? const Center(child: CircularProgressIndicator())
                      //       : Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Row(children: [
                      //         if (Get.find<SplashController>()
                      //             .configModel
                      //             .content
                      //             ?.directProviderBooking ==
                      //             1)
                      //           cartControllerInit.preSelectedProvider
                      //               ? GestureDetector(
                      //             onTap: () {
                      //               showModalBottomSheet(
                      //                 useRootNavigator: true,
                      //                 isScrollControlled: true,
                      //                 backgroundColor:
                      //                 Colors.transparent,
                      //                 context: context,
                      //                 builder: (context) =>
                      //                     AvailableProviderWidget(
                      //                       subcategoryId: widget.service
                      //                           ?.subCategoryId ??
                      //                           "",
                      //                     ),
                      //               );
                      //             },
                      //             child:
                      //             const SelectedProductWidget(),
                      //           )
                      //               : GestureDetector(
                      //             onTap: () {
                      //               showModalBottomSheet(
                      //                 useRootNavigator: true,
                      //                 isScrollControlled: true,
                      //                 backgroundColor:
                      //                 Colors.transparent,
                      //                 context: context,
                      //                 builder: (context) =>
                      //                     AvailableProviderWidget(
                      //                       subcategoryId: widget.service
                      //                           ?.subCategoryId ??
                      //                           "",
                      //                     ),
                      //               );
                      //             },
                      //             child:
                      //             const UnselectedProductWidget(),
                      //           ),
                      //         if (Get.find<SplashController>()
                      //             .configModel
                      //             .content
                      //             ?.directProviderBooking ==
                      //             1)
                      //           const SizedBox(
                      //             width: Dimensions.paddingSizeSmall,
                      //           ),
                      //         if (Get.find<SplashController>()
                      //             .configModel
                      //             .content
                      //             ?.biddingStatus ==
                      //             1)
                      //           GestureDetector(
                      //             onTap: () {
                      //               Get.back();
                      //               showModalBottomSheet(
                      //                   backgroundColor: Colors.transparent,
                      //                   isScrollControlled: true,
                      //                   context: Get.context!,
                      //                   builder: (BuildContext context) {
                      //                     return const BottomCreatePostDialog();
                      //                   });
                      //               if (widget.service != null) {
                      //                 Get.find<CreatePostController>()
                      //                     .updateSelectedService(
                      //                     widget.service!);
                      //                 Get.find<CreatePostController>()
                      //                     .resetCreatePostValue(
                      //                     removeService: false);
                      //               }
                      //             },
                      //             child: Container(
                      //               height:
                      //               ResponsiveHelper.isDesktop(context)
                      //                   ? 50
                      //                   : 45,
                      //               decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(
                      //                     Dimensions.radiusSmall),
                      //                 border: Border.all(
                      //                     color: Theme.of(context)
                      //                         .colorScheme
                      //                         .primary
                      //                         .withOpacity(0.5),
                      //                     width: 0.7),
                      //                 color: Theme.of(context)
                      //                     .colorScheme
                      //                     .primary
                      //                     .withOpacity(0.1),
                      //               ),
                      //               padding: const EdgeInsets.symmetric(
                      //                   horizontal:
                      //                   Dimensions.paddingSizeSmall),
                      //               child: Center(
                      //                   child: Hero(
                      //                     tag: 'provide_image',
                      //                     child: ClipRRect(
                      //                       borderRadius: BorderRadius.circular(
                      //                           Dimensions
                      //                               .radiusExtraMoreLarge),
                      //                       child: Image.asset(
                      //                         Images.customPostIcon,
                      //                         height: 30,
                      //                         width: 30,
                      //                       ),
                      //                     ),
                      //                   )),
                      //             ),
                      //           ),
                      //         if (Get.find<SplashController>()
                      //             .configModel
                      //             .content
                      //             ?.biddingStatus ==
                      //             1)
                      //           const SizedBox(
                      //             width: Dimensions.paddingSizeSmall,
                      //           ),
                      //         Expanded(
                      //           child: CustomButton(
                      //             height:
                      //             ResponsiveHelper.isDesktop(context)
                      //                 ? 55
                      //                 : 45,
                      //             onPressed: cartControllerInit.isButton
                      //                 ? () async {
                      //               if (addToCart) {
                      //                 addToCart = false;
                      //                 await cartController
                      //                     .addMultipleCartToServer();
                      //                 await cartController
                      //                     .getCartListFromServer(
                      //                     shouldUpdate: true);
                      //               }
                      //             }
                      //                 : null,
                      //             buttonText:
                      //             (cartController.cartList.isNotEmpty &&
                      //                 cartController.cartList
                      //                     .elementAt(0)
                      //                     .serviceId ==
                      //                     widget.service!.id)
                      //                 ? 'update_cart'.tr
                      //                 : 'add_to_cart'.tr,
                      //           ),
                      //         )
                      //       ]),
                      //     ],
                      //   );
                      // }),
                    ],
                  );
                }
                return Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 20,
                      child: Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white70.withOpacity(0.6),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[
                                Get
                                    .find<ThemeController>()
                                    .darkTheme
                                    ? 700
                                    : 300]!,
                                blurRadius: 2,
                                spreadRadius: 1,
                              )
                            ]),
                        child: InkWell(
                            onTap: () => Get.back(),
                            child: const Icon(Icons.close)),
                      ),
                    ),
                    SizedBox(
                        height: Get.height / 7,
                        child: Center(
                            child: Text(
                              'no_variation_is_available'.tr,
                              style: ubuntuMedium.copyWith(
                                  fontSize: Dimensions.fontSizeLarge),
                            )))
                  ],
                );
              })
                  : const Center(child: CircularProgressIndicator());
            }),
          ),
        ),
      );
    });
  }

  /// show in api in provider list
  Rx<ServicewiseProviderModel> servicewiseProviderModel =
      ServicewiseProviderModel().obs;
  RxBool success = false.obs;

  Future<ServicewiseProviderModel> fetchServiceProviders() async {
    final String url =
        'https://admin.agnomy.com/api/v1/customer/service/providders';
    final String serviceId = widget.service!.id.toString();
    final String placeId = placedIdGloabal.value;
    final String? zoneId = addressModel?.zoneId.toString(); //
    final Uri uri = Uri.parse('$url?service_id=$serviceId&placeid=$placeId');
    final response = await http.get(
      uri,
      headers: {
        'zoneId': zoneId.toString(),
      },
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      refereshInt.value = DateTime.now().microsecondsSinceEpoch;
      return ServicewiseProviderModel.fromJson(json.decode(response.body));
    } else {
      refereshInt.value = DateTime
          .now()
          .microsecondsSinceEpoch;
      return ServicewiseProviderModel.fromJson(json.decode(response.body));
    }
  }


  /// add to provider to share in list
  Future<void> createQuote() async {
    final String serviceId = widget.service!.id.toString();
    final String categoryID = widget.service!.categoryId.toString();
    final String subCategoryID = widget.service!.subCategoryId.toString();


    final url = Uri.parse('https://admin.agnomy.com/api/v1/customer/create-quote');

    final request = http.MultipartRequest('POST', url)
      ..headers['Accept'] = 'application/json'
      ..fields['service_id'] = serviceId //'0d6aa3e6-20f3-4d36-83b2-ebf024ddf39e'
      ..fields['category_id'] = categoryID //'33f46f95-e8c0-4e91-86fb-0819ba4adebc'
      ..fields['sub_category_id'] = subCategoryID //'eaa49fe9-ae1c-41de-862f-9753d7fa20da'
      ..fields['guest_id'] = Get.find<SplashController>().getGuestId();
    print("Listttttttttttttttttt${jsonEncode(serviceProviderIDs)}");//'0d6aa3e6-20f3-4d36-83b2-ebf024ddf39f';

    // Add provider[] as repeated fields
    request.fields['provider'] = serviceProviderIDs != null ? jsonEncode(serviceProviderIDs) : jsonEncode(servesProviderIds); //'650c77e3-cdc1-46df-ba94-7769601c6462';
    //request.fields['provider[]'] = '0bedb82d-0ed5-45ff-a840-7dd31f033d65';

    try {
      final response = await request.send();

      if (response.statusCode == 200) {

        final responseBody = await response.stream.bytesToString();
        final responseData = jsonDecode(responseBody);
        print('Response data: $responseData');
      } else {
        print('Failed to create quote. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


}


class Remove {
  Map<dynamic,dynamic> servesProviderIds = {};

}