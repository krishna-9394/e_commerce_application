import 'package:e_commerce_application/common/styles/shadow.dart';
import 'package:e_commerce_application/common/widgets/custom_shape/container/rounded_container.dart';
import 'package:e_commerce_application/common/widgets/images/t_rounded_image.dart';
import 'package:e_commerce_application/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:e_commerce_application/common/widgets/texts/brand_title_text_with_verified_symbol.dart';
import 'package:e_commerce_application/common/widgets/texts/product_price_text.dart';
import 'package:e_commerce_application/common/widgets/texts/product_title_text.dart';
import 'package:e_commerce_application/features/shop/controllers/product/product_controller.dart';
import 'package:e_commerce_application/features/shop/models/products/product_model.dart';
import 'package:e_commerce_application/features/shop/screens/product_detail/product.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/dummy_data.dart';
import 'package:e_commerce_application/utils/constants/image_strings.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class THorizontalProductCard extends StatelessWidget {
  const THorizontalProductCard({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final bool isDark = THelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSaleDiscount(product.price, product.salePrice);
    final price = controller.getProductPrice(product);
    return GestureDetector(
      onTap: () => Get.to(ProductDetails(product: product)),
      child: Container(
        width: 312,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.horizontalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: isDark ? TColors.darkGrey : TColors.white,
        ),
        child: Row(
          children: [
            /// Thumbnail,  Wishlist Button, Discount Tag
            TRoundedContainer(
              height: 120,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: isDark ? TColors.darkGrey : TColors.light,
              child: Stack(
                children: [
                  /// Thumbnail Image
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: TRoundedImage(
                      imageURL: product.thumbnail,
                      applyImageRadius: true,
                    ),
                  ),

                  /// Discount Tag
                  if (product.salePrice > 0.0)
                    Positioned(
                      top: 12,
                      left: 5,
                      child: TRoundedContainer(
                        borderRadius: TSizes.sm,
                        backgroundColor: TColors.secondary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: TSizes.sm, vertical: TSizes.xs),
                        child: Text(
                          '$salePercentage%',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: TColors.black),
                        ),
                      ),
                    ),

                  /// Wishlist Button
                  Positioned(
                      top: 0,
                      right: 0,
                      child: TFavouriteIcons(
                        productId: product.id,
                      )),
                ],
              ),
            ),

            /// Details
            SizedBox(
              width: 174,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Product Brand and Verification symbol
                  Padding(
                    padding:
                        const EdgeInsets.only(top: TSizes.sm, left: TSizes.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Product title
                        TProductTitleText(
                          title: product.title,
                          maxline: 2,
                          smallSize: true,
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems / 2),

                        /// Brand and verification icon
                        TBrandTitleTextWithVerifiedSymbol(
                          title: product.brand!.name,
                        ),
                      ],
                    ),
                  ),

                  ///
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          children: [
                            if (product.productType ==
                                    ProductType.single.toString() &&
                                product.salePrice > 0)
                              Padding(
                                padding: const EdgeInsets.only(left: TSizes.sm),
                                child: Text(
                                  product.price.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .apply(
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.only(left: TSizes.sm),
                              child: TProductPriceText(
                                price: price,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: TColors.dark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(TSizes.cardRadiusMd),
                            bottomRight:
                                Radius.circular(TSizes.productImageRadius),
                          ),
                        ),
                        child: const SizedBox(
                          height: TSizes.iconLg * 1.2,
                          width: TSizes.iconLg * 1.2,
                          child: Center(
                            child: Icon(
                              Iconsax.add,
                              color: TColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
