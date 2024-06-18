import 'dart:convert';

import 'package:demandium/data/model/quotelist-model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../components/custom_text_field.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/styles.dart';
import '../../../auth/widgets/condition_check_box.dart';
import '../../../splash/controller/splash_controller.dart';
class QuoteList extends StatefulWidget {
  const QuoteList({super.key});

  @override
  State<QuoteList> createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {
  @override
@override
  void initState() {

    final quoteId ='2176e147-6233-4468-8104-24b4b320628b';
    getQuoteList(quoteId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return

      Column(
    children: [
      Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Dimensions.paddingSizeDefault),
          child: Text('Provider info',
              style: ubuntuMedium.copyWith(
                  fontSize: Dimensions.fontSizeDefault))),


      ListView.builder(
        itemCount:quotesListModel.value.content!.quoteData!.quoteProviders!.length ,
        shrinkWrap: true,
        itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              color: Get.isDarkMode
                  ? Theme.of(context).hoverColor
                  : Theme.of(context).cardColor,
              boxShadow: Get.isDarkMode ? null : shadow),
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Row(
              children: [
                Container(
                  height:25,
                  width:25,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(quotesListModel.value.content!.quoteData!.quoteProviders![index].logo.toString()),
                  ),
                ),
                const SizedBox(width: 40,),
                Column(
                  children: [
                    Text(quotesListModel.value.content!.quoteData!.quoteProviders![index].providerName.toString()),
                  ],
                ),
              ],
            ),
          ),

        );
      },),


      Container(
        decoration: BoxDecoration(
            color: Get.isDarkMode
                ? Theme.of(context).hoverColor
                : Theme.of(context).cardColor,
            boxShadow: Get.isDarkMode ? null : shadow),
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(
          children: [
           // Divider(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6)),

            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Service summary", maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: ubuntuRegular.copyWith(
                        fontSize: Dimensions.fontSizeDefault),),
                  Text(quotesListModel.value.content!.quoteData!.serviceShortDescription.toString())
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Service category", maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: ubuntuRegular.copyWith(
                        fontSize: Dimensions.fontSizeDefault),),
                  Text(quotesListModel.value.content!.quoteData!.subCategoryName.toString())
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Selected services ", maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: ubuntuRegular.copyWith(
                        fontSize: Dimensions.fontSizeDefault),),
                  Text(quotesListModel.value.content!.quoteData!.serviceName.toString())
                ],
              ),
            ),
            CustomTextField(
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



    ;
  }
}

Rx<QuotesListModel> quotesListModel= QuotesListModel().obs;
RxBool success = false.obs;

Future<QuotesListModel> getQuoteList(String quoteId) async {
  final url ='https://admin.agnomy.com/api/v1/customer/quote-list?quote_id=$quoteId'; //'https://admin.agnomy.com/api/v1/customer/quote-list?guest_id=$guestId';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    print('Response data: ${response.body}');
    return QuotesListModel.fromJson(json.decode(response.body));
  } else {
    print('Failed to load quotes. Status code: ${response.statusCode}');
    return QuotesListModel.fromJson(json.decode(response.body));
  }




  // post api














}











// post api
Future<void> checkoutSummeryApiCall() async {
  var url = Uri.parse('https://admin.agnomy.com/api/v1/customer/checkout-summery');

  var request = http.MultipartRequest('POST', url)
    ..fields['question_input'] = 'dsafdsf'
    ..fields['service_description'] = 'd333333333'
    ..fields['quote_id'] = '46536da6-ed71-4ef8-a83f-c864c30ec9f0';

  try {
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await http.Response.fromStream(response);
      print('Response data: ${responseData.body}');
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}