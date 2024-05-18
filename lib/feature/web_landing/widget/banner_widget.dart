import 'package:demandium/components/custom_image.dart';
import 'package:demandium/controller/localization_controller.dart';
import 'package:demandium/feature/web_landing/controller/web_landing_controller.dart';
import 'package:demandium/feature/web_landing/model/web_landing_model.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerWidget extends StatelessWidget {
  final WebLandingController webLandingController;
  final Map<String?,String?>? textContent;
  final String baseUrl;
  final PageController _pageController = PageController();

  BannerWidget({
    Key? key,
    required this.webLandingController,
    required this.textContent,
    required this.baseUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLtr = Get.find<LocalizationController>().isLtr;

    return Container(
      color: Theme.of(context).primaryColor,
      height: Dimensions.webLandingBannerHeight, width: Get.width,

      child: Align( alignment: Alignment.center, child: SizedBox(width: Dimensions.webMaxWidth, child: Row( mainAxisAlignment: MainAxisAlignment.center, children: [

        Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
          child: CustomImage(
            height: 100,
            width: 450,
            image:"$baseUrl/landing-page/web/logo-bg-white.png",
            fit: BoxFit.fitHeight,
          ),
        ),

        Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
          child: Text(
            textContent?['web_mid_title']??"",
            style: ubuntuTitle.copyWith(fontSize: 36, color: Colors.white),
          ),
        ),

      ]))),
    );
  }
}
