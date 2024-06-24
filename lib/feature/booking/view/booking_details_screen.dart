// ignore_for_file: deprecated_member_use

import 'package:demandium/feature/booking/controller/invoice_controller.dart';
import 'package:demandium/feature/booking/view/web_booking_details_screen.dart';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../../checkout/view/payment_screen.dart';

class BookingDetailsScreen extends StatefulWidget {
  final String bookingID;
  final String phone;
  final String fromPage;

  const BookingDetailsScreen({Key? key, required this.bookingID, required this.fromPage, required this.phone}) : super(key: key);

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> with SingleTickerProviderStateMixin {
  final scaffoldState = GlobalKey<ScaffoldState>();
  TabController? tabController;

  @override
  void initState() {
    AddressModel? addressModel = Get.find<LocationController>().selectedAddress ?? Get.find<LocationController>().getUserAddress();
    if(widget.fromPage == "track-booking") {
      Get.find<BookingDetailsController>().trackBookingDetails(widget.bookingID, "+${widget.phone.trim()}", reload: false);
    } else{
      Get.find<BookingDetailsController>().getBookingDetails(bookingId: widget.bookingID);
    }
    tabController = TabController(length: BookingDetailsTabs.values.length, vsync: this);
    super.initState();
    print("address${addressModel!.address.toString()}");
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(widget.fromPage == 'fromNotification') {
          Get.offAllNamed(RouteHelper.getInitialRoute());
          return false;
        }else {
          return true;
        }
      },
      child: Scaffold(
        endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
        appBar: CustomAppBar(
          title: "booking_details".tr,
          onBackPressed: () {
            if(widget.fromPage == 'fromNotification'){
              Get.offAllNamed(RouteHelper.getInitialRoute());
            }else{
              Get.back();
            }
          },
        ),
        body: RefreshIndicator(
          onRefresh: () async => Get.find<BookingDetailsController>().getBookingDetails(bookingId: widget.bookingID),

          child: ResponsiveHelper.isDesktop(context) ? WebBookingDetailsScreen(tabController: tabController) :
          DefaultTabController(
            length: 2, child: Column( mainAxisAlignment: MainAxisAlignment.start, children: [
              BookingTabBar(tabController: tabController),

              Expanded(child: TabBarView(controller: tabController, children: const [
                  BookingDetailsSection(),
                  BookingHistory(),
              ])),

          ],))
        ),
      ),
    );
  }
}

