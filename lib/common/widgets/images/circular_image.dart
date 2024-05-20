import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_application/common/widgets/shimmer/shimmer_efftect.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TCircularImage extends StatelessWidget {
  final String image;
  final double? height, width;
  final double padding;
  final Color? overlay;
  final Color? backgroundColor;
  final BoxFit fit;
  final bool isNetworkImage;
  const TCircularImage({
    super.key,
    required this.image,
    this.height = 56,
    this.width = 56,
    this.overlay,
    this.backgroundColor,
    this.fit = BoxFit.cover,
    this.isNetworkImage = true,
    this.padding = TSizes.sm,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ?? (isDark ? TColors.black : TColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Center(
          child: isNetworkImage
              ? CachedNetworkImage(
                  imageUrl: image,
                  fit: fit,
                  color: overlay,
                  progressIndicatorBuilder: (context, url, downloadProdgress) =>
                      TShimmerEfftect(width: width ?? 56, height: height ?? 56),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : Image(
                  color: overlay,
                  fit: fit,
                  width: width ?? 56,
                  height: height ?? 56,
                  image: AssetImage(image) as ImageProvider,
                ),
        ),
      ),
    );
  }
}
