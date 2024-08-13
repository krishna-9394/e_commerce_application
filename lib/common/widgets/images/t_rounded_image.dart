import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TRoundedImage extends StatelessWidget {
  final double? height, width;
  final String imageURL;
  final bool applyImageRadius;
  final Color? backgroundColor;
  final BoxFit? fit;
  final BoxBorder? border;
  final EdgeInsetsGeometry? padding, margin;
  final bool isNetworkImage;
  final VoidCallback? onTap;
  final double borderRadius;


  const TRoundedImage({
    super.key,
    this.height,
    this.width,
    required this.imageURL,
    this.applyImageRadius = true,
    this.backgroundColor,
    this.fit = BoxFit.contain,
    this.padding,
    this.isNetworkImage = false,
    this.onTap,
    this.border,
    this.borderRadius = TSizes.md,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: isDark ? TColors.dark : TColors.light,
          border: border,
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child:
          Image(
            fit: fit,
            image: isNetworkImage
                ? NetworkImage(imageURL)
                : AssetImage(imageURL) as ImageProvider,
          ),
        ),
      ),
    );
  }
}
