import 'dart:developer';

import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/checkout/widget/order_details_section/provider_details_card.dart';
import 'package:demandium/feature/checkout/widget/order_details_section/wallet_payment_card.dart';
import 'package:demandium/feature/checkout/widget/payment_section/quote_list.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../components/service_center_dialog1.dart';
import '../../../../data/model/quotelist-model.dart';
import '../../../service/widget/service_overview.dart';
import '../../model/provider-availability-model.dart';
import '../service_schedule2.dart';

class OrderDetailsPageWeb extends StatefulWidget {
  OrderDetailsPageWeb({Key? key}) : super(key: key);

  @override
  State<OrderDetailsPageWeb> createState() => _OrderDetailsPageWebState();
}

class _OrderDetailsPageWebState extends State<OrderDetailsPageWeb> {
  @override
  @override
  void initState() {
     getQuoteList();
     fetchProviderAvailability();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ConfigModel configModel = Get.find<SplashController>().configModel;
    bool showWalletPaymentCart = Get.find<AuthController>().isLoggedIn() &&
        Get.find<CartController>().walletBalance > 0 &&
        configModel.content?.walletStatus == 1 &&
        configModel.content?.partialPayment == 1;

    return Center(
        child:
        quotesListModel.value.content!= null ?
        SizedBox(
      width: Dimensions.webMaxWidth,
      child: GetBuilder<CartController>(builder: (cartController) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: WebShadowWrap(
                      minHeight: Get.height * 0.1,
                      child: Column(mainAxisSize: MainAxisSize.min, children: [

                        quotesListModel.value.content!.quoteData!.quoteProviders!.length == 1
                       // ServiceSchedule(),
                        ?

                        GetBuilder<ScheduleController>(  builder: (scheduleController){
                          return
                            Column( children: [

                              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                                child: Text("service_schedule".tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
                              ),

                              Container(
                                height: 70, width: Get.width,
                                padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                                margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: 2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.radiusSeven),
                                  border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.3), width: 0.5),
                                  color: Theme.of(context).hoverColor,
                                ),
                                child: Center(child: Row( children: [

                                  Expanded( flex: 7, child: Row( children: [

                                    Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                                      Text(" ${DateConverter.stringToLocalDateOnly(scheduleController.selectedData.toString()).substring(0,2)}",
                                        style: ubuntuMedium.copyWith( color: Theme.of(context).colorScheme.primary, fontSize: Dimensions.fontSizeOverLarge),
                                      ),
                                      Text(DateConverter.stringToLocalDateOnly(scheduleController.selectedData.toString()).substring(2),
                                        style: ubuntuRegular.copyWith(color: Theme.of(context).colorScheme.primary,),
                                      ),
                                    ]),

                                    const SizedBox(width: Dimensions.paddingSizeDefault),
                                    Container(height: 40, width: 1, color: Theme.of(context).colorScheme.primary,),
                                    const SizedBox(width: Dimensions.paddingSizeDefault),

                                    Column( crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                                      Text( DateConverter.dateToWeek(scheduleController.selectedData),
                                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                                      ),
                                      const SizedBox(height: Dimensions.paddingSizeMini,),
                                      Text( DateConverter.dateToTimeOnly(scheduleController.selectedData),
                                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                                      ),
                                    ]),
                                  ])),

                                  InkWell( onTap: () {
                                    scheduleController.selectDateRange();

                                    //_selectDate(context);

                                  },


                                      child: Image.asset(Images.editButton,width: 20.0,height: 20.0,)),

                                ])),
                              ),

                              const SizedBox(height: Dimensions.paddingSizeDefault),

                            ]);},
                      ) :

                        ServiceSchedule()
        ,




