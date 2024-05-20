import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/common/widgets/custom_shape/container/curved_edges_widget_container.dart';
import 'package:e_commerce_application/common/widgets/custom_shape/container/search_container.dart';
import 'package:e_commerce_application/common/widgets/layout/grid_layout.dart';
import 'package:e_commerce_application/common/widgets/products/product_cards/vertical_product_card.dart';
import 'package:e_commerce_application/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:e_commerce_application/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_application/features/shop/controllers/product/all_product_controller.dart';
import 'package:e_commerce_application/features/shop/controllers/product/product_controller.dart';
import 'package:e_commerce_application/features/shop/screens/all_products/all_products.dart';
import 'package:e_commerce_application/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:e_commerce_application/features/shop/screens/home/widgets/home_categories.dart';
import 'package:e_commerce_application/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const TPrimaryCurvedEdgesWidget(
              child: Column(
                children: [
                  /// Appbar and title
                  THomeAppBar(),
                  SizedBox(height: TSizes.spaceBtwSections),

                  /// Search Bar
                  TSearchBar(
                    text: 'Search in Store',
                    showBackground: false,
                    showBorder: true,
                    icon: Iconsax.search_normal,
                  ),
                  SizedBox(height: TSizes.spaceBtwSections),

                  /// Items Categories
                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        /// Heading
                        TSectionHeading(
                          showActionButton: false,
                          title: 'Popular Catergories',
                        ),
                        SizedBox(height: TSizes.spaceBtwItems),

                        /// Categories
                        HomeCategories(),
                        SizedBox(height: TSizes.spaceBtwItems),
                      ],
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            /// Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// Rounded Image banner
                  const TPromoSlider(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// Section Heading
                  TSectionHeading(
                    title: 'Popular Products',
                    onPressed: () => Get.to(
                      () => AllProducts(
                        title: 'Popular Products',
                        // query: FirebaseFirestore.instance
                        //     .collection('products')
                        //     .where('IsFeatured', isEqualTo: true)
                        //     .limit(6),
                        futureMethod: controller.fetchAllFeaturedProducts(),
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// Products in Grid;
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const TVerticalProductShimmer(itemCount: 4);
                    }

                    if (controller.featuredProducts.isEmpty) {
                      return Center(
                        child: Text(
                          'No Data Found!',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    }
                    return TGridLayout(
                      itemCount: controller.featuredProducts.length,
                      itemBuiler: (_, index) => TVerticalProductCard(
                        product: controller.featuredProducts[index],
                      ),
                    );
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
