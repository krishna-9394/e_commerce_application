import 'package:e_commerce_application/common/widgets/images/circular_image.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TVerticalImageText extends StatelessWidget {
  final String text, image;
  final Color textColor;
  final Color? backgroundColor;
  final bool isNetworkImage;
  final VoidCallback? onTap;

  const TVerticalImageText({
    super.key,
    required this.text,
    required this.image,
    this.textColor = Colors.white,
    this.backgroundColor,
    this.onTap,
    this.isNetworkImage = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
        child: Column(
          children: [
            /// Circular Icon
            TCircularImage(
              image: image,
              fit: BoxFit.fitWidth,
              padding: TSizes.sm * 1.4,
              backgroundColor: backgroundColor,
              overlay:  isDark ? TColors.light : TColors.dark,
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),

            /// label
            Expanded(
              child: SizedBox(
                width: 55,
                child: Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .apply(color: textColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
