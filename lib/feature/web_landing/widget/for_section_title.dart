import 'package:demandium/components/custom_image.dart';
import 'package:demandium/controller/localization_controller.dart';
import 'package:demandium/feature/web_landing/controller/web_landing_controller.dart';
import 'package:demandium/feature/web_landing/model/web_landing_model.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class forSectionTitle extends StatelessWidget {
  final WebLandingController webLandingController;
  final Map<String?,String?>? textContent;
  final String baseUrl;
  final PageController _pageController = PageController();

  forSectionTitle({
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

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("We've streamlined getting work done.",
                      style: ubuntuBold.copyWith(fontSize: 44, color: Colors.black, ), textAlign: TextAlign.center,
                    ),
                    /*const SizedBox(height: Dimensions.paddingSizeDefault),
                    Text("Agnomy ",
                      style: ubuntuTitleMD.copyWith(fontSize: 20, color: Theme.of(context).colorScheme.onPrimary,), textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Dimensions.paddingSizeEight),
                    Text("containg text",
                      style: ubuntuRegular.copyWith(fontSize: 18, color: Theme.of(context).colorScheme.onPrimary, ), textAlign: TextAlign.center,
                    ),*/
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
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