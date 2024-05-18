import 'package:demandium/components/custom_image.dart';
import 'package:demandium/controller/localization_controller.dart';
import 'package:demandium/feature/web_landing/controller/web_landing_controller.dart';
import 'package:demandium/feature/web_landing/model/web_landing_model.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class serviceWidget extends StatelessWidget {
  final WebLandingController webLandingController;
  final Map<String?,String?>? textContent;
  final String baseUrl;
  final PageController _pageController = PageController();

  serviceWidget({
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
                  crossAxisAlignment: CrossAxisAlignment.end,

                  children: [
                    Text("Provide Ag Services",
                      style: ubuntuTitle.copyWith(fontSize: 36, color: Colors.black, ), textAlign: TextAlign.end,
                    ),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    Text("Agnomy delivers an all-in-one solution, empowering you to seamlessly showcase your services, streamline booking management, deliver services efficiently, and effortlessly manage invoices and payments.",
                      style: ubuntuTitleMD.copyWith(fontSize: 18, color: Theme.of(context).colorScheme.onPrimary,), textAlign: TextAlign.end,
                    ),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    Text("Experience a comprehensive perspective with Adload's management dashboard and app, offering a 360-degree view of your work orders, schedules, and customer interactions. From defining your offered services to scheduling bookings and handling payments, we've streamlined every process into an all-in-one solution, ensuring you start earning quickly.",
                      style: ubuntuRegular.copyWith(fontSize: 16, color: Theme.of(context).colorScheme.onPrimary,), textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: Dimensions.paddingSizeExtraMoreLarge,),
              CustomImage(
                height: 500,
                width: 238,
                image:"$baseUrl/landing-page/web/agnomy-ag-service-providers.jpg",
                fit: BoxFit.fitHeight,
              ),



            ],
          ),

        ],
      ),
    );

  }
}
