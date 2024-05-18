import 'package:demandium/components/custom_image.dart';
import 'package:demandium/controller/localization_controller.dart';
import 'package:demandium/feature/web_landing/controller/web_landing_controller.dart';
import 'package:demandium/feature/web_landing/model/web_landing_model.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class bannerSectionWidget extends StatelessWidget {
  final WebLandingController webLandingController;
  final Map<String?,String?>? textContent;
  final String baseUrl;
  final PageController _pageController = PageController();

  bannerSectionWidget({
    Key? key,
    required this.webLandingController,
    required this.textContent,
    required this.baseUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return SizedBox(
      width: Dimensions.webMaxWidth,

        child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),

      child: Container(
        color: Color(0xFFf3f5f7),


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


                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(left:50, bottom: 5, right: 20, top:25),
                    child: Text("Download Agnomy",
                      style: ubuntuBold.copyWith(fontSize: 36, color: Theme.of(context).colorScheme.tertiary,), textAlign: TextAlign.start,
                       ),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeDefault),

                    Padding(padding: EdgeInsets.only(left:50, bottom: 5, right: 20, top:5),
                      child:Text("Your in field sidekick ",
                      style: ubuntuTitleMD.copyWith(fontSize: 20, color: Theme.of(context).colorScheme.tertiary,), textAlign: TextAlign.start,
                      ),
                    ),

                    Padding(padding: EdgeInsets.only(left:50, bottom: 40, right: 20, top:5),
                      child:Text("Make the Agnomy app your ultimate in-field sidekick for finding or providing agricultural services. Don’t waste time searching online with limited results—Agnomy is the only platform uniquely crafted for agribusiness, ensuring efficiency and ease.",
                      style: ubuntuRegular.copyWith(fontSize: 16, color: Theme.of(context).colorScheme.tertiary, ), textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),


              const SizedBox(width: Dimensions.paddingSizeDefault,),
              Padding(padding: EdgeInsets.only(left:10, bottom: 15, right: 100, top:25),
                child:CustomImage(
                height: 441,
                width: 200,
                image:"$baseUrl/landing-page/web/phone-app-2.png",
                fit: BoxFit.fitHeight,
                ),
              ),

            ],
          ),

        ],
      ),
    ),
        ),
    );
  }
}