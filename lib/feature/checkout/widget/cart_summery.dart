import 'dart:convert';
import 'package:demandium/components/service_center_dialog1.dart';
import 'package:http/http.dart' as http;
import 'package:demandium/core/helper/checkout_helper.dart';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/checkout/widget/row_text.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import '../../../data/model/quotelist-model.dart';

TextEditingController questionController = TextEditingController();
TextEditingController messageController = TextEditingController();

class CartSummery extends StatefulWidget {
  CartSummery({Key? key}) : super(key: key);

  @override
  State<CartSummery> createState() => _CartSummeryState();
}

class _CartSummeryState extends State<CartSummery> {
  RxInt refereshInt = 0.obs;
  @override
  void initState() {

    getQuoteList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController) {
      final tooltipController = JustTheController();
      ConfigModel configModel = Get.find<SplashController>().configModel;
      List<CartModel> cartList = cartController.cartList;
      bool walletPaymentStatus = cartController.walletPaymentStatus;

      double additionalCharge = CheckoutHelper.getAdditionalCharge();
      bool isPartialPayment = CheckoutHelper.checkPartialPayment(
          walletBalance: cartController.walletBalance,
          bookingAmount: cartController.totalPrice);
      double paidAmount = CheckoutHelper.calculatePaidAmount(
          walletBalance: cartController.walletBalance,
          bookingAmount: cartController.totalPrice);
      double subTotalPrice =
          CheckoutHelper.calculateSubTotal(cartList: cartList);
      double disCount = CheckoutHelper.calculateDiscount(
          cartList: cartList, discountType: DiscountType.general);
      double campaignDisCount = CheckoutHelper.calculateDiscount(
          cartList: cartList, discountType: DiscountType.campaign);
      double couponDisCount = CheckoutHelper.calculateDiscount(
          cartList: cartList, discountType: DiscountType.coupon);
      double vat = CheckoutHelper.calculateVat(cartList: cartList);
      double grandTotal =
          CheckoutHelper.calculateGrandTotal(cartList: cartList);
      double dueAmount = CheckoutHelper.calculateDueAmount(
          cartList: cartList,
          walletPaymentStatus: walletPaymentStatus,
          walletBalance: cartController.walletBalance,
          bookingAmount: cartController.totalPrice);

      return quotesListModel.value.content != null
          ? Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeDefault),
                    child: Text('Provider info',
                        style: ubuntuMedium.copyWith(
                            fontSize: Dimensions.fontSizeDefault))),
                ListView.builder(
                  itemCount: quotesListModel
                      .value.content!.quoteData!.quoteProviders!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return

                      Container(
                      decoration: BoxDecoration(color: Theme.of(context).cardColor , borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                        border: Border.all(color: Theme.of(context).hintColor.withOpacity(0.3)),
                      ),
                      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                      margin: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),

                      child:  Row(children: [
                        ClipRRect( borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                          child: CustomImage(
                            image: "${Get.find<SplashController>().configModel.content!.imageBaseUrl}/provider/logo/${quotesListModel.value.content!.quoteData!.quoteProviders![index].logo.toString()}",
                            height: 60,width: 60,),
                        ),
                        const SizedBox(width: Dimensions.paddingSizeDefault,),

                        Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,children: [
                          Text(quotesListModel.value.content!.quoteData!.quoteProviders![index].providerName
                              ?? "",
                              style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                              maxLines: 1, overflow: TextOverflow.ellipsis),

                          Text.rich(TextSpan(
                              style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8)),
                              children:  [


                                WidgetSpan(child: Icon(Icons.star,color: Theme.of(context).colorScheme.primaryContainer,size: 15,), alignment: PlaceholderAlignment.middle),
                                const TextSpan(text: " "),
                                TextSpan(text: "0",style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault))

                              ])),
                        ],)
                      ]),
                    );


                    //   Container(
                    //   decoration: BoxDecoration(
                    //       color: Get.isDarkMode
                    //           ? Theme.of(context).hoverColor
                    //           : Theme.of(context).cardColor,
                    //       boxShadow: Get.isDarkMode ? null : shadow),
                    //   child: Padding(
                    //     padding:
                    //         const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    //     child: Row(
                    //       children: [
                    //         Container(
                    //           height: 40,
                    //           width: 40,
                    //           child: ClipRRect(
                    //             borderRadius: BorderRadius.circular(50),
                    //             child: CachedNetworkImage(
                    //               imageUrl: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}/provider/logo/${quotesListModel.value.content!.quoteData!.quoteProviders![index].logo.toString()}',
                    //                 //imageUrl: quotesListModel.value.content!.quoteData!.quoteProviders![index].logo.toString(),
                    //                 errorWidget: (_, __, ___) =>
                    //                 const Icon(
                    //                   Icons.person,
                    //                   color: Colors.white,
                    //                 ),
                    //                 placeholder: (_, __) =>
                    //                 const Icon(
                    //                   Icons.person,
                    //                   color: Colors.white,
                    //                 ),
                    //             // child: Image.network(quotesListModel
                    //             //     .value.content!.quoteData!
                    //             //     .quoteProviders![index]
                    //             //     .logo.toString(),
                    //             fit: BoxFit.cover,
                    //             //
                    //             // ),
                    //           ),
                    //         ),
                    //         ),
                    //         const SizedBox(
                    //           width: 10,
                    //         ),
                    //         Column(
                    //           children: [
                    //             Text(quotesListModel.value.content!.quoteData!
                    //                 .quoteProviders![index].providerName
                    //                 .toString()),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // );
                  },
                ),
                Divider(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6)),
                Container(
                  decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? Theme.of(context).hoverColor
                          : Theme.of(context).cardColor,
                      boxShadow: Get.isDarkMode ? null : shadow),
                  child: Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Column(
                      children: [
                        // Divider(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6)),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Service summary",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: ubuntuRegular.copyWith(
                                    fontSize: Dimensions.fontSizeDefault),
                              ),
                              Container(
                                height:114,
                                width: Get.width*0.2,
                                color: Colors.transparent,
                                child: Text(quotesListModel.value.content!.quoteData!
                                    .serviceShortDescription.toString(),
                                  // overflow: TextOverflow.ellipsis,softWrap: true,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Service category",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: ubuntuRegular.copyWith(
                                    fontSize: Dimensions.fontSizeDefault),
                              ),
                              Text(quotesListModel
                                  .value.content!.quoteData!.subCategoryName
                                  .toString())
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Selected services ",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: ubuntuRegular.copyWith(
                                    fontSize: Dimensions.fontSizeDefault),
                              ),
                              Text(quotesListModel
                                  .value.content!.quoteData!.serviceName
                                  .toString())
                            ],
                          ),
                        ),
                        CustomTextField(
                          controller: messageController,
                          title: 'question ask'.tr,
                          hintText: 'please enter the question'.tr,
                          // controller: authController.signInPhoneController,
                          // focusNode: _phoneFocus,
                          capitalization: TextCapitalization.words,
                          // onValidate: (String? value){
                          //   return (GetUtils.isEmail(value.tr)) ? null : 'enter_email_or_phone'.tr;
                          // },
                        ),
                        CustomTextField(
                          controller: questionController,
                          title: 'message'.tr, //service description box
                          hintText: 'please enter the your message'
                              .tr, //please enter the service description
                          // controller: authController.signInPhoneController,
                          // focusNode: _phoneFocus,
                          capitalization: TextCapitalization.words,
                          // onValidate: (String? value){
                          //   return (GetUtils.isEmail(value.tr)) ? null : 'enter_email_or_phone'.tr;
                          // },
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeSmall,
                              vertical: Dimensions.paddingSizeSmall),
                          child: ConditionCheckBox(),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            );
      // return Column( children: [
      //
      //   Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
      //     child: Text( 'Provider info'.tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault))
      //   ),
      //
      //   Container(
      //     decoration: BoxDecoration( color: Get.isDarkMode ? Theme.of(context).hoverColor : Theme.of(context).cardColor, boxShadow:Get.isDarkMode ? null : shadow ),
      //     child: Padding( padding: const EdgeInsets.all( Dimensions.paddingSizeDefault),
      //       child: Column( children: [
      //
      //         ListView.builder(
      //           itemCount: cartList.length,
      //           shrinkWrap: true,
      //           physics: const NeverScrollableScrollPhysics(),
      //           itemBuilder: (context,index){
      //             double totalCost = cartList.elementAt(index).serviceCost.toDouble() * cartList.elementAt(index).quantity;
      //             return Column( mainAxisAlignment: MainAxisAlignment.start,  crossAxisAlignment: CrossAxisAlignment.start, children: [
      //               RowText(title: cartList.elementAt(index).service!.name!, quantity: cartList.elementAt(index).quantity, price: totalCost),
      //               SizedBox( width:Get.width / 2.5,
      //                 child: Text( cartList.elementAt(index).variantKey,
      //                   style: ubuntuMedium.copyWith( color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.4), fontSize: Dimensions.fontSizeSmall),
      //                   maxLines: 2, overflow: TextOverflow.ellipsis,
      //                 ),
      //               ),
      //               const SizedBox(height: Dimensions.paddingSizeDefault,)
      //             ]);
      //           },
      //         ),
      //
      //         Divider(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6)),
      //         const SizedBox(height: Dimensions.paddingSizeExtraSmall),
      //
      //         // RowText(title: 'sub_total'.tr, price: subTotalPrice),
      //         // RowText(title: 'discount'.tr, price: disCount),
      //         // RowText(title: 'campaign_discount'.tr, price: campaignDisCount),
      //         // RowText(title: 'coupon_discount'.tr, price: couponDisCount),
      //         // RowText(title: 'vat'.tr, price: vat),
      //         RowText(title: 'Service summary'.tr, price: vat),
      //         RowText(title: 'Service category'.tr, price: vat),
      //         RowText(title: 'selected service'.tr, price: vat),
      //
      //         // (configModel.content?.additionalChargeLabelName != "" && configModel.content?.additionalCharge == 1) ?
      //         // GetBuilder<CheckOutController>(builder: (controller){
      //         //   return  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
      //         //     Expanded(
      //         //       child: Row(children: [
      //         //         Flexible(child: Text(configModel.content?.additionalChargeLabelName ?? "", style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault),overflow: TextOverflow.ellipsis,)),
      //         //         JustTheTooltip(
      //         //           backgroundColor: Colors.black87, controller: tooltipController,
      //         //           preferredDirection: AxisDirection.down, tailLength: 14, tailBaseWidth: 20,
      //         //           content: Padding( padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      //         //             child:  Column( mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start ,children: [
      //         //               Text(configModel.content?.additionalChargeLabelName ?? "", style: ubuntuRegular.copyWith(color: Colors.white70),),
      //         //             ]),
      //         //           ),
      //         //           child:  Padding( padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
      //         //             child: InkWell( onTap: ()=> tooltipController.showTooltip(),
      //         //               child: const Icon(Icons.info_outline_rounded, size: Dimensions.paddingSizeDefault,),
      //         //             ),
      //         //           )
      //         //         ),
      //         //       ],),
      //         //     ),
      //         //   //  Text("(+) ${PriceConverter.convertPrice( additionalCharge, isShowLongPrice: true)}", style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)
      //         //   ],);
      //         // }): const SizedBox(),
      //
      //
      //         Padding( padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
      //           child: Divider(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6)),
      //         ),
      //
      //         RowText(title:'grand_total'.tr , price: grandTotal),
      //         (Get.find<CartController>().walletPaymentStatus) ? RowText(title:'paid_by_wallet'.tr , price: paidAmount) : const SizedBox(),
      //         (Get.find<CartController>().walletPaymentStatus && isPartialPayment) ? RowText(title:'due_amount'.tr , price: dueAmount) : const SizedBox(),
      //       ]),
      //     ),
      //   ),
      //
      //
      //   const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
      //     child: ConditionCheckBox(),
      //   ),
      //
      // ]);
    });
  }



  //get api call
  Rx<QuotesListModel> quotesListModel = QuotesListModel().obs;
  RxBool success = false.obs;

  Future<void> getQuoteList() async {
    final url =
        'https://admin.agnomy.com/api/v1/customer/quote-list?quote_id=$quote_id';
    final headers = {
      'Accept' : 'application/json',
      'Authorization': "Bearer ${Get.find<SplashController>().splashRepo.apiClient.token.toString()}",
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    // final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print('Response data: 2${response.body}');

      setState(() {
        refereshInt.value = DateTime.now().microsecondsSinceEpoch;
      });

      quotesListModel.value = QuotesListModel.fromJson(json.decode(response.body));
      print("DAta+=${quotesListModel.value.message.toString()}");
      Get.find<CartController>().update();
    } else {
      print('Failed to load quotes. Status code: 2${response.statusCode}');
      refereshInt.value = DateTime.now().microsecondsSinceEpoch;
      quotesListModel.value =
          QuotesListModel.fromJson(json.decode(response.body));
      Get.find<CartController>().update();
    }
  }


}
