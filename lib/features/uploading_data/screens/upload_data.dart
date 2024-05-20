import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_application/features/uploading_data/controllers/upload_data_controller.dart';
import 'package:e_commerce_application/features/uploading_data/screens/widgets/uploading_menu_tile.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UploadDataScreen extends StatelessWidget {
  const UploadDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UploadDataController());
    return Scaffold(
      // AppBar
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Upload Data',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Section Heading
              const TSectionHeading(
                title: 'Main Record',
                showActionButton: false,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              // Upload Categories
              TUploadingMenuTile(
                controller: controller,
                title: 'Upload Categories',
                icon: Iconsax.category,
                onPressed: () => controller.uploadCategories(),
                option: uploads.category,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              // Upload Brands
              TUploadingMenuTile(
                controller: controller,
                title: 'Upload Brands',
                icon: Iconsax.shop,
                onPressed: () => controller.uploadBrands(),
                option: uploads.brand,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              // Upload Products
              TUploadingMenuTile(
                controller: controller,
                title: 'Upload Products',
                icon: Iconsax.shopping_cart,
                onPressed: () => controller.uploadProducts(),
                option: uploads.product,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              // Upload Banners
              TUploadingMenuTile(
                controller: controller,
                title: 'Upload Banners',
                icon: Iconsax.image,
                onPressed: () => controller.uploadBanners(),
                option: uploads.banner,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              const TSectionHeading(
                title: 'Relations',
                showActionButton: false,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              TUploadingMenuTile(
                controller: controller,
                title: 'Upload Relations',
                icon: Iconsax.info_circle,
                onPressed: () => controller.uploadRelations(),
                option: uploads.relation,
              ),

              TextButton(
                onPressed: () {},
                child: const Text(
                  'Close Account',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
