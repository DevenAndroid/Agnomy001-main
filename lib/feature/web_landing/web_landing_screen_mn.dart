import 'dart:async';
import 'package:demandium/components/custom_image.dart';
import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/controller/localization_controller.dart';
import 'package:demandium/data/model/response/config_model.dart';
import 'package:demandium/feature/splash/controller/splash_controller.dart';
import 'package:demandium/feature/web_landing/controller/web_landing_controller.dart';
import 'package:demandium/feature/web_landing/repository/web_landing_repo.dart';
import 'package:demandium/feature/web_landing/widget/live_chat_button.dart';
import 'package:demandium/feature/web_landing/widget/web_landing_search_box.dart';
import 'package:demandium/feature/web_landing/widget/web_landing_shimmer.dart';
import 'package:demandium/feature/web_landing/widget/web_mid_section.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/images.dart';
import 'package:demandium/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'widget/testimonial_widget.dart';
import 'widget/banner_widget.dart';
import 'widget/section_round_widget.dart';
import 'widget/marketplace_widget.dart';
import 'widget/service_widget.dart';
import 'widget/three_section_widget.dart';
import 'widget/text_section_widget.dart';
import 'widget/banner_section_widget.dart';
import 'widget/quad_section_widget.dart';
import 'widget/provider_banner_widget.dart';
import 'widget/two_section_widget.dart';


class WebLandingPage extends StatefulWidget {
  final bool? fromSignUp;
  final String? route;

  const WebLandingPage({Key? key, required this.fromSignUp, required this.route}) : super(key: key);

  @override
  State<WebLandingPage> createState() => _WebLandingPageState();
}

class _WebLandingPageState extends State<WebLandingPage> {
  final ConfigModel _config = Get.find<SplashController>().configModel;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    Get.find<WebLandingController>().getWebLandingContent();
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => WebLandingController( WebLandingRepo( apiClient: Get.find())));
    String baseUrl = Get.find<SplashController>().configModel.content!.imageBaseUrl!;

    return GetBuilder<WebLandingController>(

      builder: (webLandingController){
        if(webLandingController.webLandingContent != null){
          var textContent = { for (var e in webLandingController.webLandingContent!.textContent!) e.keyName : e.liveValues };
          var imageContent = { for (var e in webLandingController.webLandingContent!.imageContent!) e.keyName : e.liveValues };


          return FooterBaseView(
            bottomPadding: false,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  const SizedBox(height: Dimensions.paddingSizeLarge),
                  WebLandingSearchSection(baseUrl: baseUrl,textContent: textContent,fromSignUp:widget.fromSignUp,route: widget.route,),
                  const SizedBox(height: Dimensions.paddingSizeMid),
                  SectionRoundWidget(
                    webLandingController: webLandingController,
                    textContent: textContent,
                    baseUrl: baseUrl,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeMid),
                  WebMidSection(
                    baseUrl: baseUrl,
                    imageContent: imageContent,
                    textContent: textContent,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeDouble),
                  BannerWidget(
                    webLandingController: webLandingController,
                    textContent: textContent,
                    baseUrl: baseUrl,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge),
                  textSectionWidget(
                    webLandingController: webLandingController,
                    textContent: textContent,
                    baseUrl: baseUrl,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge),
                  threeSectionWidget(
                    webLandingController: webLandingController,
                    textContent: textContent,
                    baseUrl: baseUrl,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeDouble),
                  providerBannerWidget(
                    webLandingController: webLandingController,
                    textContent: textContent,
                    baseUrl: baseUrl,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeDouble),
                  twoSectionWidget(
                    webLandingController: webLandingController,
                    textContent: textContent,
                    baseUrl: baseUrl,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeLarge),
                  quadSectionWidget(
                    webLandingController: webLandingController,
                    textContent: textContent,
                    baseUrl: baseUrl,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeDouble),

                  TestimonialWidget(
                    webLandingController: webLandingController,
                    textContent: textContent,
                    baseUrl: baseUrl,
                  ),

                  const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge),
                  bannerSectionWidget(
                    webLandingController: webLandingController,
                    textContent: textContent,
                    baseUrl: baseUrl,
                  ),

                  const SizedBox(height: Dimensions.paddingSizeDouble),

                ],),
            ),
          );
        }else{
          return const WebLandingShimmer();
        }
      },
    );
  }
}
class CustomPath extends CustomClipper<Path> {
  final bool? isRtl;
  CustomPath({required this.isRtl});

  @override
  Path getClip(Size size) {
    final path = Path();
    if(isRtl!) {
      path..moveTo(0, size.height)
        ..lineTo(size.width, size.height)
        ..lineTo(size.width*0.7, 0)
        ..lineTo(0, 0)
        ..close();
    }else {
      path..moveTo(0, size.height)
        ..lineTo(size.width*0.3, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width, size.height)
        ..close();
    }
    return path;
  }



  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}


