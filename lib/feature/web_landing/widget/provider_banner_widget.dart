import 'package:demandium/components/custom_image.dart';
import 'package:demandium/controller/localization_controller.dart';
import 'package:demandium/feature/web_landing/controller/web_landing_controller.dart';
import 'package:demandium/feature/web_landing/model/web_landing_model.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class providerBannerWidget extends StatelessWidget {
  final WebLandingController webLandingController;
  final Map<String?,String?>? textContent;
  final String baseUrl;
  final PageController _pageController = PageController();

  providerBannerWidget({
    Key? key,
    required this.webLandingController,
    required this.textContent,
    required this.baseUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLtr = Get.find<LocalizationController>().isLtr;

    return Container(
      color: Color(0xffd9ead3),
      width: Get.width,

      child: Align( alignment: Alignment.center,
          child: SizedBox(width: Dimensions.webMaxWidth,
              child: Row( mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox( width: Dimensions.webLandingSectionWidth,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(padding: EdgeInsets.only(left:20, bottom: 10, right: 10, top:60),
                              child: Text("Grow With Us",
                                style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeBanner, color: Colors.black ), textAlign: TextAlign.start,
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(left:20, bottom: 10, right: 10, top:10),
                              child: Text("Make a meaningful impact",
                                style: ubuntuTitleMD.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.black ), textAlign: TextAlign.start,
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(left:20, bottom: 60, right: 10, top:5),
                              child: Text("Agnomy paves the path, benefiting both businesses and individuals. Harness your knowledge, skills, and equipment to offer valuable services, generate income on your time, and lend a helping hand to neighboring farmers.",
                                style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Colors.black ), textAlign: TextAlign.start,
                              ),
                            ),
                          ]
                      ),
                    ),

                    Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
                      child: CustomImage(
                        height: 306,
                        width: 500,
                        image:"$baseUrl/landing-page/web/agnomy-helps-farmers-earn-money.jpg",
                        fit: BoxFit.fitHeight,
                      ),
                    ),

                  ]
              )
          )
      ),
    );
  }
}
