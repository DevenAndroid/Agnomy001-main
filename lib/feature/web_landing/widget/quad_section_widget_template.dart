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

              // Box One
              const SizedBox(width: Dimensions.paddingSizeDefault, ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Container(
                    color: Theme.of(context).hoverColor,

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 5, top:5),
                            child: SizedBox(
                               width: Dimensions.quadSectionPadding,
                                child:  CustomImage(
                                height: Dimensions.quadIconSize,
                                width: Dimensions.quadIconSize,
                                image:"$baseUrl/landing-page/web/ag-log-blk.png",
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
                                  child: Text("Agnomy ",
                                    style: ubuntuTitleMD.copyWith(fontSize: Dimensions.fontSizeDefaultQuad, color: Theme.of(context).colorScheme.onPrimary, ), textAlign: TextAlign.start,
                                  ),
                                ),
                                 Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 10, top:0),
                                  child: Text("context",
                                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmallQuad, color: Theme.of(context).colorScheme.onPrimary, ), textAlign: TextAlign.start,
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
                    color: Theme.of(context).hoverColor,

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 5, top:5),
                          child: SizedBox(
                            width: Dimensions.quadSectionPadding,
                            child:  CustomImage(
                              height: Dimensions.quadIconSize,
                              width: Dimensions.quadIconSize,
                              image:"$baseUrl/landing-page/web/ag-log-blk.png",
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
                                  child: Text("Agnomy ",
                                    style: ubuntuTitleMD.copyWith(fontSize: Dimensions.fontSizeDefaultQuad, color: Theme.of(context).colorScheme.onPrimary, ), textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 10, top:0),
                                  child: Text("context",
                                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmallQuad, color: Theme.of(context).colorScheme.onPrimary, ), textAlign: TextAlign.start,
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
                    color: Theme.of(context).hoverColor,

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 5, top:5),
                          child: SizedBox(
                            width: Dimensions.quadSectionPadding,
                            child:  CustomImage(
                              height: Dimensions.quadIconSize,
                              width: Dimensions.quadIconSize,
                              image:"$baseUrl/landing-page/web/ag-log-blk.png",
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
                                  child: Text("Agnomy ",
                                    style: ubuntuTitleMD.copyWith(fontSize: Dimensions.fontSizeDefaultQuad, color: Theme.of(context).colorScheme.onPrimary, ), textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 10, top:0),
                                  child: Text("context",
                                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmallQuad, color: Theme.of(context).colorScheme.onPrimary, ), textAlign: TextAlign.start,
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
                    color: Theme.of(context).hoverColor,

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 5, top:5),
                          child: SizedBox(
                            width: Dimensions.quadSectionPadding,
                            child:  CustomImage(
                              height: Dimensions.quadIconSize,
                              width: Dimensions.quadIconSize,
                              image:"$baseUrl/landing-page/web/ag-log-blk.png",
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
                                  child: Text("Agnomy ",
                                    style: ubuntuTitleMD.copyWith(fontSize: Dimensions.fontSizeDefaultQuad, color: Theme.of(context).colorScheme.onPrimary, ), textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(left:5, bottom: 5, right: 10, top:0),
                                  child: Text("context",
                                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmallQuad, color: Theme.of(context).colorScheme.onPrimary, ), textAlign: TextAlign.start,
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