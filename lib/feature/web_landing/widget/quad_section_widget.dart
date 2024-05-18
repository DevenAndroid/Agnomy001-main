import 'package:demandium/components/custom_image.dart';
import 'package:demandium/controller/localization_controller.dart';
import 'package:demandium/feature/web_landing/controller/web_landing_controller.dart';
import 'package:demandium/feature/web_landing/model/web_landing_model.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class quadSectionWidget extends StatelessWidget {
  final WebLandingController webLandingController;
  final Map<String?,String?>? textContent;
  final String baseUrl;
  final PageController _pageController = PageController();

  quadSectionWidget({
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

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Powerful Features",
                  style: ubuntuTitle.copyWith(fontSize: 36, color: Colors.black, ), textAlign: TextAlign.center,
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),
                Text("Comprehensive tools for Agribusiness success ",
                  style: ubuntuTitleMD.copyWith(fontSize: 20, color: Theme.of(context).colorScheme.onPrimary,), textAlign: TextAlign.center,
                ),
                const SizedBox(height: Dimensions.paddingSizeLarge),
              ],
            ),
          ),


        ],
      ),

          const SizedBox(height: Dimensions.paddingSizeDefault, ),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              // Box One
              const SizedBox(width: Dimensions.paddingSizeDefault, ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Container(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 5, top:5),
                            child: SizedBox(
                               width: Dimensions.quadSectionPadding,
                                child:  CustomImage(
                                height: Dimensions.quadIconSize,
                                width: Dimensions.quadIconSize,
                                image:"$baseUrl/landing-page/icons/marketplace.png",
                                fit: BoxFit.fitHeight,
                                ),
                              ),
                          ),
                         SizedBox(
                         child: Column(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.only(left:5, bottom: 0, right: 10, top:5),
                                  child: Text("Marketplace ",
                                    style: ubuntuTitleMD.copyWith(fontSize: Dimensions.fontSizeDefaultQuad, color: Colors.black, ), textAlign: TextAlign.start,
                                  ),
                                ),
                                 Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 10, top:0),
                                  child: Text("Growing list of services",
                                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmallQuad, color: Colors.black, ), textAlign: TextAlign.start,
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Box Two
              const SizedBox(width: Dimensions.paddingSizeDefault, ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Container(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 5, top:5),
                          child: SizedBox(
                            width: Dimensions.quadSectionPadding,
                            child:  CustomImage(
                              height: Dimensions.quadIconSize,
                              width: Dimensions.quadIconSize,
                              image:"$baseUrl/landing-page/icons/dashboard.png",
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.only(left:5, bottom: 0, right: 10, top:5),
                                  child: Text("Dashboard ",
                                    style: ubuntuTitleMD.copyWith(fontSize: Dimensions.fontSizeDefaultQuad, color: Colors.black, ), textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 10, top:0),
                                  child: Text("Everything in one place",
                                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmallQuad, color: Colors.black, ), textAlign: TextAlign.start,
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Box Three
              const SizedBox(width: Dimensions.paddingSizeDefault, ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Container(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 5, top:5),
                          child: SizedBox(
                            width: Dimensions.quadSectionPadding,
                            child:  CustomImage(
                              height: Dimensions.quadIconSize,
                              width: Dimensions.quadIconSize,
                              image:"$baseUrl/landing-page/icons/manage.png",
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.only(left:5, bottom: 0, right: 10, top:5),
                                  child: Text("Management ",
                                    style: ubuntuTitleMD.copyWith(fontSize: Dimensions.fontSizeDefaultQuad, color: Colors.black, ), textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 10, top:0),
                                  child: Text("Built in business tools",
                                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmallQuad, color: Colors.black, ), textAlign: TextAlign.start,
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Box Four
              const SizedBox(width: Dimensions.paddingSizeDefault, ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Container(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 5, top:5),
                          child: SizedBox(
                            width: Dimensions.quadSectionPadding,
                            child:  CustomImage(
                              height: Dimensions.quadIconSize,
                              width: Dimensions.quadIconSize,
                              image:"$baseUrl/landing-page/icons/book.png",
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.only(left:5, bottom: 0, right: 10, top:5),
                                  child: Text("Booking ",
                                    style: ubuntuTitleMD.copyWith(fontSize: Dimensions.fontSizeDefaultQuad, color: Colors.black, ), textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 10, top:0),
                                  child: Text("One click easy booking",
                                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmallQuad, color: Colors.black, ), textAlign: TextAlign.start,
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),



            ],
          ),

          const SizedBox(height: Dimensions.paddingSizeDefault, ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              // Box One
              const SizedBox(width: Dimensions.paddingSizeDefault, ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Container(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 5, top:5),
                          child: SizedBox(
                            width: Dimensions.quadSectionPadding,
                            child:  CustomImage(
                              height: Dimensions.quadIconSize,
                              width: Dimensions.quadIconSize,
                              image:"$baseUrl/landing-page/icons/quotes.png",
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.only(left:5, bottom: 0, right: 10, top:5),
                                  child: Text("Quotes ",
                                    style: ubuntuTitleMD.copyWith(fontSize: Dimensions.fontSizeDefaultQuad, color: Colors.black, ), textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 10, top:0),
                                  child: Text("Custom job estimates",
                                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmallQuad, color: Colors.black, ), textAlign: TextAlign.start,
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Box Two
              const SizedBox(width: Dimensions.paddingSizeDefault, ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Container(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 5, top:5),
                          child: SizedBox(
                            width: Dimensions.quadSectionPadding,
                            child:  CustomImage(
                              height: Dimensions.quadIconSize,
                              width: Dimensions.quadIconSize,
                              image:"$baseUrl/landing-page/icons/invoice.png",
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.only(left:5, bottom: 0, right: 10, top:5),
                                  child: Text("Invoices",
                                    style: ubuntuTitleMD.copyWith(fontSize: Dimensions.fontSizeDefaultQuad, color: Colors.black, ), textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 10, top:0),
                                  child: Text("Automatic invoice processing",
                                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmallQuad, color: Colors.black, ), textAlign: TextAlign.start,
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Box Three
              const SizedBox(width: Dimensions.paddingSizeDefault, ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Container(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 5, top:5),
                          child: SizedBox(
                            width: Dimensions.quadSectionPadding,
                            child:  CustomImage(
                              height: Dimensions.quadIconSize,
                              width: Dimensions.quadIconSize,
                              image:"$baseUrl/landing-page/icons/payments.png",
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.only(left:5, bottom: 0, right: 10, top:5),
                                  child: Text("Payments ",
                                    style: ubuntuTitleMD.copyWith(fontSize: Dimensions.fontSizeDefaultQuad, color: Colors.black, ), textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 10, top:0),
                                  child: Text("In app payments",
                                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmallQuad, color: Colors.black, ), textAlign: TextAlign.start,
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Box Four
              const SizedBox(width: Dimensions.paddingSizeDefault, ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Container(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 5, top:5),
                          child: SizedBox(
                            width: Dimensions.quadSectionPadding,
                            child:  CustomImage(
                              height: Dimensions.quadIconSize,
                              width: Dimensions.quadIconSize,
                              image:"$baseUrl/landing-page/icons/reporting.png",
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.only(left:5, bottom: 0, right: 10, top:5),
                                  child: Text("Reporting ",
                                    style: ubuntuTitleMD.copyWith(fontSize: Dimensions.fontSizeDefaultQuad, color: Colors.black, ), textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 10, top:0),
                                  child: Text("Real time data and analytics",
                                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmallQuad, color: Colors.black, ), textAlign: TextAlign.start,
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),

          const SizedBox(height: Dimensions.paddingSizeDefault, ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [


              // Box Four
              const SizedBox(width: Dimensions.paddingSizeDefault, ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Container(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 5, top:5),
                          child: SizedBox(
                            width: Dimensions.quadSectionPadding,
                            child:  CustomImage(
                              height: Dimensions.quadIconSize,
                              width: Dimensions.quadIconSize,
                              image:"$baseUrl/landing-page/icons/marketing.png",
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.only(left:5, bottom: 0, right: 10, top:5),
                                  child: Text("Discover ",
                                    style: ubuntuTitleMD.copyWith(fontSize: Dimensions.fontSizeDefaultQuad, color: Colors.black, ), textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 10, top:0),
                                  child: Text("Be found by customers",
                                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmallQuad, color: Colors.black, ), textAlign: TextAlign.start,
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Box One
              const SizedBox(width: Dimensions.paddingSizeDefault, ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Container(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 5, top:5),
                          child: SizedBox(
                            width: Dimensions.quadSectionPadding,
                            child:  CustomImage(
                              height: Dimensions.quadIconSize,
                              width: Dimensions.quadIconSize,
                              image:"$baseUrl/landing-page/icons/schedule.png",
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.only(left:5, bottom: 0, right: 10, top:5),
                                  child: Text("Schedule ",
                                    style: ubuntuTitleMD.copyWith(fontSize: Dimensions.fontSizeDefaultQuad, color: Colors.black, ), textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 10, top:0),
                                  child: Text("Keep track of jobs",
                                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmallQuad, color: Colors.black, ), textAlign: TextAlign.start,
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Box Two
              const SizedBox(width: Dimensions.paddingSizeDefault, ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Container(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 5, top:5),
                          child: SizedBox(
                            width: Dimensions.quadSectionPadding,
                            child:  CustomImage(
                              height: Dimensions.quadIconSize,
                              width: Dimensions.quadIconSize,
                              image:"$baseUrl/landing-page/icons/comms.png",
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.only(left:5, bottom: 0, right: 10, top:5),
                                  child: Text("Communicate ",
                                    style: ubuntuTitleMD.copyWith(fontSize: Dimensions.fontSizeDefaultQuad, color: Colors.black, ), textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 10, top:0),
                                  child: Text("Built in chat support",
                                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmallQuad, color: Colors.black, ), textAlign: TextAlign.start,
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Box Three
              const SizedBox(width: Dimensions.paddingSizeDefault, ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Container(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 5, top:5),
                          child: SizedBox(
                            width: Dimensions.quadSectionPadding,
                            child:  CustomImage(
                              height: Dimensions.quadIconSize,
                              width: Dimensions.quadIconSize,
                              image:"$baseUrl/landing-page/icons/tracking.png",
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.only(left:5, bottom: 0, right: 10, top:5),
                                  child: Text("Track ",
                                    style: ubuntuTitleMD.copyWith(fontSize: Dimensions.fontSizeDefaultQuad, color: Colors.black, ), textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 10, top:0),
                                  child: Text("Track teams and jobs",
                                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmallQuad, color: Colors.black, ), textAlign: TextAlign.start,
                                  ),
                                ),
                              ]
                          ),
                        ),
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