import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/styles.dart';
import 'package:flutter/material.dart';

class WebMidSectionContentItem extends StatelessWidget {
  final String title;
  final String subTitle;
  const WebMidSectionContentItem({Key? key, required this.title,required this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title, textAlign: TextAlign.center,
          style: ubuntuTitleSM.copyWith(fontSize: 28,),
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        Text(
          subTitle, textAlign: TextAlign.start,
          style: ubuntuRegular.copyWith(
              color: Theme.of(context).secondaryHeaderColor,
              fontSize: 17
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),
      ],
    );
  }
}

