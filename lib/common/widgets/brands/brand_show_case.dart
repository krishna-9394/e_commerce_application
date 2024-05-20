import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_application/common/widgets/brands/brand_card.dart';
import 'package:e_commerce_application/common/widgets/custom_shape/container/rounded_container.dart';
import 'package:e_commerce_application/common/widgets/shimmer/shimmer_efftect.dart';
import 'package:e_commerce_application/features/shop/models/brand_model.dart';
import 'package:e_commerce_application/features/shop/screens/brands/brand_products.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TBrandShowCase extends StatelessWidget {
  final BrandModel brand;
  final List<String> images;
  const TBrandShowCase({
    super.key,
    required this.brand,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => TBrandProduct(brand: brand)),
      child: TRoundedContainer(
        showBorder: true,
        padding: const EdgeInsets.all(TSizes.md),
        borderColor: TColors.darkGrey,
        backgroundColor: Colors.transparent,
        margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
        child: Column(
          children: [
            /// Brand with Count
            TBrandCard(
              showBorder: false,
              brand: brand,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            /// Brand Top 3 Product Images
            Row(
              children: images
                  .map((image) => topBrandProductShowcaseWidget(context, image))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget topBrandProductShowcaseWidget(BuildContext context, String image) {
    return Expanded(
      child: TRoundedContainer(
          height: 100,
          backgroundColor: THelperFunctions.isDarkMode(context)
              ? TColors.darkGrey
              : TColors.light,
          margin: const EdgeInsets.only(right: TSizes.sm),
          padding: const EdgeInsets.all(TSizes.sm),
          child: CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.contain,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                const TShimmerEfftect(width: 100, height: 100),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          )),
    );
  }
}