class BookingTabBar extends StatelessWidget {
  final TabController? tabController;
  const BookingTabBar({Key? key, this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingDetailsController>( builder: (bookingDetailsTabsController) {
      return Container(
        height: 45,
        color: Theme.of(context).cardColor,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.0),
            border: Border(bottom: BorderSide(color: Theme.of(context).primaryColor, width: 0.5),),
          ),
          child: Row(
            children: [
              Expanded(
                child: TabBar(
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  labelColor: Get.isDarkMode ? Colors.white : Theme.of(context).colorScheme.primary,
                  controller: tabController,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(child: Text('booking_details'.tr),),
                    Tab(child: Text('status'.tr),),
                  ],
                  onTap: (int? index) {
                    switch (index) {
                      case 0:bookingDetailsTabsController.updateBookingStatusTabs(BookingDetailsTabs.bookingDetails);
                      break;

                      case 1:bookingDetailsTabsController.updateBookingStatusTabs(BookingDetailsTabs.status);
                      break;
                    }
                  },
                ),
              ),

              !ResponsiveHelper.isDesktop(context) ? const SizedBox() :
              GetBuilder<BookingDetailsController>(builder: (bookingDetailsController){
                BookingDetailsContent? bookingDetailsContent = bookingDetailsController.bookingDetailsContent;

                return bookingDetailsContent != null ? Expanded(child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [




                   bookingDetailsContent.bookingStatus.toString() == "pending"
                       ?

                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child:  GetBuilder<CheckOutController>(builder: (checkoutController) {
                      return  InkWell(
                      onTap: (){
                       // String url = '${AppConstants.baseUrl}/payment?payment_method=${paymentMethod?.gateway}&access_token=${base64Url.encode(utf8.encode(userId))}&zone_id=$zoneId'
                       //      '&service_schedule=$schedule&service_address_id=$addressId&callback=$callbackUrl&service_address=$encodedAddress&is_partial=$isPartial&payment_platform=$platform';
                        checkoutController.updateState(PageState.payment);
                        Get.to(() => PaymentScreen(
                          url: '${AppConstants.baseUrl}/payment?payment_method=',
                          fromPage: "checkout",
                        ));

                        print(bookingDetailsContent.bookingStatus.toString());
                        print("payment");
                      },
                      child:

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge,vertical:4),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeEight),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                            border:Border.all(color: Theme.of(context).colorScheme.primary, width: 1),
                          ),
                          child:Center(child:
                              Text("Payment Now".tr, style: ubuntuMedium.copyWith(color: Theme.of(context).colorScheme.primary, fontSize: Dimensions.fontSizeSmall))),
                        ),
                      ),


                    );
                    }
                    ))
                       :



                   const SizedBox(height: 0,width: 0,),

                  Padding(padding: const EdgeInsets.all(6.0),
                    child: InkWell(
                      onTap : () async {
                        Get.dialog(const CustomLoader());
                        try {
                          var pdfFile = await InvoiceController.generateUint8List(
                              bookingDetailsContent,
                              bookingDetailsController.invoiceItems,
                              bookingDetailsController
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
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeEight),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                          border:Border.all(color: Theme.of(context).colorScheme.primary, width: 1),
                        ),
                        child: Row(
                          children: [
                            Text("invoice".tr, style: ubuntuMedium.copyWith(color: Theme.of(context).colorScheme.primary, fontSize: Dimensions.fontSizeSmall)),
                            const SizedBox(width: Dimensions.paddingSizeSmall),

                            SizedBox( height: 15, width: 15, child: Image.asset(Images.downloadImage)),
                          ],
                        ),
                      ),
                    ),

                  ),

                  const SizedBox(width: Dimensions.paddingSizeSmall),

                  bookingDetailsContent.bookingStatus == "completed" ||   bookingDetailsContent.bookingStatus == "pending"?
                  GetBuilder<ServiceBookingController>(
                      builder: (serviceBookingController) {
                        return InkWell(
                          onTap: () {
                            if(bookingDetailsContent.bookingStatus == "completed"){
                              serviceBookingController.checkCartSubcategory(bookingDetailsController.bookingDetailsContent!.id!, bookingDetailsController.bookingDetailsContent!.subCategoryId!);
                            }else{
                              Get.dialog(
                                  ConfirmationDialog(
                                    icon: Images.deleteProfile,
                                    title: 'are_you_sure_to_cancel_your_order'.tr, description: 'your_order_will_be_cancel'.tr,
                                    descriptionTextColor: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5),
                                    onYesPressed: () {
                                      bookingDetailsController.bookingCancel(bookingId: bookingDetailsController.bookingDetailsContent?.id ?? "");
                                      Get.back();
                                    },
                                  ), useSafeArea: false);
                            }
                          },

                          child: Container(
                            decoration: BoxDecoration(
                              color:Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                              border: Border.all(color: Theme.of(context).colorScheme.primary),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeEight, horizontal: Dimensions.paddingSizeLarge),
                            child: (serviceBookingController.isLoading) ?
                            Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault), child: SizedBox(height: 15, width:15, child: CircularProgressIndicator(color: Theme.of(context).colorScheme.onPrimary,))) :
                            Text(bookingDetailsContent.bookingStatus == "completed" ? "rebook".tr : "cancel_booking".tr, style: ubuntuMedium.copyWith(color: Theme.of(context).colorScheme.onPrimary)
                            ),
                          ),
                        );
                      }
                  ) : const SizedBox(),

                  bookingDetailsContent.bookingStatus == "completed" && Get.find<AuthController>().isLoggedIn() ?
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(context: context,
                        useRootNavigator: true, isScrollControlled: true,
                        backgroundColor: Colors.transparent, builder: (context) => ReviewRecommendationDialog(
                          id: bookingDetailsController.bookingDetailsContent!.id!,
                        ),
                      );
                      },
                    child: Container(
                      decoration: BoxDecoration(
                        color:Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                        border: Border.all(color: Theme.of(context).colorScheme.primary),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeEight, horizontal: Dimensions.paddingSizeLarge),
                      child: Text("review".tr, style: ubuntuMedium.copyWith(color: Theme.of(context).colorScheme.onPrimary)
                      ),
                    ),
                  ) : const SizedBox(),


                ],)) : const SizedBox();
              })
            ],
          ),
        ),
      );
    });
  }
}
