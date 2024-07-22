// ignore_for_file: deprecated_member_use
import 'dart:convert';
import 'dart:math';
import 'package:demandium/feature/booking/controller/invoice_controller.dart';
import 'package:demandium/feature/booking/view/web_booking_details_screen.dart';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:path/path.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import '../../../core/helper/checkout_helper.dart';
import '../../checkout/view/payment_screen.dart';

import 'package:universal_html/html.dart' as html;
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/approved_model.dart';

String status = "";

class BookingDetailsScreen extends StatefulWidget {
  final String bookingID;
  final String phone;
  final String fromPage;

  const BookingDetailsScreen(
      {Key? key,
      required this.bookingID,
      required this.fromPage,
      required this.phone})
      : super(key: key);

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen>
    with SingleTickerProviderStateMixin {
  final scaffoldState = GlobalKey<ScaffoldState>();
  TabController? tabController;

  @override
  void initState() {
    AddressModel? addressModel =
        Get.find<LocationController>().selectedAddress ??
            Get.find<LocationController>().getUserAddress();
    if (widget.fromPage == "track-booking") {
      Get.find<BookingDetailsController>().trackBookingDetails(
          widget.bookingID, "+${widget.phone.trim()}",
          reload: false);
    } else {
      Get.find<BookingDetailsController>()
          .getBookingDetails(bookingId: widget.bookingID);
    }
    tabController =
        TabController(length: BookingDetailsTabs.values.length, vsync: this);
    super.initState();
    print("address${addressModel!.address.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.fromPage == 'fromNotification') {
          Get.offAllNamed(RouteHelper.getInitialRoute());
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        endDrawer:
            ResponsiveHelper.isDesktop(context) ? const MenuDrawer() : null,
        appBar: CustomAppBar(
          title: "booking_details".tr,
          onBackPressed: () {
            if (widget.fromPage == 'fromNotification') {
              Get.offAllNamed(RouteHelper.getInitialRoute());
            } else {
              Get.back();
            }
          },
        ),
        body: RefreshIndicator(
            onRefresh: () async => Get.find<BookingDetailsController>()
                .getBookingDetails(bookingId: widget.bookingID),
            child: ResponsiveHelper.isDesktop(context)
                ? WebBookingDetailsScreen(tabController: tabController)
                : DefaultTabController(
                    length: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        BookingTabBar(tabController: tabController),
                        Expanded(
                            child: TabBarView(
                                controller: tabController,
                                children: const [
                              BookingDetailsSection(),
                              BookingHistory(),
                            ])),
                      ],
                    ))),
      ),
    );
  }
}

