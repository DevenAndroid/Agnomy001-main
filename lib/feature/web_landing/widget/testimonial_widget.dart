import 'package:demandium/components/custom_image.dart';
import 'package:demandium/controller/localization_controller.dart';
import 'package:demandium/feature/web_landing/controller/web_landing_controller.dart';
import 'package:demandium/feature/web_landing/model/web_landing_model.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestimonialWidget extends StatelessWidget {
  final WebLandingController webLandingController;
  final Map<String?,String?>? textContent;
  final String baseUrl;
  final PageController _pageController = PageController();

   TestimonialWidget({
    Key? key,
    required this.webLandingController,
    required this.textContent,
    required this.baseUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLtr = Get.find<LocalizationController>().isLtr;

    return Container(
      color: Theme.of(context).colorScheme.onPrimary,
      height: Dimensions.webLandingTestimonialHeight, width: Get.width,
      child: Align( alignment: Alignment.center, child: SizedBox(width: Dimensions.webMaxWidth, child: Row( mainAxisAlignment: MainAxisAlignment.center, children: [

        Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
          child: InkWell( onTap: () => _pageController.previousPage( duration: const Duration(seconds: 1), curve: Curves.easeInOut),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              height: Dimensions.webLandingIconContainerHeight, width: Dimensions.webLandingIconContainerHeight, alignment: Alignment.center,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.withOpacity(0.15)),
              child: Padding(padding:  EdgeInsets.only(
                  left: isLtr ?  Dimensions.paddingSizeSmall : 0.0,
                  right: !isLtr ?  Dimensions.paddingSizeSmall : 0.0,
                ),
                child: Icon(Icons.arrow_back_ios, size: Dimensions.webArrowSize,
                    color:webLandingController.currentPage! > 0? Theme.of(context).colorScheme.primary :Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8)
                ),
              ),
            ),
          ),
        ),

        Expanded( child: PageView.builder(
          controller: _pageController,
          itemCount: webLandingController.webLandingContent!.testimonial!.length,
          itemBuilder: (context, index) {
            Testimonial testimonial =  webLandingController.webLandingContent!.testimonial!.elementAt(index);
            return Padding( padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              child: Column( mainAxisAlignment: MainAxisAlignment.spaceAround, children: [

                Row( mainAxisAlignment: MainAxisAlignment.center, children: [

                    Column( mainAxisSize: MainAxisSize.max,  crossAxisAlignment: CrossAxisAlignment.center, children: [

                      Text(textContent?['testimonial_title']??"",
                        style: ubuntuTitle.copyWith(fontSize: 36, color: Colors.white), textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40,),

                      SizedBox( width: Get.width / 3,
                        child: Text(testimonial.review!, style: ubuntuRegular.copyWith(fontSize: 20, color: Colors.white),textAlign: TextAlign.center,)
                      ),
                      const SizedBox(height: 25,),

                      Text("- ${testimonial.name!}",
                        style: ubuntuTitleSM.copyWith(fontSize: 18, color: Colors.white), textAlign: TextAlign.center,
                      ),
                      Text("${testimonial.designation!}",
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Colors.grey), textAlign: TextAlign.center,
                      ),
                    ]),
                ]),

                Text("${index+1}/${webLandingController.webLandingContent!.testimonial!.length}",
                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Colors.grey),)
              ]),
            );
          },
          onPageChanged: (int index){
            webLandingController.setPageIndex(index);
          },
        )),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
          child: InkWell(
            onTap: () => _pageController.nextPage(duration: const Duration(seconds: 1), curve: Curves.easeInOut),
            child: Container(
              height: Dimensions.webLandingIconContainerHeight, width: Dimensions.webLandingIconContainerHeight, alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.withOpacity(0.15),
              ),
              child: Icon(
                  Icons.arrow_forward_ios,
                  size: Dimensions.webArrowSize,
                  color:webLandingController.currentPage!+1 < webLandingController.webLandingContent!.testimonial!.length
                      ? Theme.of(context).colorScheme.primary :Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8)
              ),
            ),
          ),
        )

      ]))),
    );
  }
}
