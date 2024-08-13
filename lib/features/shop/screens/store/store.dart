import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/common/widgets/appbar/tabbar.dart';
import 'package:e_commerce_application/common/widgets/brands/brand_card.dart';
import 'package:e_commerce_application/common/widgets/custom_shape/container/search_container.dart';
import 'package:e_commerce_application/common/widgets/layout/grid_layout.dart';
import 'package:e_commerce_application/common/widgets/products/cart/cart_counter_icon_button.dart';
import 'package:e_commerce_application/common/widgets/shimmer/brands_shimmer.dart';
import 'package:e_commerce_application/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_application/features/shop/controllers/brand_controller.dart';
import 'package:e_commerce_application/features/shop/controllers/category_controller.dart';
import 'package:e_commerce_application/features/shop/models/brand_model.dart';
import 'package:e_commerce_application/features/shop/screens/brands/all_brands.dart';
import 'package:e_commerce_application/features/shop/screens/brands/brand_products.dart';
import 'package:e_commerce_application/features/shop/screens/store/widgets/category_tab.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = CategoryController.instance.featuredCategories;
    final controller = Get.put(BrandController());
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        /// Appbar
        appBar: TAppBar(
          showBackArrow: false,
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: const [
            TCartCounterIconButton(
            )
          ],
        ),

        /// body
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: THelperFunctions.isDarkMode(context)
                    ? TColors.dark
                    : TColors.white,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const SizedBox(height: TSizes.spaceBtwItems),
                      const TSearchBar(
                        text: 'Search in store',
                        showBackground: false,
                        showBorder: true,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      /// Featured Branding
                      TSectionHeading(
                        title: 'Featured Brands',
                        onPressed: () => Get.to(() => const AllBrandScreen()),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                      /// Rounded Container
                      Obx(() {
                        if (controller.isLoading.value) {
                          return const TBrandShimmer();
                        }

                        if (controller.featuredBrands.isEmpty) {
                          return Center(
                            child: Text(
                              'No Data found',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .apply(color: Colors.white),
                            ),
                          );
                        }

                        return TGridLayout(
                            itemCount: controller.featuredBrands.length,
                            mainAxisExtent: 80,
                            itemBuiler: (_, index) {
                              final BrandModel brand =
                                  controller.featuredBrands[index];
                              return TBrandCard(
                                brand: brand,
                                onPressed: () => Get.to(() => TBrandProduct(
                                      brand: brand,
                                    )),
                                showBorder: true,
                              );
                            });
                      })
                    ],
                  ),
                ),
                bottom: TTabBar(
                  tabs: categories
                      .map(
                        (e) => Tab(
                          child: Text(e.name),
                        ),
                      )
                      .toList(),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: categories
                .map((category) => TCategoryTab(category: category))
                .toList(),
          ),
        ),
      ),
    );
  }
}
