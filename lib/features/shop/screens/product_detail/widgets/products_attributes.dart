import 'package:e_commerce_application/common/widgets/custom_shape/container/rounded_container.dart';
import 'package:e_commerce_application/common/widgets/texts/product_price_text.dart';
import 'package:e_commerce_application/common/widgets/texts/product_title_text.dart';
import 'package:e_commerce_application/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_application/features/shop/screens/product_detail/widgets/choice_chip.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        /// Selected Attribute Pricing & Description
        TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: isDark ? TColors.darkGrey : TColors.grey,
          child: Column(
            children: [
              /// Title, Pricing and Stock Status
              Row(
                children: [
                  const TSectionHeading(
                    title: 'Variation',
                    showActionButton: false,
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          TProductTitleText(title: 'Price :', smallSize: true),
                          SizedBox(width: TSizes.spaceBtwItems),
                          TProductPriceText(
                              price: '25',
                              isLarge: false,
                              isSmall: true,
                              lineThrough: true),
                          SizedBox(width: TSizes.spaceBtwItems),
                          TProductPriceText(
                            price: '20',
                            isLarge: false,
                            isSmall: false,
                            lineThrough: false,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const TProductTitleText(
                              title: 'Stock :', smallSize: true),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          Text(
                            'In Stock',
                            style: Theme.of(context).textTheme.titleMedium,
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              const TProductTitleText(
                title:
                    'This is the description of the product and it can got up to max 4 lines. ',
                smallSize: true,
                maxline: 4,
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(
              title: 'Colors',
              showActionButton: true,
            ),
            const SizedBox(height: TSizes.defaultSpace),
            Wrap(
              spacing: 8,
              children: [
                TChoiceChip(text: 'Green', selected: true, onSelected: (value) {}),
                TChoiceChip(text: 'Blue', selected: false, onSelected: (value) {}),
                TChoiceChip(text: 'Yellow', selected: false, onSelected: (value) {}),
                TChoiceChip(text: 'Brown', selected: false, onSelected: (value) {}),
                TChoiceChip(text: 'Black', selected: false, onSelected: (value) {}),
              ],
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(
              title: 'Size',
              showActionButton: true,
            ),
            const SizedBox(height: TSizes.defaultSpace),
            Wrap(
              spacing: 8,
              children: [
                TChoiceChip(text: 'EU 34', selected: true, onSelected: (value) {}),
                TChoiceChip(text: 'EU 36', selected: false, onSelected: (value) {}),
                TChoiceChip(text: 'EU 38', selected: false, onSelected: (value) {}),
                TChoiceChip(text: 'EU 40', selected: false, onSelected: (value) {}),
                TChoiceChip(text: 'EU 42', selected: false, onSelected: (value) {}),
              ],
            )
          ],
        )
      ],
    );
  }
}
