import 'package:e_commerce_application/common/widgets/custom_shape/container/curved_edges_widget_container.dart';
import 'package:e_commerce_application/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_application/features/admin/controllers/category_controller_admin.dart';
import 'package:e_commerce_application/features/admin/screens/brand/delete_brand.dart';
import 'package:e_commerce_application/features/admin/screens/brand/update_brand.dart';
import 'package:e_commerce_application/features/admin/screens/category/delete_category.dart';
import 'package:e_commerce_application/features/admin/screens/category/update_category.dart';
import 'package:e_commerce_application/features/admin/screens/product/add_product.dart';
import 'package:e_commerce_application/features/admin/screens/product/delete_product.dart';
import 'package:e_commerce_application/features/admin/screens/product/update_product.dart';
import 'package:e_commerce_application/features/shop/controllers/product/product_controller.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../common/widgets/appbar/appbar.dart';
import '../../../common/widgets/list_tile/setting_menu_tile.dart';
import '../../../common/widgets/list_tile/user_profile_tile.dart';
import '../../personalization/screens/profile/profile.dart';
import 'brand/add_brand.dart';
import 'category/add_category.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            TPrimaryCurvedEdgesWidget(
              child: Column(
                children: [
                  /// AppBar
                  TAppBar(
                    showBackArrow: false,
                    title: Text(
                      'Upload',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: Colors.white),
                    ),
                  ),

                  /// Profile Card
                  TUserProfileTile(
                    onPressed: () => Get.to(
                      const ProfileScreen(),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// body
                  const TSectionHeading(
                    title: 'Category',
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  TSettingMenuTile(
                    title: 'Add',
                    subTitle: 'Add a category to Catalogue',
                    icon: Iconsax.safe_home,
                    onTap: () => Get.to(() => const CategoryAdditionScreen()),
                  ),

                  TSettingMenuTile(
                    title: 'Update',
                    subTitle:
                        'Update details of specific Category from Catalogue',
                    icon: Iconsax.shopping_cart,
                    onTap: () {
                      Get.to(() => const CategoryUpdateScreen());
                    },
                  ),

                  TSettingMenuTile(
                    title: 'Remove',
                    subTitle:
                        'Delete specific Category from Catalogue',
                    icon: Iconsax.shopping_cart,
                    onTap: () {
                      Get.to(() => const CategoryDeleteScreen());
                    },
                  ),

                  const SizedBox(height: TSizes.spaceBtwItems),
                  const TSectionHeading(
                    title: 'Brands',
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  TSettingMenuTile(
                    title: 'Add',
                    subTitle: 'Add a Brand to Catalogue',
                    icon: Iconsax.bag_tick,
                    onTap: () => Get.to(() => const BrandAdditionScreen()),
                  ),
                  TSettingMenuTile(
                    title: 'Update',
                    subTitle: 'Update a Brand from Catalogue',
                    icon: Iconsax.bank,
                    onTap: () => Get.to(() => const BrandUpdateScreen()),
                  ),
                  TSettingMenuTile(
                    title: 'Remove',
                    subTitle: 'Remove a Brand from Catalogue',
                    icon: Iconsax.bank,
                    onTap: () => Get.to(() => const BrandDeleteScreen()),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  const TSectionHeading(
                    title: 'Products',
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  TSettingMenuTile(
                    title: 'Add',
                    subTitle: 'Add a product to Catalogue',
                    icon: Iconsax.discount_shape,
                    onTap: () => Get.to(() => const ProductAdditionScreen()),
                  ),
                  TSettingMenuTile(
                    title: 'Update',
                    subTitle: 'Update details of product in Catalogue',
                    icon: Iconsax.discount_shape,
                    onTap: () => Get.to(() => const ProductUpdateScreen()),
                  ),
                  TSettingMenuTile(
                    title: 'Remove',
                    subTitle: 'Remove a Product from Catalogue',
                    icon: Iconsax.notification,
                    onTap: () => Get.to(() => const ProductDeleteScreen()),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections * 2.5),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
