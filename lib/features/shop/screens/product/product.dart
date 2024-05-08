import 'package:e_commerce_application/features/shop/screens/product/widgets/product_image_slider.dart';
import 'package:e_commerce_application/features/shop/screens/product/widgets/rating_and_share_widget.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Product Image Slider
            TProductImageSlider(),

            /// Product Details
            Padding(
              padding: EdgeInsets.only(
                bottom: TSizes.defaultSpace,
                left: TSizes.defaultSpace,
                right: TSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  /// Rating and Share Button
                  RatingAndShare(rating: 5.0, reviewCount: 199)
                  /// Product Meta Data
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