                      /////////////////////////////////////////////////////////////
                        const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeDefault),
                            child: AddressInformation()),
                        // (cartController.preSelectedProvider)
                        //     ? const ProviderDetailsCard()
                        //     : const SizedBox(),
                        const SizedBox(
                          height: Dimensions.paddingSizeDefault,
                        ),
                        //const ShowVoucher(),
                        showWalletPaymentCart
                            ? const WalletPaymentCard(
                                fromPage: "checkout",
                              )
                            : const SizedBox(),
                      ]))),
              const SizedBox(
                width: 50,
              ),
              Expanded(
                child: WebShadowWrap(
                    minHeight: Get.height * 0.1, child: CartSummery()
                    // child:  const QuoteList()
                    ),
              ),
            ]);
      }),
    )
            :Center(
          child: CircularProgressIndicator(),
        )

    );
  }



  //

  DateTime? selectedDate;
  TimeOfDay? selectedStartTime;

  final List<String> weekends = ["saturday", "sunday"];
  Map<String, String> timeSchedule = {
    "start_time": "14:44",
    "end_time": "",
  };
  int getDayValue(String day) {
    switch (day.toLowerCase()) {
      case "monday":
        return DateTime.monday;
      case "tuesday":
        return DateTime.tuesday;
      case "wednesday":
        return DateTime.wednesday;
      case "thursday":
        return DateTime.thursday;
      case "friday":
        return DateTime.friday;
      case "saturday":
        return DateTime.saturday;
      case "sunday":
        return DateTime.sunday;
      default:
        return -1; // Invalid day name
    }
  }

//date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      selectableDayPredicate: (DateTime date) {



        for(var element in weekends){

          log("ddddddd");
          if(date.weekday==getDayValue(element)){
            return false;
          }
        }

        return true;
      },
    );
    if (picked != null && picked != selectedDate) {
      print("Date:=> ${selectedDate}");
      // setState(() {
      selectedDate = picked;
      _selectStartTime(context);
      //});
    }
  }
// timestart
//   Future<void> _selectStartTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: selectedStartTime ?? TimeOfDay.now(),
//     );
//     if (picked != null && picked != selectedStartTime) {
//       //setState(() { // Ensure the state is updated
//       selectedStartTime = picked;
//       timeSchedule["start_time"] = picked.format(context);
//       print("Start Time: ${timeSchedule["start_time"]}");
//       //});
//     }
//   }
  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedStartTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != selectedStartTime) {
      // Check if the selected time is between 1 AM and 5 AM
      if ((picked.hour >= 1 && picked.hour < 5)) {
        // Show an error message or perform any desired action
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a time outside the range of 1 AM to 5 AM')),
        );
      } else {
        selectedStartTime = picked;
        timeSchedule["start_time"] = picked.format(context);
        print("Start Time: ${timeSchedule["start_time"]}");
      }
    }
  }




  //api call in provider single
  Rx<ProviderAvailabilityModel> providerAvailabilityModel = ProviderAvailabilityModel().obs;

  Future<void> fetchProviderAvailability() async {
    var headers = {
      'Accept': 'application/json',
    };
    var url = Uri.parse('https://admin.agnomy.com/api/v1/customer/provider-availability?provider_id=650c77e3-cdc1-46df-ba94-7769601c6462');

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      print(responseBody);
    } else {
      print('Failed to load data: ${response.reasonPhrase}');
    }
  }


  //get api call
  Rx<QuotesListModel> quotesListModel = QuotesListModel().obs;
  RxBool success = false.obs;

  Future<void> getQuoteList() async {
    print("quote id====>>>>>>>>${quote_id}");
    print("quote ids====>>>>>>>>${quote_ids}");
    print("quote ids====>>>>>>>>${quote_idss}");

    if (quote_id == null || quote_id.isEmpty) {
      quote_id = quote_ids;
      quote_ids = quote_idss;
    }

    final url = 'https://admin.agnomy.com/api/v1/customer/quote-list?quote_id=$quote_id';
    final headers = {
      'Accept' : 'application/json',
      'Authorization': "Bearer ${Get.find<SplashController>().splashRepo.apiClient.token.toString()}",
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      print('Response data: 2${response.body}');

      setState(() {
     //   refereshInt.value = DateTime.now().microsecondsSinceEpoch;
      });

      quotesListModel.value = QuotesListModel.fromJson(json.decode(response.body));
      print("DAta+=${quotesListModel.value.message.toString()}");
      Get.find<CartController>().update();
    } else {
      print('Failed to load quotes. Status code: 2${response.statusCode}');
     // refereshInt.value = DateTime.now().microsecondsSinceEpoch;
      quotesListModel.value = QuotesListModel.fromJson(json.decode(response.body));
      Get.find<CartController>().update();
    }
  }
}
