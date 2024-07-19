import 'package:demandium/components/image_dialog.dart';
import 'package:demandium/feature/booking/widget/booking_cancel_button.dart';
import 'package:demandium/feature/booking/widget/booking_otp_widget.dart';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/booking/widget/booking_summery_widget.dart';
import 'package:demandium/feature/booking/widget/provider_info.dart';
import 'package:demandium/feature/booking/widget/service_man_info.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import '../../../core/helper/checkout_helper.dart';
import '../controller/invoice_controller.dart';
import 'booking_screen_shimmer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookingDetailsSection extends StatelessWidget {

  const BookingDetailsSection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<BookingDetailsController>( builder: (bookingDetailsTabController) {

        if(bookingDetailsTabController.bookingDetailsContent != null){

          BookingDetailsContent? bookingDetailsContent =  bookingDetailsTabController.bookingDetailsContent;
          String bookingStatus = bookingDetailsContent?.bookingStatus ?? "";
          bool isLoggedIn = Get.find<AuthController>().isLoggedIn();

            return SingleChildScrollView( physics: const BouncingScrollPhysics(), child: Center(
              child: Padding( padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [

                  const SizedBox(height: Dimensions.paddingSizeEight),
                  BookingInfo(bookingDetailsContent: bookingDetailsContent!, bookingDetailsTabController: bookingDetailsTabController),

                  (Get.find<SplashController>().configModel.content!.confirmationOtpStatus! && (bookingStatus == "accepted" || bookingStatus== "ongoing")) ?
                  BookingOtpWidget(bookingDetailsContent: bookingDetailsContent) :

                 Row(
                   children: [
                     GetBuilder<BookingDetailsController>(
                         builder: (bookingDetailsController) {
                           BookingDetailsContent? bookingDetailsContent =
                               bookingDetailsController.bookingDetailsContent;
                           return bookingDetailsContent != null
                               ? Expanded(
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.end,
                                 children: [
                                   bookingDetailsContent.bookingStatus ==
                                       "Accepted"
                                       ? GetBuilder<CheckOutController>(
                                       builder: (checkoutController) {
                                         AddressModel? addressModel =
                                             Get.find<LocationController>()
                                                 .selectedAddress ??
                                                 Get.find<LocationController>()
                                                     .getUserAddress();
                                         return GetBuilder<CartController>(
                                             builder: (cartController) {
                                               bool isPartialPayment = CheckoutHelper
                                                   .checkPartialPayment(
                                                   walletBalance: cartController
                                                       .walletBalance,
                                                   bookingAmount: cartController
                                                       .totalPrice);
                                               return
                                                 //  status != "200" ?
                                                 bookingDetailsContent.customerBookingStatus.toString() =="0" ?
                                                 InkWell(
                                                   onTap: () {
                                                     fetchOfferApproved();
                                                     //////////////////////////////////
                                                     print(
                                                         "addressModel=>${addressModel}");
                                                     print(
                                                         "addressModel=>${addressId.toString()}");
                                                     print(
                                                         "addressModel=>${addressModel!.id.toString()}");
                                                     print(
                                                         " checkoutController.selectedDigitalPaymentMethod=>${checkoutController.selectedDigitalPaymentMethod}");
                                                     print(
                                                         " isPartialPayment=>${isPartialPayment}");

                                                     checkoutController.updateState(PageState.payment);

                                                     // if (GetPlatform.isWeb) {
                                                     //   Timer(const Duration(seconds: 1),
                                                     //           ()
                                                     //       {

                                                             Get.toNamed(RouteHelper
                                                                 .getCheckoutRoute(
                                                               'cart',
                                                               Get.find<
                                                                   CheckOutController>()
                                                                   .currentPageState
                                                                   .name,
                                                               pageState == 'payment'
                                                                   ? addressId
                                                                   .toString()
                                                                   : addressModel!.id
                                                                   .toString(),
                                                               reload: false,
                                                             ));
                                                     //       });
                                                     // }
                                                     print("payment");
                                                     ////////////////////////////////////
                                                   },
                                                   child: Padding(
                                                     padding:
                                                     const EdgeInsets.all(6.0),
                                                     child: Container(
                                                        // padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                                                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeEight),
                                                         decoration:
                                                         BoxDecoration(
                                                           borderRadius: BorderRadius
                                                               .circular(Dimensions
                                                               .radiusDefault),
                                                           border: Border.all(
                                                               color: Theme.of(
                                                                   context)
                                                                   .colorScheme
                                                                   .primary,
                                                               width: 1),
                                                         ),
                                                         child: Center(
                                                           child: Text(
                                                               "accept".tr,
                                                               style: ubuntuMedium.copyWith(
                                                                   color: Theme.of(
                                                                       context)
                                                                       .colorScheme
                                                                       .primary,
                                                                   fontSize:
                                                                   Dimensions
                                                                       .fontSizeSmall)),
                                                         )),
                                                   ),
                                                 )
                                                     :SizedBox(height: 0,width: 0,)


                                               ;

                                             });
                                       })
                                       : SizedBox(
                                     height: 0,
                                     width: 0,
                                   ),
                                   SizedBox(width: 1),
                                   bookingDetailsContent.bookingStatus ==
                                       "Accepted"
                                       ?
                                   InkWell(
                                     onTap: () {
                                       Get.dialog(
                                           ConfirmationDialog(
                                             icon: Images.deleteProfile,
                                             title:
                                             'are_you_sure_to_cancel_your_order'
                                                 .tr,
                                             description:
                                             'your_order_will_be_cancel'
                                                 .tr,
                                             descriptionTextColor:
                                             Theme.of(context)
                                                 .textTheme
                                                 .bodyLarge!
                                                 .color!
                                                 .withOpacity(0.5),
                                             onYesPressed: () {
                                               bookingDetailsController
                                                   .bookingCancel(
                                                   bookingId:
                                                   bookingDetailsController
                                                       .bookingDetailsContent
                                                       ?.id ??
                                                       "");
                                               Get.back();
                                             },
                                           ),
                                           useSafeArea: false);
                                     },
                                     child: Padding(
                                       padding: const EdgeInsets.all(6.0),
                                       child: Container(
                                          // padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                                           padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeEight),
                                           decoration: BoxDecoration(
                                             borderRadius:
                                             BorderRadius.circular(
                                                 Dimensions
                                                     .radiusDefault),
                                             border: Border.all(
                                                 color: Theme.of(context)
                                                     .colorScheme
                                                     .primary,
                                                 width: 1),
                                           ),
                                           child: Center(
                                             child: Text("decline".tr,
                                                 style: ubuntuMedium.copyWith(
                                                     color: Theme.of(context)
                                                         .colorScheme
                                                         .primary,
                                                     fontSize: Dimensions
                                                         .fontSizeSmall)),
                                           )),
                                     ),
                                   )
                                       : SizedBox(
                                     height: 0,
                                     width: 0,
                                   ),

                                   // Padding(
                                   //   padding: const EdgeInsets.all(6.0),
                                   //   child: InkWell(
                                   //     onTap: () async {
                                   //       Get.dialog(const CustomLoader());
                                   //       try {
                                   //         var pdfFile = await InvoiceController
                                   //             .generateUint8List(
                                   //             bookingDetailsContent,
                                   //             bookingDetailsController
                                   //                 .invoiceItems,
                                   //             bookingDetailsController);
                                   //         Printing.layoutPdf(
                                   //           onLayout: (PdfPageFormat format) {
                                   //             return pdfFile;
                                   //           },
                                   //         );
                                   //       } catch (e) {
                                   //         if (kDebugMode) {
                                   //           print('=====${e.toString()}');
                                   //         }
                                   //       }
                                   //       Get.back();
                                   //     },
                                   //     child: Container(
                                   //       padding: const EdgeInsets.symmetric(
                                   //           horizontal:
                                   //           Dimensions.paddingSizeSmall,
                                   //           vertical:
                                   //           Dimensions.paddingSizeEight),
                                   //       decoration: BoxDecoration(
                                   //         borderRadius: BorderRadius.circular(
                                   //             Dimensions.radiusDefault),
                                   //         border: Border.all(
                                   //             color: Theme.of(context)
                                   //                 .colorScheme
                                   //                 .primary,
                                   //             width: 1),
                                   //       ),
                                   //       child: Row(
                                   //         children: [
                                   //           Text("invoice".tr,
                                   //               style: ubuntuMedium.copyWith(
                                   //                   color: Theme.of(context)
                                   //                       .colorScheme
                                   //                       .primary,
                                   //                   fontSize: Dimensions
                                   //                       .fontSizeSmall)),
                                   //           const SizedBox(
                                   //               width:
                                   //               Dimensions.paddingSizeSmall),
                                   //           SizedBox(
                                   //               height: 15,
                                   //               width: 15,
                                   //               child: Image.asset(
                                   //                   Images.downloadImage)),
                                   //         ],
                                   //       ),
                                   //     ),
                                   //   ),
                                   // ),

                                   const SizedBox(
                                       width: Dimensions.paddingSizeSmall),
                                   // bookingDetailsContent.bookingStatus ==
                                   //     "completed" ||
                                   //     bookingDetailsContent.bookingStatus ==
                                   //         "pending"
                                   //     ?
                                   // GetBuilder<ServiceBookingController>(
                                   //     builder: (serviceBookingController) {
                                   //       return InkWell(
                                   //         onTap: () {
                                   //           if (bookingDetailsContent
                                   //               .bookingStatus ==
                                   //               "completed") {
                                   //             print("if");
                                   //             serviceBookingController
                                   //                 .checkCartSubcategory(
                                   //                 bookingDetailsController
                                   //                     .bookingDetailsContent!
                                   //                     .id!,
                                   //                 bookingDetailsController
                                   //                     .bookingDetailsContent!
                                   //                     .subCategoryId!);
                                   //           } else {
                                   //             print("else");
                                   //             // TextFormField();
                                   //
                                   //             Get.dialog(
                                   //                 ConfirmationDialog(
                                   //                   icon: Images.deleteProfile,
                                   //                   title:
                                   //                   'are_you_sure_to_cancel_your_order'
                                   //                       .tr,
                                   //                   description:
                                   //                   'your_order_will_be_cancel'
                                   //                       .tr,
                                   //                   descriptionTextColor:
                                   //                   Theme.of(context)
                                   //                       .textTheme
                                   //                       .bodyLarge!
                                   //                       .color!
                                   //                       .withOpacity(0.5),
                                   //                   onYesPressed: () {
                                   //                     bookingDetailsController
                                   //                         .bookingCancel(
                                   //                         bookingId:
                                   //                         bookingDetailsController
                                   //                             .bookingDetailsContent
                                   //                             ?.id ??
                                   //                             "");
                                   //                     Get.back();
                                   //                   },
                                   //                 ),
                                   //                 useSafeArea: false);
                                   //           }
                                   //         },
                                   //         child: Container(
                                   //           decoration: BoxDecoration(
                                   //             color: Theme.of(context)
                                   //                 .colorScheme
                                   //                 .primary,
                                   //             borderRadius:
                                   //             BorderRadius.circular(
                                   //                 Dimensions.radiusDefault),
                                   //             border: Border.all(
                                   //                 color: Theme.of(context)
                                   //                     .colorScheme
                                   //                     .primary),
                                   //           ),
                                   //           padding: const EdgeInsets.symmetric(
                                   //               vertical:
                                   //               Dimensions.paddingSizeEight,
                                   //               horizontal: Dimensions
                                   //                   .paddingSizeLarge),
                                   //           child: (serviceBookingController
                                   //               .isLoading)
                                   //               ?
                                   //           Padding(
                                   //               padding: const EdgeInsets
                                   //                   .symmetric(
                                   //                   horizontal: Dimensions
                                   //                       .paddingSizeDefault),
                                   //               child: SizedBox(
                                   //                   height: 15,
                                   //                   width: 15,
                                   //                   child:
                                   //                   CircularProgressIndicator(
                                   //                     color:
                                   //                     Theme.of(context)
                                   //                         .colorScheme
                                   //                         .onPrimary,
                                   //                   )))
                                   //               : Text(
                                   //               bookingDetailsContent
                                   //                   .bookingStatus ==
                                   //                   "completed"
                                   //                   ? "rebook".tr
                                   //                   : "cancel_booking".tr,
                                   //               style:
                                   //               ubuntuMedium.copyWith(
                                   //                   color: Theme.of(
                                   //                       context)
                                   //                       .colorScheme
                                   //                       .onPrimary)),
                                   //         ),
                                   //       );
                                   //     })
                                   //     : const SizedBox()
                                   //,
                                   bookingDetailsContent.bookingStatus ==
                                       "completed" &&
                                       Get.find<AuthController>().isLoggedIn()
                                       ? InkWell(
                                     onTap: () {
                                       showModalBottomSheet(
                                         context: context,
                                         useRootNavigator: true,
                                         isScrollControlled: true,
                                         backgroundColor: Colors.transparent,
                                         builder: (context) =>
                                             ReviewRecommendationDialog(
                                               id: bookingDetailsController
                                                   .bookingDetailsContent!.id!,
                                             ),
                                       );
                                     },
                                     child: Container(
                                       decoration: BoxDecoration(
                                         color: Theme.of(context)
                                             .colorScheme
                                             .primary,
                                         borderRadius: BorderRadius.circular(
                                             Dimensions.radiusDefault),
                                         border: Border.all(
                                             color: Theme.of(context)
                                                 .colorScheme
                                                 .primary),
                                       ),
                                       margin: const EdgeInsets.symmetric(
                                           horizontal:
                                           Dimensions.paddingSizeSmall),
                                       padding: const EdgeInsets.symmetric(
                                           vertical:
                                           Dimensions.paddingSizeEight,
                                           horizontal:
                                           Dimensions.paddingSizeLarge),
                                       child: Text("review".tr,
                                           style: ubuntuMedium.copyWith(
                                               color: Theme.of(context)
                                                   .colorScheme
                                                   .onPrimary)),
                                     ),
                                   )
                                       : const SizedBox(),
                                 ],
                               ))
                               : const SizedBox();
                         })

                   ],
                 ),


                  //const SizedBox(),
                  const SizedBox(height: Dimensions.paddingSizeEight),

                  Container(
                    decoration: BoxDecoration(color: Theme.of(context).cardColor , borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                        border: Border.all(color: Theme.of(context).hintColor.withOpacity(0.3)), boxShadow: searchBoxShadow
                    ),//boxShadow: shadow),
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('payment_method'.tr, style:ubuntuBold.copyWith(
                          fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color!, decoration: TextDecoration.none,
                        )),
                        const SizedBox(height: Dimensions.radiusDefault),
                        bookingDetailsContent.isPaid == 0?
                        Text(""):
                        Text(
                            bookingDetailsContent.paymentMethod!.tr,
                            style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)),
                            overflow: TextOverflow.ellipsis),
                        const SizedBox(height: Dimensions.radiusDefault),
                        bookingDetailsContent.isPaid == 0?
                        Text(""):
                        Text(
                            '${'transaction_id'.tr} : ${bookingDetailsContent.transactionId ?? ''}',
                            style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)),
                            overflow: TextOverflow.ellipsis),
                      ],
                      ),

                      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                        Text( '${bookingDetailsContent.isPaid == 0 ? 'unpaid'.tr: 'paid'.tr} ',
                            style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,
                                color: bookingDetailsContent.isPaid == 0?Theme.of(context).colorScheme.error : Colors.green, decoration: TextDecoration.none)
                        ),
                        const SizedBox(height: Dimensions.paddingSizeExtraLarge),


                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                              PriceConverter.convertPrice(bookingDetailsContent.quoteOfferedPrice!.toDouble(),isShowLongPrice: true),
                              style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).colorScheme.primary,)),
                        ),
                      ]),
                    ]),
                  ),

                  bookingDetailsContent.posts!= null &&   bookingDetailsContent.posts!.latestbid!= null
                      ? Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(
                            Dimensions.radiusDefault),
                        border: Border.all(
                            color: Theme.of(context)
                                .hintColor
                                .withOpacity(0.3)),
                        boxShadow: searchBoxShadow), //boxShadow: shadow),
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeDefault,
                        vertical: Dimensions.paddingSizeSmall),
                    child: Column(
                      children: [
                        Text("Service Provider Offer Info",
                            style:ubuntuBold.copyWith(fontSize: Dimensions.fontSizeExtraSmall)),
                        Gaps.verticalGapOf(Dimensions.paddingSizeDefault),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text("Provider Notes :-",
                                style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall,
                                    color: Theme.of(context).textTheme.bodyLarge!.color!)),
                            SizedBox(
                              width: Get.width*0.6,
                              child: Text(bookingDetailsContent.posts!.latestbid!.providerNote ?? "",
                                  style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color!)),
                            ),

                          ],
                        ),
                      ],
                    ),
                  )
                  // Row(
                  //
                  //  //mainAxisAlignment: MainAxisAlignment.start,
                  //   //crossAxisAlignment: CrossAxisAlignment.start,
                  //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     SizedBox(
                  //       height: 200, width:540,
                  //       child: Container(
                  //         width:double.infinity,
                  //         decoration: BoxDecoration(color: Theme.of(context).cardColor , borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                  //             border: Border.all(color: Theme.of(context).hintColor.withOpacity(0.3)), boxShadow: searchBoxShadow
                  //         ),
                  //         child: Padding(
                  //           padding: const EdgeInsets.symmetric(horizontal: 8),
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             mainAxisAlignment:MainAxisAlignment.start,
                  //             children: [
                  //               Gaps.verticalGapOf(Dimensions.paddingSizeDefault),
                  //               Padding(
                  //                   padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  //                   child: Text("Service Provider Offer Info",
                  //                       style:ubuntuBold.copyWith(fontSize: Dimensions.fontSizeExtraSmall))
                  //               ),
                  //               Gaps.verticalGapOf(Dimensions.paddingSizeSmall),
                  //               Row(
                  //                 children: [
                  //                   Text("Provider Notes :-",
                  //                       style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall,
                  //                           color: Theme.of(context).textTheme.bodyLarge!.color!)),
                  //
                  //                   Text(bookingDetailsContent.posts!.latestbid!.providerNote ?? "",
                  //                       style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color!)),
                  //
                  //                 ],
                  //               )
                  //
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(height: 0,width: 0,)
                  //   ],
                  // )
                      : SizedBox(),

                  const SizedBox(height: Dimensions.paddingSizeDefault),
                  BookingSummeryWidget(bookingDetailsContent: bookingDetailsContent),

                  const SizedBox(height: Dimensions.paddingSizeDefault),
                  bookingDetailsContent.provider != null ? ProviderInfo(provider: bookingDetailsContent.provider!) : const SizedBox(),
                  const SizedBox(height: Dimensions.paddingSizeSmall),

                  bookingDetailsContent.serviceman != null ? ServiceManInfo(user: bookingDetailsContent.serviceman!.user!) : const SizedBox(),
                  const SizedBox(height: Dimensions.paddingSizeSmall),

                  bookingDetailsContent.photoEvidence != null && bookingDetailsContent.photoEvidence!.isNotEmpty ?
                  Padding( padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                      const SizedBox(height: Dimensions.paddingSizeDefault,),
                      Text('completed_service_picture'.tr,  style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor),),
                      const SizedBox(height: Dimensions.paddingSizeSmall),

                      Container(
                        height: 90,
                        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: bookingDetailsContent.photoEvidence?.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                child: GestureDetector(
                                  onTap: () => showDialog(context: context, builder: (ctx)  =>
                                    ImageDialog(
                                      imageUrl:"${Get.find<SplashController>().configModel.content?.imageBaseUrl}/booking/evidence/${bookingDetailsContent.photoEvidence?[index]??""}",
                                      title: "completed_service_picture".tr,
                                      subTitle: "",
                                    )
                                  ),
                                  child: CustomImage(
                                    image: "${Get.find<SplashController>().configModel.content?.imageBaseUrl}/booking/evidence/${bookingDetailsContent.photoEvidence?[index]??""}",
                                    height: 70, width: 120,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),


                    ],
                    ),
                  ): const SizedBox(),

                  const BookingCancelButton(),

                  SizedBox(height: bookingStatus == "completed" && isLoggedIn ? Dimensions.paddingSizeExtraLarge * 3 : Dimensions.paddingSizeExtraLarge ),

                ]),
              ),
            ),
          );
        }else{
          return const SingleChildScrollView(child: BookingScreenShimmer());
        }
      }),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
      GetBuilder<BookingDetailsController>(builder: (bookingDetailsController){
        if(bookingDetailsController.bookingDetailsContent !=null ){
          return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            const Expanded(child: SizedBox()),
            Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault, left: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault,),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [

                Get.find<AuthController>().isLoggedIn()?
                FloatingActionButton( hoverColor: Colors.transparent, elevation: 0.0,
                  backgroundColor: Theme.of(context).colorScheme.primary, onPressed: () {
                    BookingDetailsContent bookingDetailsContent = bookingDetailsController.bookingDetailsContent!;

                    if (bookingDetailsContent.provider != null ) {
                      showModalBottomSheet( useRootNavigator: true, isScrollControlled: true,
                        backgroundColor: Colors.transparent, context: context, builder: (context) => CreateChannelDialog(
                          customerID: bookingDetailsContent.customerId,
                          providerId: bookingDetailsContent.provider?.userId ,
                          serviceManId:  bookingDetailsContent.serviceman?.userId,
                          referenceId: bookingDetailsContent.readableId.toString(),
                        ),
                      );
                    } else {
                      customSnackBar('provider_or_service_man_assigned'.tr);
                    }
                  },
                  child: Icon(Icons.message_rounded, color: Theme.of(context).primaryColorLight),
                ) : const SizedBox(),
              ]),
            ),

            bookingDetailsController.bookingDetailsContent!.bookingStatus == 'completed' ?
            Padding(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  Get.find<AuthController>().isLoggedIn() ?
                  Expanded(
                    child: CustomButton (radius: 5, buttonText: 'review'.tr, onPressed: () {
                      showModalBottomSheet(context: context,
                        useRootNavigator: true, isScrollControlled: true,
                        backgroundColor: Colors.transparent, builder: (context) => ReviewRecommendationDialog(
                          id: bookingDetailsController.bookingDetailsContent!.id!,
                        ),
                      );},
                    ),
                  ) : const SizedBox(),


                  Get.find<AuthController>().isLoggedIn() ? const SizedBox(width: 15,): const SizedBox(),

                  GetBuilder<ServiceBookingController>(
                    builder: (serviceBookingController) {
                      return Expanded(
                        child: CustomButton(
                          radius: 5,
                          isLoading: serviceBookingController.isLoading,
                          buttonText: "rebook".tr,
                          onPressed: () {
                            serviceBookingController.checkCartSubcategory(bookingDetailsController.bookingDetailsContent!.id!, bookingDetailsController.bookingDetailsContent!.subCategoryId!);
                          },
                        ),
                      );
                    }
                  ),
                ],
              ),
            )
            : const SizedBox()

          ]);
        }else{
          return const SizedBox();
        }
      }),
    );




  }

  Future<void> fetchOfferApproved() async {
    print("details in id :${Get.parameters['bookingID']!}");
    String? bookingid = Get.parameters['bookingID'];
    var headers = {
      'Authorization':
      'Bearer ${Get.find<SplashController>().splashRepo.apiClient.token.toString()}'
    };

    var request = http.Request(
        'GET',
        Uri.parse(
            'https://admin.agnomy.com/api/v1/customer/booking/offer-approved/${bookingid}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    status = response.statusCode.toString();
    print("AAAAAAAAAAAA${status}");
    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print(responseBody);
      Map<String, dynamic> jsonResponse = json.decode(responseBody);
      String messagepa = jsonResponse['message'];
      print(messagepa);

      customSnackBar(messagepa.toString(), backgroundColor: Colors.green);
    } else {
      print(
          'Request failed with status: ${response.statusCode}. ${response.reasonPhrase}');
    }
  }
}
