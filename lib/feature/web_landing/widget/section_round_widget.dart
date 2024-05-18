import 'package:demandium/components/custom_image.dart';
import 'package:demandium/controller/localization_controller.dart';
import 'package:demandium/feature/web_landing/controller/web_landing_controller.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';


class SectionRoundWidget extends StatelessWidget {
  final WebLandingController webLandingController;
  final Map<String?,String?>? textContent;
  final String baseUrl;
  final PageController _pageController = PageController();

  SectionRoundWidget({
    Key? key,
    required this.webLandingController,
    required this.textContent,
    required this.baseUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLtr = Get.find<LocalizationController>().isLtr;

    return Container(
      height: Dimensions.webSectionRoundHeight, width: Dimensions.webExtraMaxWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusExtraMoreLarge),

        color: Get.isDarkMode?Theme.of(context).primaryColorDark:Theme.of(context).colorScheme.onPrimary,
      ),
      child: Align( alignment: Alignment.center, child: SizedBox(width: Dimensions.webMaxWidth, child: Row( mainAxisAlignment: MainAxisAlignment.center, children: [

        Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
          child: CustomImage(
            height: 75,
            width: 75,
            image:"$baseUrl/landing-page/web/ag-logo-wht.png",
            fit: BoxFit.fitHeight,
          ),
        ),


        Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: Column( mainAxisSize: MainAxisSize.min,  crossAxisAlignment: CrossAxisAlignment.start, children: [

            Text("The All In One Platform",
              style: ubuntuTitle.copyWith(fontSize: 36, color: Colors.white, ), textAlign: TextAlign.center,
            ),

            Text("Available on iOS, Android, and the web",
              style: ubuntuRegular.copyWith(fontSize: 18, color: Colors.grey), textAlign: TextAlign.center,
            ),
          ]),
        ),



      ]))),
    );
  }
}
