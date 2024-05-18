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
      color: Theme.of(context).colorScheme.secondary,
      height: Dimensions.webLandingBannerHeight, width: Get.width,

      child: Align( alignment: Alignment.center,
          child: SizedBox(width: Dimensions.webMaxWidth,
              child: Row( mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.only(left:0, bottom: 0, right: 10, top:5),
                            child: Text("Become A Provider ",
                              style: ubuntuTitle.copyWith(fontSize: Dimensions.fontSizeBanner, color: Colors.white ), textAlign: TextAlign.start,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left:0, bottom: 5, right: 10, top:0),
                            child: Text("context",
                              style: ubuntuTitleMD.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.white ), textAlign: TextAlign.start,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left:0, bottom: 5, right: 10, top:0),
                            child: Text("context",
                              style: ubuntuTitleMD.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.white ), textAlign: TextAlign.start,
                            ),
                          ),
                        ]
                    ),
                  ),

                  Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
                    child: CustomImage(
                      height: 100,
                      width: 450,
                      image:"$baseUrl/landing-page/web/logo-bg-white.png",
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
