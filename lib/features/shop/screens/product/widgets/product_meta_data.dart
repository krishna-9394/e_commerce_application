import 'package:e_commerce_application/common/widgets/custom_shape/container/rounded_container.dart';
import 'package:e_commerce_application/common/widgets/texts/product_price_text.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Sale Tag
        TRoundedContainer(
          borderRadius: TSizes.sm,
          backgroundColor: TColors.secondary.withOpacity(0.8),
          padding: const EdgeInsets.symmetric(
              horizontal: TSizes.sm, vertical: TSizes.xs),
          child: Text(
            '25%',
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .apply(color: TColors.black),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        /// Price Tag
        const TProductPriceText(
          price: '250',
          isSmall: true,
          isLarge: false,
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        const TProductPriceText(
          price: '175',
          isLarge: true,
        )
      ],
    );
  }
}
