import 'package:demandium/components/custom_image.dart';
import 'package:demandium/controller/localization_controller.dart';
import 'package:demandium/feature/web_landing/controller/web_landing_controller.dart';
import 'package:demandium/feature/web_landing/model/web_landing_model.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class threeSectionWidget extends StatelessWidget {
  final WebLandingController webLandingController;
  final Map<String?,String?>? textContent;
  final String baseUrl;
  final PageController _pageController = PageController();

  threeSectionWidget({
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
                  color: Theme.of(context).hoverColor,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: Dimensions.paddingSizeLarge),
                    CustomImage(
                      height: 175,
                      width: 175,
                      image:"$baseUrl/landing-page/web/ag-log-blk.png",
                      fit: BoxFit.fitHeight,
                    ),
                    Text("Ag Services",
                      style: ubuntuTitle.copyWith(fontSize: 28, color: Colors.black, ), textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Dimensions.paddingSizeEight),
                    Text("Agnomy ",
                      style: ubuntuTitleMD.copyWith(fontSize: 18, color: Theme.of(context).colorScheme.onPrimary, ), textAlign: TextAlign.center,
                    ),
                    Text("context",
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
                  color: Theme.of(context).hoverColor,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: Dimensions.paddingSizeLarge),
                      CustomImage(
                        height: 175,
                        width: 175,
                        image:"$baseUrl/landing-page/web/ag-log-blk.png",
                        fit: BoxFit.fitHeight,
                      ),
                      Text("Ag Services",
                        style: ubuntuTitle.copyWith(fontSize: 28, color: Colors.black, ), textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: Dimensions.paddingSizeEight),
                      Text("Agnomy ",
                        style: ubuntuTitleMD.copyWith(fontSize: 18, color: Theme.of(context).colorScheme.onPrimary, ), textAlign: TextAlign.center,
                      ),
                      Text("context",
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
                  color: Theme.of(context).hoverColor,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: Dimensions.paddingSizeLarge),
                      CustomImage(
                        height: 175,
                        width: 175,
                        image:"$baseUrl/landing-page/web/ag-log-blk.png",
                        fit: BoxFit.fitHeight,
                      ),
                      Text("Ag Services",
                        style: ubuntuTitle.copyWith(fontSize: 28, color: Colors.black, ), textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: Dimensions.paddingSizeEight),
                      Text("Agnomy ",
                        style: ubuntuTitleMD.copyWith(fontSize: 18, color: Theme.of(context).colorScheme.onPrimary, ), textAlign: TextAlign.center,
                      ),
                      Text("context",
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