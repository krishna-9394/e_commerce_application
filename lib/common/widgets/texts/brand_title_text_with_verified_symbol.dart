import 'package:e_commerce_application/common/widgets/texts/brand_title_text.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/enums.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TBrandTitleTextWithVerifiedSymbol extends StatelessWidget {
  final String title;
  final Color? iconColor, textColor;
  final int maxLine;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;
  const TBrandTitleTextWithVerifiedSymbol({
    super.key,
    required this.title,
    this.textColor,
    this.iconColor = TColors.primary,
    this.maxLine = 1,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: TBrandTitleText(
            title: title,
            maxLine: maxLine,
            textColor: textColor,
            brandTextSizes: brandTextSize,
          ),
        ),
        const SizedBox(width: TSizes.xs),
        Icon(
          Iconsax.verify5,
          size: TSizes.iconXs,
          color: iconColor,
        ),
      ],
    );
  }
}
