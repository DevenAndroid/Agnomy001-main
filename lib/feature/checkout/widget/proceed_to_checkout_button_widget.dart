import 'dart:convert';

import 'package:demandium/components/core_export.dart';
import 'package:demandium/components/service_center_dialog1.dart';
import 'package:demandium/core/helper/checkout_helper.dart';
import 'package:demandium/feature/cart/widget/available_provider_widgets.dart';
import 'package:demandium/feature/checkout/view/payment_screen.dart';
import 'package:path/path.dart';
import 'package:universal_html/html.dart' as html;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
 String? pageState;
 String? addressId;
class ProceedToCheckoutButtonWidget extends StatefulWidget {
  final String pageState;
  final String addressId;
  const ProceedToCheckoutButtonWidget(
      {Key? key, required this.pageState, required this.addressId})
      : super(key: key);

  @override
  State<ProceedToCheckoutButtonWidget> createState() =>
      _ProceedToCheckoutButtonWidgetState();
}

class _ProceedToCheckoutButtonWidgetState
    extends State<ProceedToCheckoutButtonWidget> {

  Future<void> checkoutSummeryApiCall() async {
    print("proceed_to_checkout");
    print("question_input");
    print("quote_id${quote_id}");
    print("zoneId${ Get.find<LocationController>().getUserAddress()!.zoneId.toString()}");
    if (questionController.text != null &&
        messageController.text != null &&
        questionController.text.isNotEmpty &&
        messageController.text.isNotEmpty) {
      var url = Uri.parse(
          'https://admin.agnomy.com/api/v1/customer/checkout-summery');

      var request = http.MultipartRequest('POST', url)

        ..headers['Authorization'] = "Bearer ${Get.find<SplashController>().splashRepo.apiClient.token.toString()}"
        ..fields['question_input'] = questionController.text
        ..fields['service_description'] = messageController.text
        ..fields['quote_id'] = quote_id
        ..fields['zone_id'] =  Get.find<LocationController>().getUserAddress()!.zoneId.toString();

      try {
        var response = await request.send();
        if (response.statusCode == 200) {
          var responseData = await http.Response.fromStream(response);
          print('Response data checkoutSummeryApiCall: ${responseData.body}');

        } else {
          customSnackBar(
              "please enter the field it is required",duration:2);
          print('Request failed with status: ${response.statusCode}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }







  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController) {
      DateTime selectedStartTime =  Get.find<ScheduleController>().selectedData;

      List<CartModel> cartList = cartController.cartList;
      bool walletPaymentStatus = cartController.walletPaymentStatus;
      double totalAmount = cartController.totalPrice;

      bool isPartialPayment = CheckoutHelper.checkPartialPayment(
          walletBalance: cartController.walletBalance,
          bookingAmount: cartController.totalPrice);
      double dueAmount = CheckoutHelper.calculateDueAmount(
          cartList: cartList,
          walletPaymentStatus: walletPaymentStatus,
          walletBalance: cartController.walletBalance,
          bookingAmount: cartController.totalPrice);
      String schedule = DateConverter.dateToDateAndTime(
          Get.find<ScheduleController>().selectedData);


      return GetBuilder<CheckOutController>(builder: (checkoutController) {
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeSmall),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Text(
                          '${cartController.walletPaymentStatus && isPartialPayment ? "due_amount".tr : ""} ',
                          style: ubuntuRegular.copyWith(
                            fontSize: Dimensions.fontSizeLarge,
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          )),
                      // Directionality(
                      //   textDirection: TextDirection.ltr,
                      //   child: Text(PriceConverter.convertPrice(  cartController.walletPaymentStatus && isPartialPayment ? dueAmount :totalAmount),
                      //     style: ubuntuBold.copyWith(
                      //       color: Theme.of(context).colorScheme.error,
                      //       fontSize: Dimensions.fontSizeLarge,
                      //     ),
                      //   ),
                      // ),
                    ]))),
            InkWell(
              onTap: () {
                AddressModel? addressModel = Get.find<LocationController>().selectedAddress ?? Get.find<LocationController>().getUserAddress();
                 if (Get.find<AuthController>().acceptTerms) {



                  if (Get.find<CartController>().cartList.isEmpty) {

                    //Get.offAllNamed(RouteHelper.getMainRoute('home'));

                    print('if 1');

                    // if (questionController.text != null &&
                    //     messageController.text != null &&
                    //     questionController.text.isNotEmpty &&
                    //     messageController.text.isNotEmpty)
                    //
                    // {
                    if(Get.find<CartController>().cartList.isNotEmpty) {
                      print("if payment");
                      _makeDigitalPayment(
                          addressModel,
                          checkoutController.selectedDigitalPaymentMethod,
                          isPartialPayment);
                    }

                  //    checkoutSummeryApiCall();

                    // }
                    //
                    // else {
                    //   print("error in textfrom feild");
                    //   customSnackBar("please enter the field it is required",duration:2);
                    //
                    // }

                   // Get.offAllNamed(RouteHelper.getMainRoute('home'));
                  }
                  else if (cartController.cartList.isNotEmpty &&
                      cartController.preSelectedProvider &&
                      cartController.cartList[0].provider != null &&
                      (cartController.cartList[0].provider?.serviceAvailability == 0 ||
                          cartController.cartList[0].provider?.isActive == 0)) {
                    print('if 2');

                    Future.delayed(const Duration(milliseconds: 50))
                        .then((value) {
                      Future.delayed(const Duration(milliseconds: 500))
                          .then((value) {
                        showModalBottomSheet(
                          useRootNavigator: true,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) => AvailableProviderWidget(
                            subcategoryId: Get.find<CartController>()
                                .cartList
                                .first
                                .subCategoryId,
                            showUnavailableError: true,
                          ),
                        );
                      });

                      customSnackBar("your_selected_provider_is_unavailable_right_now".tr, duration: 3);
                    });
                  } else if (checkoutController.currentPageState ==
                          PageState.orderDetails &&
                      PageState.orderDetails.name == widget.pageState) {


                    print('if 3');

                    if (!Get.find<ScheduleController>().checkScheduleTime()) {
                      print('if 4');

                      customSnackBar(
                          "${"schedule_time_should_be".tr} ${AppConstants.scheduleTime} ${"later_from_now".tr}");
                    }
                  else if (addressModel == null) {
                      print('if 5');

                      customSnackBar("add_address_first".tr);
                    } else if ((addressModel.contactPersonName == "null" ||
                            addressModel.contactPersonName == null ||
                            addressModel.contactPersonName!.isEmpty) ||
                        (addressModel.contactPersonNumber == "null" ||
                            addressModel.contactPersonNumber == null ||
                            addressModel.contactPersonNumber!.isEmpty)) {
                      print('if 6');

                      customSnackBar(
                          "please_input_contact_person_name_and_phone_number"
                              .tr);
                    } else {
                      print('if 7');
                      if (!isPartialPayment &&
                          cartController.walletPaymentStatus) {
                        print('if 8');

                        checkoutController.placeBookingRequest(
                          paymentMethod: "wallet_payment",
                          schedule: schedule,
                          isPartial: 0,
                          address: addressModel,
                        );
                      }

                      else {
                        print('if 9');

                        // if (questionController.text != null &&
                        //     messageController.text != null &&
                        //     questionController.text.isNotEmpty &&
                        //     messageController.text.isNotEmpty)
                        //
                        // {
                          //checkoutController.updateState(PageState.payment); // payment vali screen pe navigation in use for
                          if (GetPlatform.isWeb) {

                            ///

                            // Get.toNamed(RouteHelper.getCheckoutRoute(
                            //   'cart',
                            //   Get.find<CheckOutController>()
                            //       .currentPageState.name,
                            //   widget.pageState == 'payment'
                            //       ? widget.addressId
                            //       : addressModel.id.toString(),
                            //   reload: false,
                            // ));
///
                            DateTime selectedStartTime =  Get.find<ScheduleController>().selectedData;

                            checkoutController.placeBookingRequest(
                              paymentMethod: "offline_payment",
                              schedule: selectedStartTime.toString(),
                              isPartial: isPartialPayment && cartController.walletPaymentStatus
                                  ? 1
                                  : 0,
                              address: addressModel!,
                              offlinePaymentId:
                              checkoutController.selectedOfflineMethod?.id,
                              customerInformation: base64Url.encode(utf8.encode(
                                  jsonEncode(checkoutController
                                      .offlinePaymentInputFieldValues))),
                            );

                          }


                      //  Get.toNamed(RouteHelper.getCheckoutRoute('cart',Get.find<CheckOutController>().currentPageState.name,"null"));
                          checkoutSummeryApiCall();
                          questionController.clear();
                          messageController.clear();

                        //}

                        // else {
                        //   print("error in textfrom feild");
                        //   customSnackBar("please enter the field it is required",duration:2);
                        //
                        // }


                      }
                    }
                  } else if (checkoutController.currentPageState ==
                          PageState.payment ||
                      PageState.orderDetails.name == widget.pageState) {
                    print('if 10');

                    if (checkoutController.selectedPaymentMethod ==
                        PaymentMethodName.none) {
                      customSnackBar("select_payment_method".tr);
                      print('if 11');
                    } else if (checkoutController.selectedPaymentMethod ==
                        PaymentMethodName.cos) {
                      print('if 12');

                      checkoutController.placeBookingRequest(
                        paymentMethod: "cash_after_service",
                        schedule: schedule,
                        isPartial: isPartialPayment &&
                                cartController.walletPaymentStatus
                            ? 1
                            : 0,
                        address: addressModel!,
                      );
                    } else if (checkoutController.selectedPaymentMethod ==
                        PaymentMethodName.walletMoney) {
                      print('if 13');

                      if (Get.find<CartController>().walletBalance >=
                          Get.find<CartController>().totalPrice) {
                        print('if 14');

                        checkoutController.placeBookingRequest(
                            paymentMethod: "wallet_payment",
                            schedule: schedule,
                            isPartial: 0,
                            address: addressModel!);
                      } else {
                        print('if 15');

                        customSnackBar("insufficient_wallet_balance".tr);
                      }
                    } else if (checkoutController.selectedPaymentMethod ==
                        PaymentMethodName.offline) {
                      print('if 16');

                      if (checkoutController.selectedOfflineMethod != null &&
                          checkoutController.showOfflinePaymentInputData) {
                        print('if 17');

                        checkoutController.placeBookingRequest(
                          paymentMethod: "offline_payment",
                          schedule: schedule,
                          isPartial: isPartialPayment &&
                                  cartController.walletPaymentStatus
                              ? 1
                              : 0,
                          address: addressModel!,
                          offlinePaymentId:
                              checkoutController.selectedOfflineMethod?.id,
                          customerInformation: base64Url.encode(utf8.encode(
                              jsonEncode(checkoutController
                                  .offlinePaymentInputFieldValues))),
                        );
                      } else {
                        print('if 18');

                        customSnackBar("provide_offline_payment_info".tr);
                      }
                    } else if (checkoutController.selectedPaymentMethod ==
                        PaymentMethodName.digitalPayment) {
                      print('if 19');

                      if (checkoutController.selectedDigitalPaymentMethod !=
                              null && checkoutController.selectedDigitalPaymentMethod?.gateway !=
                              "offline") {
                        print('if 20');

                        _makeDigitalPayment(
                            addressModel,
                            checkoutController.selectedDigitalPaymentMethod,
                            isPartialPayment);
                      } else {
                        print('if 21');

                        customSnackBar("select_any_payment_method".tr);
                      }
                    }
                  }
               }
                else {
                  print('if 22');


                  customSnackBar('please_agree_with_terms_conditions');
                }
              },
              child: checkoutController.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      height: ResponsiveHelper.isDesktop(context) ? 50 : 45,
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radiusDefault)),
                      child: Center(
                        child: Text(
                          !isPartialPayment && cartController.walletPaymentStatus
                              ? "place_booking".tr
                              : 'proceed_to_checkout'.tr,
                          style: ubuntuMedium.copyWith(
                            color: Theme.of(context).primaryColorLight,
                            fontSize: Dimensions.fontSizeDefault,
                          ),
                        ),
                      ),
                    ),
            ),
          ]),
        );
      });
    });
  }

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
    String encodedAddress = base64Encode(utf8.encode(jsonEncode(address?.toJson())));
    String addressId = (address?.id == "null" || address?.id == null) ? "" : address?.id ?? "";
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
      printLog("url_with_digital_payment:$url");
      html.window.open(url, "_self");
    } else {
      printLog("url_with_digital_payment_mobile m1:$url");
      Get.to(() => PaymentScreen(
            url: url,
            fromPage: "checkout",
          ));
    }
  }







}
