import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class BookingStatusTabItem extends GetView<ServiceBookingController> {
  const BookingStatusTabItem({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall,vertical: 5),
      decoration: BoxDecoration(
        color: controller.selectedBookingStatus.name != title ? Colors.grey.withOpacity(0.2): Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(mainAxisSize: MainAxisSize.min ,children: [
        Image.asset(title.png, height: 25, width: 20, color: controller.selectedBookingStatus.name != title ? null : Colors.white),
        const SizedBox(width: 5,),
        Text( title.tr,
          textAlign: TextAlign.center,
          style:ubuntuMedium.copyWith(
            fontSize: Dimensions.fontSizeSmall,
            color: controller.selectedBookingStatus.name != title?
            Theme.of(context).textTheme.bodyLarge!.color: Colors.white,
          ),
        ),

      ],),
    );
  }
}

extension on String {
  String get png => 'assets/images/$this.png';
}