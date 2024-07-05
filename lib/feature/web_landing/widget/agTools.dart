import 'package:demandium/components/custom_image.dart';
import 'package:demandium/controller/localization_controller.dart';
import 'package:demandium/feature/web_landing/controller/web_landing_controller.dart';
import 'package:demandium/feature/web_landing/model/web_landing_model.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class agToolsWidget extends StatelessWidget {
  final WebLandingController webLandingController;
  final Map<String?,String?>? textContent;
  final String baseUrl;
  final PageController _pageController = PageController();

  agToolsWidget({
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
                height: 364,
                width: 450,
                image:"$baseUrl/landing-page/web/ag-service-tools.jpeg",
                fit: BoxFit.fitHeight,
              ),

              const SizedBox(width: Dimensions.paddingSizeExtraMoreLarge,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Automated Tools",
                      style: ubuntuBold.copyWith(fontSize: 36, color: Colors.black, ), textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: Dimensions.paddingSizeDefault),

                    Text("Built-in business tools to get work done",
                      style: ubuntuTitleMD.copyWith(fontSize: 20, color: Theme.of(context).colorScheme.onPrimary,), textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    Text("Empowering individual service professionals and agribusinesses with advanced, automated tools to deliver exceptional results. Let Agnomy be your sidekick, dynamically managing bookings, schedules, invoices, payments, and reports so you can focus on what you do best.",
                      style: ubuntuRegular.copyWith(fontSize: 18, color: Theme.of(context).colorScheme.onPrimary, ), textAlign: TextAlign.start,
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