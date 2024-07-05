import 'package:demandium/components/custom_image.dart';
import 'package:demandium/controller/localization_controller.dart';
import 'package:demandium/feature/web_landing/controller/web_landing_controller.dart';
import 'package:demandium/feature/web_landing/model/web_landing_model.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class forSectionWidget extends StatelessWidget {
  final WebLandingController webLandingController;
  final Map<String?,String?>? textContent;
  final String baseUrl;
  final PageController _pageController = PageController();

  forSectionWidget({
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
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [

          const SizedBox(height: Dimensions.paddingSizeDefault, ),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const SizedBox(width: Dimensions.paddingSizeDefault, ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Container(
                    height: 365,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFe7e8ea)),
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                        CustomImage(
                          height: 175,
                          width: 275,
                          image:"$baseUrl/landing-page/web/farm-labor.jpg",
                          fit: BoxFit.fitHeight,
                        ),
                        const SizedBox(height: Dimensions.paddingSizeEight),
                        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Text("For",
                              style: ubuntuTitle.copyWith(fontSize: 26, color: Colors.black, ), textAlign: TextAlign.center,
                            ),
                            Text(" Farmers & Ranchers",
                              style: ubuntuBold.copyWith(fontSize: 26, color: Colors.black, ), textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const SizedBox(height: Dimensions.paddingSizeEight),
                        /* Text("Agnomy ",
                      style: ubuntuTitleMD.copyWith(fontSize: 18, color: Theme.of(context).colorScheme.onPrimary, ), textAlign: TextAlign.center,
                    ), */
                        Text("Easily find professionals in your area to help with labor, equipment, and all ag related needs.",
                          style: ubuntuRegular.copyWith(fontSize: 16, color: Theme.of(context).colorScheme.onPrimary, ), textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: Dimensions.paddingSizeLarge),
                      ],
                    ),
                  ),
                ),
              ),


              const SizedBox(width: Dimensions.paddingSizeDefault, ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Container(
                    height: 365,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFe7e8ea)),
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                        CustomImage(
                          height: 175,
                          width: 275,
                          image:"$baseUrl/landing-page/web/farm-service.jpg",
                          fit: BoxFit.fitHeight,
                        ),
                        const SizedBox(height: Dimensions.paddingSizeEight),
                        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Text("For",
                              style: ubuntuTitle.copyWith(fontSize: 26, color: Colors.black, ), textAlign: TextAlign.center,
                            ),
                            Text(" Agriculturist",
                              style: ubuntuBold.copyWith(fontSize: 26, color: Colors.black, ), textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const SizedBox(height: Dimensions.paddingSizeEight),
                        /* Text("Agnomy ",
                      style: ubuntuTitleMD.copyWith(fontSize: 18, color: Theme.of(context).colorScheme.onPrimary, ), textAlign: TextAlign.center,
                       ), */
                        Text("Utilize your expertise and equipment to earn income while providing invaluable support to other farmers.",
                          style: ubuntuRegular.copyWith(fontSize: 16, color: Theme.of(context).colorScheme.onPrimary, ), textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: Dimensions.paddingSizeLarge),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(width: Dimensions.paddingSizeDefault, ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Container(
                    height: 365,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFe7e8ea)),
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                        CustomImage(
                          height: 175,
                          width: 275,
                          image:"$baseUrl/landing-page/web/dronefarm.jpg",
                          fit: BoxFit.fitHeight,
                        ),
                        const SizedBox(height: Dimensions.paddingSizeEight),
                        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Text("For",
                              style: ubuntuTitle.copyWith(fontSize: 26, color: Colors.black, ), textAlign: TextAlign.center,
                            ),
                            Text(" Agribusiness",
                              style: ubuntuBold.copyWith(fontSize: 26, color: Colors.black, ), textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const SizedBox(height: Dimensions.paddingSizeEight),
                        /* Text("Agnomy ",
                      style: ubuntuTitleMD.copyWith(fontSize: 18, color: Theme.of(context).colorScheme.onPrimary, ), textAlign: TextAlign.center,
                    ), */
                        Text("Grow your business and reach new customers with our integrated all-in-one platform.",
                          style: ubuntuRegular.copyWith(fontSize: 16, color: Theme.of(context).colorScheme.onPrimary, ), textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: Dimensions.paddingSizeLarge),
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
        ],
      ),
    );

  }
}