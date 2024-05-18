import 'package:demandium/components/custom_image.dart';
import 'package:demandium/controller/localization_controller.dart';
import 'package:demandium/feature/web_landing/controller/web_landing_controller.dart';
import 'package:demandium/feature/web_landing/model/web_landing_model.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class marketplaceWidget extends StatelessWidget {
  final WebLandingController webLandingController;
  final Map<String?,String?>? textContent;
  final String baseUrl;
  final PageController _pageController = PageController();

  marketplaceWidget({
    Key? key,
    required this.webLandingController,
    required this.textContent,
    required this.baseUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return SizedBox(
      width: Dimensions.webMaxWidth,


      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SizedBox(height: Dimensions.paddingSizeDefault),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              CustomImage(
                height: 500,
                width: 238,
                image:"$baseUrl/landing-page/web/agnomy-marketplace.jpg",
                fit: BoxFit.fitHeight,
              ),

              const SizedBox(width: Dimensions.paddingSizeExtraMoreLarge,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text("Ag Services",
                      style: ubuntuTitle.copyWith(fontSize: 36, color: Colors.black, ), textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    Text("Agnomy simplifies the process of locating agricultural services by creating an all-in-one database of businesses and individuals in your local area.",
                      style: ubuntuTitleMD.copyWith(fontSize: 18, color: Theme.of(context).colorScheme.onPrimary,), textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    Text("Drawing on over 30 years of experience in the agricultural industry, our platform is crafted with farmers in mind. Recognizing the challenges of finding trustworthy service providers, particularly in an industry built on connections and word-of-mouth recommendations, we established Agnomy. Our mission is to empower all farmers by ensuring they have access to top-notch services at affordable prices.",
                      style: ubuntuRegular.copyWith(fontSize: 16, color: Theme.of(context).colorScheme.onPrimary,), textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),


            ],
          ),

        ],
      ),
    );

  }
}