class BookingTabBar extends StatelessWidget {
  final TabController? tabController;
  BookingTabBar({Key? key, this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingDetailsController>(
        builder: (bookingDetailsTabsController) {
      return Container(
        height: 45,
        color: Theme.of(context).cardColor,
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.0),
            border: Border(
              bottom:
                  BorderSide(color: Theme.of(context).primaryColor, width: 0.5),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TabBar(
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  labelColor: Get.isDarkMode
                      ? Colors.white
                      : Theme.of(context).colorScheme.primary,
                  controller: tabController,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(
                      child: Text('booking_details'.tr),
                    ),
                    Tab(
                      child: Text('status'.tr),
                    ),
                  ],
                  onTap: (int? index) {
                    switch (index) {
                      case 0:
                        bookingDetailsTabsController.updateBookingStatusTabs(
                            BookingDetailsTabs.bookingDetails);
                        break;

                      case 1:
                        bookingDetailsTabsController
                            .updateBookingStatusTabs(BookingDetailsTabs.status);
                        break;
                    }
                  },
                ),
              ),
              !ResponsiveHelper.isDesktop(context)
                  ? const SizedBox()
                  : GetBuilder<BookingDetailsController>(
                      builder: (bookingDetailsController) {
                      BookingDetailsContent? bookingDetailsContent = bookingDetailsController.bookingDetailsContent;

                      // bool isPartialPayment = CheckoutHelper.checkPartialPayment(
                      //     walletBalance: cartController.walletBalance,
                      //     bookingAmount: cartController.totalPrice);
                      return bookingDetailsContent != null
                          ? Expanded(
                              child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // bookingDetailsContent.bookingStatus
                                //             .toString() ==
                                //         "pending"
                                //     ? Padding(
                                //         padding: const EdgeInsets.all(1.0),
                                //         child: GetBuilder<CheckOutController>(
                                //             builder: (checkoutController) {
                                //           AddressModel? addressModel =
                                //               Get.find<LocationController>()
                                //                       .selectedAddress ??
                                //                   Get.find<LocationController>()
                                //                       .getUserAddress();
                                //
                                //           return GetBuilder<CartController>(
                                //               builder: (cartController) {
                                //             bool isPartialPayment =
                                //                 CheckoutHelper
                                //                     .checkPartialPayment(
                                //                         walletBalance:
                                //                             cartController
                                //                                 .walletBalance,
                                //                         bookingAmount:
                                //                             cartController
                                //                                 .totalPrice);
                                //             return InkWell(
                                //               onTap: () {
                                //                 print(
                                //                     "addressModel=>${addressModel}");
                                //                 print(
                                //                     " checkoutController.selectedDigitalPaymentMethod=>${checkoutController.selectedDigitalPaymentMethod}");
                                //                 print(
                                //                     " isPartialPayment=>${isPartialPayment}");
                                //
                                //                 checkoutController.updateState(
                                //                     PageState.payment);
                                //                 if (GetPlatform.isWeb) {
                                //                   Get.toNamed(RouteHelper
                                //                       .getCheckoutRoute(
                                //                     'cart',
                                //                     Get.find<
                                //                             CheckOutController>()
                                //                         .currentPageState
                                //                         .name,
                                //                     pageState == 'payment'
                                //                         ? addressId.toString()
                                //                         : addressModel!.id
                                //                             .toString(),
                                //                     reload: false,
                                //                   ));
                                //                 }
                                //
                                //                 print(bookingDetailsContent
                                //                     .bookingStatus
                                //                     .toString());
                                //                 print("payment");
                                //               },
                                //               child: Padding(
                                //                 padding:
                                //                     const EdgeInsets.symmetric(
                                //                         horizontal: Dimensions
                                //                             .paddingSizeLarge,
                                //                         vertical: 4),
                                //                 child: Container(
                                //                   padding: const EdgeInsets
                                //                       .symmetric(
                                //                       horizontal: Dimensions
                                //                           .paddingSizeSmall,
                                //                       vertical: Dimensions
                                //                           .paddingSizeEight),
                                //                   decoration: BoxDecoration(
                                //                     borderRadius:
                                //                         BorderRadius.circular(
                                //                             Dimensions
                                //                                 .radiusDefault),
                                //                     border: Border.all(
                                //                         color: Theme.of(context)
                                //                             .colorScheme
                                //                             .primary,
                                //                         width: 1),
                                //                   ),
                                //                   child: Center(
                                //                       child: Text(
                                //                           "Payment Now".tr,
                                //                           style: ubuntuMedium.copyWith(
                                //                               color: Theme.of(
                                //                                       context)
                                //                                   .colorScheme
                                //                                   .primary,
                                //                               fontSize: Dimensions
                                //                                   .fontSizeSmall))),
                                //                 ),
                                //               ),
                                //             );
                                //           });
                                //         }))
                                //     : const SizedBox(
                                //         height: 0,
                                //         width: 0,
                                //       ),
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

                                                    if (GetPlatform.isWeb) {
                                                      Timer(const Duration(seconds: 1),
                                                          () {
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
                                                      });
                                                    }
                                                    print("payment");
                                                    ////////////////////////////////////
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6.0),
                                                    child: Container(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: Dimensions
                                                                .paddingSizeSmall),
                                                        // padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeEight),
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
                                    ? InkWell(
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: Dimensions
                                                          .paddingSizeSmall),
                                              //padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeEight),
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

                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: InkWell(
                                    onTap: () async {
                                      Get.dialog(const CustomLoader());
                                      try {
                                        var pdfFile = await InvoiceController
                                            .generateUint8List(
                                                bookingDetailsContent,
                                                bookingDetailsController
                                                    .invoiceItems,
                                                bookingDetailsController);
                                        Printing.layoutPdf(
                                          onLayout: (PdfPageFormat format) {
                                            return pdfFile;
                                          },
                                        );
                                      } catch (e) {
                                        if (kDebugMode) {
                                          print('=====${e.toString()}');
                                        }
                                      }
                                      Get.back();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              Dimensions.paddingSizeSmall,
                                          vertical:
                                              Dimensions.paddingSizeEight),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radiusDefault),
                                        border: Border.all(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            width: 1),
                                      ),
                                      child: Row(
                                        children: [
                                          Text("invoice".tr,
                                              style: ubuntuMedium.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  fontSize: Dimensions
                                                      .fontSizeSmall)),
                                          const SizedBox(
                                              width:
                                                  Dimensions.paddingSizeSmall),
                                          SizedBox(
                                              height: 15,
                                              width: 15,
                                              child: Image.asset(
                                                  Images.downloadImage)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                    width: Dimensions.paddingSizeSmall),
                                bookingDetailsContent.bookingStatus ==
                                            "completed" ||
                                        bookingDetailsContent.bookingStatus ==
                                            "pending"
                                    ? GetBuilder<ServiceBookingController>(
                                        builder: (serviceBookingController) {
                                        return InkWell(
                                          onTap: () {
                                            if (bookingDetailsContent
                                                    .bookingStatus ==
                                                "completed") {
                                              print("if");
                                              serviceBookingController
                                                  .checkCartSubcategory(
                                                      bookingDetailsController
                                                          .bookingDetailsContent!
                                                          .id!,
                                                      bookingDetailsController
                                                          .bookingDetailsContent!
                                                          .subCategoryId!);
                                            } else {
                                              print("else");
                                              // TextFormField();

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
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radiusDefault),
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical:
                                                    Dimensions.paddingSizeEight,
                                                horizontal: Dimensions
                                                    .paddingSizeLarge),
                                            child: (serviceBookingController
                                                    .isLoading)
                                                ? Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: Dimensions
                                                            .paddingSizeDefault),
                                                    child: SizedBox(
                                                        height: 15,
                                                        width: 15,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .onPrimary,
                                                        )))
                                                : Text(
                                                    bookingDetailsContent
                                                                .bookingStatus ==
                                                            "completed"
                                                        ? "rebook".tr
                                                        : "cancel_booking".tr,
                                                    style:
                                                        ubuntuMedium.copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onPrimary)),
                                          ),
                                        );
                                      })
                                    : const SizedBox(),
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
        ),
      );
    });
  }

  //payment screen methods=>ankur
  _makeDigitalPayment(AddressModel? address,
      DigitalPaymentMethod? paymentMethod, bool isPartialPayment) {
    String url = '';
    String hostname = html.window.location.hostname!;
    String protocol = html.window.location.protocol;
    String port = html.window.location.port;
    String? path = html.window.location.pathname;

    String schedule = DateConverter.dateToDateOnly(
        Get.find<ScheduleController>().selectedData);
    String userId = Get.find<UserController>().userInfoModel?.id ??
        Get.find<SplashController>().getGuestId();
    String encodedAddress =
        base64Encode(utf8.encode(jsonEncode(address?.toJson())));
    String addressId =
        (address?.id == "null" || address?.id == null) ? "" : address?.id ?? "";
    String zoneId =
        Get.find<LocationController>().getUserAddress()?.zoneId ?? "";
    String callbackUrl = GetPlatform.isWeb
        ? "$protocol//$hostname:$port$path"
        : AppConstants.baseUrl;
    int isPartial =
        Get.find<CartController>().walletPaymentStatus && isPartialPayment
            ? 1
            : 0;
    String platform = ResponsiveHelper.isWeb() ? "web" : "app";

    url =
        '${AppConstants.baseUrl}/payment?payment_method=${paymentMethod?.gateway}&access_token=${base64Url.encode(utf8.encode(userId))}&zone_id=$zoneId'
        '&service_schedule=$schedule&service_address_id=$addressId&callback=$callbackUrl&service_address=$encodedAddress&is_partial=$isPartial&payment_platform=$platform';

    if (GetPlatform.isWeb) {
      printLog("url_with_digital_payment 2:$url");
      html.window.open(url, "_self");
    } else {
      printLog("url_with_digital_payment_mobile m2:$url");
      Get.to(() => PaymentScreen(
            url: url,
            fromPage: "checkout",
          ));
    }
  }

  // Future<void> fetchOfferApproved() async {
  //   print("details in id :${Get.parameters['bookingID']!}");
  //   var headers = {
  //     'Authorization': 'Bearer ${Get.find<SplashController>().splashRepo.apiClient.token.toString()}'
  //   };
  //
  //   var request = http.Request(
  //       'GET',
  //       Uri.parse('https://admin.agnomy.com/api/v1/customer/booking/offer-approved/5625d510-b8b1-41ac-bd28-fcd5ea27a4a8')
  //   );
  //
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     print(response.body)
  //     String responseBody = await response.stream.bytesToString();
  //     print(responseBody);
  //     // return ApprovedModel.fromJson()
  //   } else {
  //     print('Request failed with status: ${response.statusCode}. ${response.reasonPhrase}');
  //   }
  // }

  //api hit function Approved
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
