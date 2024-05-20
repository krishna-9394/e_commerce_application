import 'package:e_commerce_application/common/widgets/custom_shape/container/rounded_container.dart';
import 'package:e_commerce_application/common/widgets/texts/product_price_text.dart';
import 'package:e_commerce_application/common/widgets/texts/product_title_text.dart';
import 'package:e_commerce_application/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_application/features/shop/controllers/product/variation_controller.dart';
import 'package:e_commerce_application/features/shop/models/products/product_model.dart';
import 'package:e_commerce_application/features/shop/screens/product_detail/widgets/choice_chip.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductAttributes extends StatelessWidget {
  final ProductModel product;
  const ProductAttributes({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VariationController());
    final isDark = THelperFunctions.isDarkMode(context);

    return Obx(
      () => Column(
        children: [
          /// Selected Attribute Pricing & Description
          if (controller.selectedVariation.value.id.isNotEmpty)
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
                          Row(
                            children: [
                              const TProductTitleText(
                                  title: 'Price :', smallSize: true),
                              // Actual Price
                              if (controller.selectedVariation.value.salePrice >
                                  0)
                                TProductPriceText(
                                  price: controller
                                      .selectedVariation.value.price
                                      .toString(),
                                  addCurrencySymbol: true,
                                  isLarge: false,
                                  isSmall: true,
                                  lineThrough: true,
                                ),
                              if (controller.selectedVariation.value.salePrice >
                                  0)
                                const SizedBox(width: TSizes.spaceBtwItems),
                              TProductPriceText(
                                price: controller.getVariationPrice(),
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
                                controller.variationStockStatus.value,
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  if(controller.selectedVariation.value.description != null && controller.selectedVariation.value.description! != '')
                    TProductTitleText(
                      title: controller.selectedVariation.value.description ?? '',
                      smallSize: true,
                      maxline: 4,
                    ),
                ],
              ),
            ),
          if (controller.selectedVariation.value.id.isNotEmpty)
            const SizedBox(height: TSizes.spaceBtwItems),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!
                .map(
                  (attribute) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TSectionHeading(
                          title: attribute.name ?? '', showActionButton: false),
                      const SizedBox(height: TSizes.defaultSpace / 2),
                      Obx(
                        () => Wrap(
                          spacing: 8,
                          children: attribute.values!.map(
                            (attributeValue) {
                              final isSelected = controller
                                      .selectedAttributes[attribute.name] ==
                                  attributeValue;
                              final isAvailable = controller
                                  .getAttributesAvailabilityInVariation(
                                      product.productVariations!,
                                      attribute.name!)
                                  .contains(attributeValue);

                              return TChoiceChip(
                                text: attributeValue,
                                selected: isSelected,
                                onSelected: isAvailable
                                    ? (selected) {
                                        if (isAvailable && selected) {
                                          controller.onAttributeSelected(
                                            product,
                                            attribute.name ?? '',
                                            attributeValue,
                                          );
                                        }
                                      }
                                    : null,
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
