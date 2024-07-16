import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/booking/controller/invoice_controller.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class BookingInfo extends StatelessWidget {
  final BookingDetailsContent bookingDetailsContent;
  final BookingDetailsController bookingDetailsTabController;
  const BookingInfo({Key? key, required this.bookingDetailsContent, required this.bookingDetailsTabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).cardColor , borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          border: Border.all(color: Theme.of(context).hintColor.withOpacity(0.3)), boxShadow: searchBoxShadow
      ),//boxShadow: shadow),
      child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [

          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start ,children: [
            Column( crossAxisAlignment: CrossAxisAlignment.start ,children: [
              Text('${'booking'.tr} #${bookingDetailsContent.readableId}',
                style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge,
                    color: Theme.of(context).textTheme.bodyLarge!.color,decoration: TextDecoration.none),
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              ],
            ),

            Container(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall-2,horizontal: Dimensions.paddingSizeDefault),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                  // color: Theme.of(context).hintColor)
                   color:   bookingDetailsContent.bookingStatus == "ongoing"
                       ? Theme.of(context).colorScheme.primary.withOpacity(.5)
                       :  bookingDetailsContent.bookingStatus == "pending"
                       ? Theme.of(context).colorScheme.error.withOpacity(.2) //Theme.of(context).colorScheme.primary
                       .withOpacity(.2)
                       :  bookingDetailsContent.bookingStatus == "accepted"
                       ? Theme.of(context).colorScheme.error.withOpacity(.2)
                       :  bookingDetailsContent.bookingStatus == "completed"
                       ? Theme.of(context).colorScheme.primary
                       : Theme.of(context).colorScheme.primary.withOpacity(.5)
              )

              ,


              child: Text(bookingDetailsContent.bookingStatus?.tr ?? "",
                style:ubuntuMedium.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: Dimensions.fontSizeSmall,
                  color:  bookingDetailsContent.bookingStatus == "ongoing"
                      ? Theme.of(context).colorScheme.primary
                      : bookingDetailsContent.bookingStatus == "pending"
                      ? Theme.of(context).colorScheme.error
                      : bookingDetailsContent.bookingStatus == "accepted"
                      ? Theme.of(context).colorScheme.error
                      : bookingDetailsContent.bookingStatus == "completed"
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.primary
                  // bookingDetailsContent.bookingStatus=="ongoing" ? Theme.of(context).colorScheme.tertiary:
                  // bookingDetailsContent.bookingStatus=="pending" ? Theme.of(context).colorScheme.primary:
                  // bookingDetailsContent.bookingStatus=="accepted" ? Theme.of(context).colorScheme.tertiary:
                  // bookingDetailsContent.bookingStatus=="completed" ? Theme.of(context).colorScheme.tertiary:
                  // const Color(0xffFF3737),
                ),
              ),
            )
          ]),

          Gaps.verticalGapOf(Dimensions.paddingSizeSmall),
          BookingItem(
            img: Images.iconCalendar,
            title: "${'booking_date'.tr} : ",
            date: DateConverter.localDateToIsoString(DateConverter.isoUtcStringToLocalDate(bookingDetailsContent.createdAt!)),
          ),


          Gaps.verticalGapOf(Dimensions.paddingSizeExtraSmall),
          BookingItem(
            img: Images.bscheduled,
            title: "${'Service Date'.tr} : ",
            date:   DateConverter.localDateToIsoString(DateTime.tryParse(bookingDetailsContent.serviceSchedule!)!),
          ),
          Gaps.verticalGapOf(Dimensions.paddingSizeExtraSmall),


          BookingItem(
            img: Images.iconLocation,
            title: '${'address'.tr} : ${bookingDetailsContent.serviceAddress != null?
            bookingDetailsContent.serviceAddress!.address! : 'no_address_found'.tr}',
            date: '',
          ),

           Gaps.verticalGapOf(Dimensions.paddingSizeDefault),

           Center(
             child: InkWell(
               onTap: () async{
                 Get.dialog(const CustomLoader());
                 try {
                   var pdfFile = await InvoiceController.generateUint8List(
                       bookingDetailsContent,
                       bookingDetailsTabController.invoiceItems,
                       bookingDetailsTabController
                   );
                   Printing.layoutPdf(
                     onLayout: (PdfPageFormat format) {
                       return pdfFile;
                     },
                   );

                 }catch(e) {
                   if (kDebugMode) {
                     print('=====${e.toString()}');
                   }
                 }
                 Get.back();
               },
               child: Row( mainAxisSize: MainAxisSize.min, children: [
                   Text('download'.tr,
                     style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge,
                         color: Theme.of(context).colorScheme.tertiary, decoration: TextDecoration.none),
                   ),
                   Gaps.horizontalGapOf(Dimensions.paddingSizeSmall),

                   SizedBox( height: 20, width: 20, child: Image.asset(Images.downloadImage)),
                 ],
               ),
             ),
           ),

           Gaps.verticalGapOf(Dimensions.paddingSizeDefault),
          // Text("payment_method".tr,
          //   style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge!.color),
          // ),
          // Gaps.verticalGapOf(Dimensions.paddingSizeExtraSmall),
          //
          // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          //   Text("${bookingDetailsContent.paymentMethod!.tr} ${ bookingDetailsContent.partialPayments !=null  && bookingDetailsContent.partialPayments!.isNotEmpty ? "&_wallet_balance".tr: ""}",
          //       style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.5))),
          //   RichText(text: TextSpan(
          //     text: "${'payment_status'.tr} : ",
          //     style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.5)),
          //     children: <TextSpan>[
          //       TextSpan(
          //         text: bookingDetailsContent.partialPayments != null && bookingDetailsContent.partialPayments!.isNotEmpty && bookingDetailsContent.isPaid == 0
          //             ? "partially_paid".tr : bookingDetailsContent.isPaid == 1 ? "paid".tr : "unpaid".tr,
          //         style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeSmall,color :
          //         bookingDetailsContent.partialPayments != null && bookingDetailsContent.partialPayments!.isNotEmpty && bookingDetailsContent.isPaid == 0
          //             ? Theme.of(context).colorScheme.primary : bookingDetailsContent.isPaid == 0 ? Theme.of(context).colorScheme.error: Colors.green),
          //       )
          //     ]
          //   )),
          // ]),
          // Gaps.verticalGapOf(Dimensions.paddingSizeExtraSmall),
          //
          // if(bookingDetailsContent.transactionId != "cash-payment")
          // Text("${'transaction_id'.tr} : ${bookingDetailsContent.transactionId}",
          //   style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).hintColor),),
          //
          // Row( children: [
          //   Text("${'amount'.tr}:",
          //     style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,
          //       color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
          //     ),
          //   ),
          //   const SizedBox(width: Dimensions.paddingSizeSmall,),
          //   Directionality(
          //     textDirection: TextDirection.ltr,
          //     child: Text(PriceConverter.convertPrice(bookingDetailsContent.totalBookingAmount!.toDouble()),
          //       style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,
          //           color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8)),
          //     ),
          //   ),
          // ]),



        ]),
      ),
    );
  }
}
