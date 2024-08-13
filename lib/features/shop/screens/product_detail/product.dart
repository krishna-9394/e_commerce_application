import 'package:e_commerce_application/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_application/features/shop/models/products/product_model.dart';
import 'package:e_commerce_application/features/shop/screens/product_detail/widgets/bottom_add_to_cart.dart';
import 'package:e_commerce_application/features/shop/screens/product_detail/widgets/product_image_slider.dart';
import 'package:e_commerce_application/features/shop/screens/product_detail/widgets/product_meta_data.dart';
import 'package:e_commerce_application/features/shop/screens/product_detail/widgets/products_attributes.dart';
import 'package:e_commerce_application/features/shop/screens/product_detail/widgets/rating_and_share_widget.dart';
import 'package:e_commerce_application/features/shop/screens/product_review/product_review.dart';
import 'package:e_commerce_application/utils/constants/dummy_data.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TBottomAddToCart(product: product),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Product Image Slider
            TProductImageSlider(product: product),

            /// Product Details
            Padding(
              padding: const EdgeInsets.only(
                bottom: TSizes.defaultSpace,
                left: TSizes.defaultSpace,
                right: TSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  /// Rating and Share Button
                  const RatingAndShare(rating: 5.0, reviewCount: 199),

                  /// Product Meta Data
                  TProductMetaData(product: product),

                  /// Attributes
                  if (product.productType == ProductType.variable.toString())
                    ProductAttributes(product: product),
                  if (product.productType == ProductType.variable.toString())
                    const SizedBox(height: TSizes.spaceBtwSections),

                  /// Checkout Button
                  const TSectionHeading(
                    title: 'Description',
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  ReadMoreText(
                    product.description ?? 'Description is unavailable.',
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more',
                    trimExpandedText: ' Less',
                    moreStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// Review
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TSectionHeading(
                        title: 'Reviews (199) ',
                        showActionButton: false,
                      ),
                      IconButton(
                        onPressed: () => Get.to(const ProductReviewScreen()),
                        icon: const Icon(
                          Iconsax.arrow_right_3,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
