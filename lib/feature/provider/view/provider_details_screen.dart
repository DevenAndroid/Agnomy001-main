import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/provider/model/category_model_item.dart';
import 'package:demandium/feature/provider/view/category_item_view.dart';
import 'package:demandium/feature/provider/widgets/provider_details_top_card.dart';
import 'package:demandium/feature/provider/widgets/vertical_scrollable_tabview.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../model/provider_details_model.dart';

class ProviderDetailsScreen extends StatefulWidget {
  final String providerId;
  final String subCategories;

  const ProviderDetailsScreen({Key? key, required this.providerId, required this.subCategories}) : super(key: key);

  @override
  ProviderDetailsScreenState createState() => ProviderDetailsScreenState();
}

class ProviderDetailsScreenState extends State<ProviderDetailsScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;
  ProviderDetailsContent? _providerDetailsContent;
  ProviderDetailsContent? get providerDetailsContent => _providerDetailsContent;

  @override
  void initState() {
    super.initState();
    // Fetch provider details and initialize the tab controller
    Get.find<ProviderBookingController>().getProviderDetailsData(widget.providerId, true).then((value) {
      _providerDetailsContent = Get.find<ProviderBookingController>().providerDetailsContent;
      if (_providerDetailsContent != null) {
        tabController = TabController(length: _providerDetailsContent!.subscribedServices!.length, vsync: this);

        Get.find<CartController>().updatePreselectedProvider(
            _providerDetailsContent?.provider?.avgRating.toString() ?? "0",
            _providerDetailsContent?.provider?.id.toString() ?? "0",
            _providerDetailsContent?.provider?.logo.toString() ?? "0",
            _providerDetailsContent?.provider?.companyName.toString() ?? "0"
        );
      }
      setState(() {}); // Update the state to rebuild the UI with the fetched data
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: ResponsiveHelper.isDesktop(context) ? const MenuDrawer() : null,
      appBar: CustomAppBar(
        title: "provider_details".tr,
        showCart: true,
      ),
      body: Center(
        child: GetBuilder<ProviderBookingController>(
          builder: (providerBookingController) {
            if (providerBookingController.providerDetailsContent != null) {
              if (providerBookingController.providerDetailsContent!.subscribedServices!.isEmpty) {
                return Column(
                  children: [
                     if (providerBookingController.providerDetailsContent?.provider?.serviceAvailability == 0)
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.error.withOpacity(0.1),
                          border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.error)),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.paddingSizeDefault,
                            horizontal: Dimensions.paddingSizeLarge
                        ),
                        child: Center(
                          child: Text(
                            'provider_is_currently_unavailable'.tr,
                            style: ubuntuMedium,
                          ),
                        ),
                      ),
                    SizedBox(
                        width: Dimensions.webMaxWidth,
                        child: ProviderDetailsTopCard(
                          isAppbar: false,
                          subcategories: widget.subCategories,
                          providerId: widget.providerId,
                        )
                    ),
                    SizedBox(
                      height: Get.height * 0.6,
                      width: Dimensions.webMaxWidth,
                      child: Center(
                        child: Text('no_subscribed_subcategories_available'.tr),
                      ),
                    ),
                  ],
                );
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [

                      if (providerBookingController.providerDetailsContent?.provider?.serviceAvailability == 0)
                        SizedBox(
                          width: Dimensions.webMaxWidth,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.error.withOpacity(0.1),
                              border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.error)),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.paddingSizeDefault,
                                horizontal: Dimensions.paddingSizeLarge
                            ),
                            child: Center(
                              child: Text(
                                'provider_is_currently_unavailable'.tr,
                                style: ubuntuMedium,
                              ),
                            ),
                          ),
                        ),
                      SizedBox(
                        height: Get.height * 0.9,
                        width: Dimensions.webMaxWidth,
                        child: VerticalScrollableTabView(
                          tabController: tabController,
                          listItemData: providerBookingController.providerDetailsContent!.subscribedServices!,
                          //providerBookingController.categoryItemList,
                          verticalScrollPosition: VerticalScrollPosition.begin,

                          eachItemChild: (object, index) =>
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                         border: Border.all(
                                           color: Theme.of(context).primaryColor
                                         )
                                         // color: Colors.blue
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(providerBookingController.providerDetailsContent!.subscribedServices![index].name.toString(),
                        style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge),

                                              ),

                                              Text(providerBookingController.providerDetailsContent!.subscribedServices![index].shortDescription.toString(),
                                              ),
                                              SizedBox(height: 8),

                                              // Html(
                                              //   data:providerBookingController.providerDetailsContent!.subscribedServices![index].description.toString(),
                                              //  // tagsList: Html.tags,
                                              //
                                              // ),
                                              Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeDefault)),
                            child: CustomImage(
                              image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/service/${providerBookingController.providerDetailsContent!.subscribedServices![index].thumbnail.toString()}',
                               height: Dimensions.imageSizeButton,
                              width: Dimensions.imageSizeButton,
                            ),
                          ),
                          const SizedBox(width: 20,),
                          // Container(
                          //    color: Colors.red,
                          //   width: Get.width*0.5,
                          //   child:
                            // Html(
                            //   data:providerBookingController.providerDetailsContent!.subscribedServices![index].description.toString(),
                              // tagsList: Html.tags,

                            //),
                            //Text(providerBookingController.providerDetailsContent!.subscribedServices![index].shortDescription.toString(),

                           // ),
                         // ),

                          ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeDefault)),
                            child: CustomImage(
                              image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/service/${providerBookingController.providerDetailsContent!.subscribedServices![index].coverImage.toString()}',
                              height: Dimensions.imageSizeButton,
                              width: Dimensions.imageSizeButton,
                            ),
                          ),
                        ],
                                              ),
                                    Html(
                                    data:providerBookingController.providerDetailsContent!.subscribedServices![index].description.toString(),),

                                              providerBookingController.providerDetailsContent!.subscribedServices![index].providerDescription == null ?//
                                   const SizedBox(height: 0,width: 0,)
                                                  :  Text(providerBookingController.providerDetailsContent!.subscribedServices![index].providerDescription.toString())




                                            ],
                                          ),
                                        ),
                                      ),
                                    ),


                             // CategorySection(category: object as CategoryModelItem),
                          slivers: [
                            SliverAppBar(
                              automaticallyImplyLeading: false,
                              backgroundColor: Get.isDarkMode ? null : Theme.of(context).cardColor,
                              pinned: true,
                              leading: const SizedBox(),
                              actions: const [SizedBox()],
                              flexibleSpace: ProviderDetailsTopCard(
                                subcategories: widget.subCategories,
                                providerId: widget.providerId,
                              ),
                              toolbarHeight: 200,
                              elevation: 0,
                              bottom: TabBar(
                                isScrollable: true,
                                controller: tabController,
                                indicatorPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                                indicatorColor: Get.isDarkMode ? Colors.white70 : Theme.of(context).primaryColor,
                                labelColor: Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor,
                                unselectedLabelColor: Colors.grey,
                                padding: const EdgeInsets.only(bottom: 10),
                                indicatorWeight: 3.0,
                                tabs: providerBookingController.providerDetailsContent!.subscribedServices!
                                    .map((e) => Tab(text: e.name))
                                    .toList(),
                                onTap: (index) {
                                  VerticalScrollableTabBarStatus.setIndex(index);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                       ResponsiveHelper.isDesktop(context) ? const FooterView() : const SizedBox(),
                    ],
                  ),
                );
              }
            } else {
              return const FooterBaseView(
                  child: WebShadowWrap(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
              );
            }
          },
        ),
      ),
    );
  }
}
