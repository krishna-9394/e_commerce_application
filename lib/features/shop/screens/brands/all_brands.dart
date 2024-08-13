import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/common/widgets/brands/brand_card.dart';
import 'package:e_commerce_application/common/widgets/layout/grid_layout.dart';
import 'package:e_commerce_application/common/widgets/shimmer/brands_shimmer.dart';
import 'package:e_commerce_application/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_application/features/shop/controllers/brand_controller.dart';
import 'package:e_commerce_application/features/shop/models/brand_model.dart';
import 'package:e_commerce_application/features/shop/screens/brands/brand_products.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBrandScreen extends StatelessWidget {
  const AllBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Brands'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const TSectionHeading(
                title: 'Brands',
                showActionButton: false,
              ),
              const SizedBox(height: TSizes.defaultSpace),
              /// Rounded Container
              Obx(() {
                if (controller.isLoading.value) {
                  return const TBrandShimmer();
                }

                if (controller.allBrands.isEmpty) {
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
                    itemCount: controller.allBrands.length,
                    mainAxisExtent: 80,
                    itemBuiler: (_, index) {
                      final BrandModel brand = controller.allBrands[index];
                      return TBrandCard(
                        brand: brand,
                        showBorder: true,
                        onPressed: () => Get.to(() => TBrandProduct(brand: brand,)),
                      );
                    });
              })

            ],
          ),
        ),
      ),
    );
  }
}
