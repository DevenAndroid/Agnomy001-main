import 'package:demandium/utils/images.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class ServiceOverview extends StatelessWidget {
  final String description;
  List<Providers> providers;

   ServiceOverview({Key? key, required this.description, required this. providers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: WebShadowWrap(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeSmall,
                  vertical: Dimensions.paddingSizeEight),
              width: Dimensions.webMaxWidth,
              constraints: ResponsiveHelper.isDesktop(context)
                  ? BoxConstraints(
                      minHeight: !ResponsiveHelper.isDesktop(context) &&
                              Get.size.height < 600
                          ? Get.size.height
                          : Get.size.height - 550,
                    )
                  : null,
              child: Card(
                  elevation: ResponsiveHelper.isMobile(context) ? 1 : 0,
                  color: ResponsiveHelper.isMobile(context)
                      ? Theme.of(context).cardColor
                      : Colors.transparent,
                  child: HtmlWidget(description)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault,
                  vertical: Dimensions.paddingSizeEight),
              child: Text(
                "Service Provider in your area:",
                style: ubuntuRegular.copyWith(
                    fontSize: Dimensions.fontSizeExtraLarge, color: Colors.black),
              ),
            ), const SizedBox(height: 20,),
            GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical, // Change this to Axis.horizontal if you want horizontal scrolling
              itemCount: providers.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                 childAspectRatio: 6 / 2,
              ),
              itemBuilder: (context, index) {
                return Container(
                  // height: 10,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Container(
                             // height: 20,
                             // width: 25,
                             child: Image(
                              image: NetworkImage(
                                "${Get.find<SplashController>().configModel.content!.imageBaseUrl}/provider/logo/${providers![index].logo.toString()}"
                              ),
                              height: 30,
                                                       ),
                           ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(providers![index].companyName.toString()),
                              Row(
                                children: [

                                   RatingBar(rating: providers![index].avgRating),
                                  // RatingBarIndicator(
                                  //   rating: 2.75,
                                  //   itemBuilder: (context, index) =>  const Icon(
                                  //     Icons.star,
                                  //     color: Colors.amber,
                                  //   ),
                                  //   itemCount: providers![index].avgRating!.toInt(),
                                  //   itemSize: 10.0,
                                  //   direction: Axis.horizontal,
                                  // ),

                                  Gaps.horizontalGapOf(5),
                                  Directionality(
                                    textDirection: TextDirection.ltr,
                                    child:  Text('${providers![index].ratingCount} ${'reviews'.tr}', style: ubuntuRegular.copyWith(
                                      fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).secondaryHeaderColor,
                                    )),
                                  ),
                                  // const Text("0 Reviews"),
                                ],
                              ),
                               Text(providers![index].companyDescription.toString()),
                            ],
                          ),
                        ],
                      ),
                      Gaps.horizontalGapOf(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Text("within${providers[index].distance!.toInt()}miles"),
/*
                          SizedBox(
                            height: 30,
                            child:  GetBuilder<CartController>(builder: (cartControllerInit) {
                              return GetBuilder<CartController>(
                                  builder: (cartController) {
                                    bool addToCart = true;
                                    return cartController.isLoading
                                        ? const Center(
                                        child: CircularProgressIndicator())
                                        : ElevatedButton(
                                      onPressed: () {
                                        print("ADD CARD1");
                                        cartControllerInit.isButton
                                            ? () async {
                                          cartController.updateQuantity(index, true);
                                          cartController.showMinimumAndMaximumOrderValueToaster();


                                          if (addToCart) {
                                            addToCart = false;
                                            await cartController
                                                .addMultipleCartToServer();
                                            await cartController
                                                .getCartListFromServer(
                                                shouldUpdate: true);
                                          }
                                        }
                                            : SizedBox();
                                        print("ADD CARD");
                                      },
                                      child:

                                    Text('${"add".tr} +',style: ubuntuRegular.copyWith(color: Colors.white),
                                    )
                                    );
                                  }
                              );
                            }
                          ),
                          )

 */
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20,),
         /*   SizedBox(
              height: 115,
              child: GridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical, // Change this to Axis.horizontal if you want horizontal scrolling
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns in the grid
                  mainAxisSpacing: 10.0, // Spacing between rows
                  crossAxisSpacing: 10.0, // Spacing between columns
                  // childAspectRatio: 3 / 2, // Aspect ratio of the items
                ),
                itemBuilder: (context, index) {
                  return Container(
                    height: 10,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.red),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image(
                              image: AssetImage("assets/images/faming.webp"),
                              height: 20,
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Ag Inc LLc"),
                                Row(
                                  children: [
                                    RatingBarIndicator(
                                      rating: 2.75,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 10.0,
                                      direction: Axis.horizontal,
                                    ),
                                    SizedBox(width: 5),
                                    Text("0 Reviews"),
                                  ],
                                ),
                                Text("Ag Inc LLc"),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("within 12 miles"),
                            SizedBox(
                              height: 30,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text("Quote"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              // child: ListView.builder(
              //   shrinkWrap: true,
              //   scrollDirection: Axis.horizontal,
              //   itemCount: 5,
              //   itemBuilder: (context, index) {
              //     return Row(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.symmetric(
              //               horizontal: Dimensions.paddingSizeDefault,
              //     ),
              //           child: Container(
              //             width: 290,
              //             padding:
              //                 EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              //
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.all(Radius.circular(10)),
              //                 border: Border.all(color: Colors.grey)),
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               children: [
              //                 Row(
              //                   mainAxisAlignment: MainAxisAlignment.start,
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Image(
              //                       image: AssetImage(
              //                         "assets/images/faming.webp",
              //                       ),
              //                       height: 20,
              //                     ),
              //                     SizedBox(width: 20,),
              //                     Column(
              //                       crossAxisAlignment: CrossAxisAlignment.start,
              //                       children: [
              //                         Text("Ag Inc LLc"),
              //                         Row(
              //                           children: [
              //                             RatingBarIndicator(
              //                               rating: 2.75,
              //                               itemBuilder: (context, index) => Icon(
              //                                 Icons.star,
              //                                 color: Colors.amber,
              //                               ),
              //                               itemCount: 5,
              //                               itemSize: 10.0,
              //                               direction: Axis.horizontal,
              //                             ),
              //                             SizedBox(width:5),
              //                             Text("0 Reviews")
              //                           ],
              //                         ),
              //                         Text("Ag Inc LLc"),
              //                       ],
              //                     ),
              //                   ],
              //                 ),
              //                 Row(
              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                   children: [
              //                     Text("within 12 miles"),
              //                    SizedBox(
              //                      height: 30,
              //                      child: ElevatedButton(
              //
              //                          onPressed: (){
              //
              //
              //                          }, child: Text("Quato")),
              //                    )
              //                   ],
              //                 )
              //               ],
              //             ),
              //           ),
              //         ),
              //         const SizedBox(
              //           width: 5,
              //         )
              //       ],
              //     );
              //   },
              // ),
            ),

          */
            // const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
