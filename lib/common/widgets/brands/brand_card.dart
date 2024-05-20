import 'package:e_commerce_application/common/widgets/custom_shape/container/rounded_container.dart';
import 'package:e_commerce_application/common/widgets/images/circular_image.dart';
import 'package:e_commerce_application/common/widgets/texts/brand_title_text_with_verified_symbol.dart';
import 'package:e_commerce_application/features/shop/models/brand_model.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TBrandCard extends StatelessWidget {
  final bool showBorder;
  final BrandModel brand;
  final VoidCallback? onPressed;
  const TBrandCard({
    super.key,
    required this.showBorder,
    this.onPressed, required this.brand,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onPressed,
      child: TRoundedContainer(
        padding: const EdgeInsets.all(TSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            /// Icon
            Flexible(
              child: TCircularImage(
                image: brand.image,
                isNetworkImage: true,
                backgroundColor: Colors.transparent,
                overlay: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),

            /// Text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TBrandTitleTextWithVerifiedSymbol(title: brand.name),
                  Text(
                    '${brand.productsCount} products',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
