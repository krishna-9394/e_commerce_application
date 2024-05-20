import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/common/widgets/brands/brand_card.dart';
import 'package:e_commerce_application/common/widgets/products/sortable/sortable_products.dart';
import 'package:e_commerce_application/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:e_commerce_application/features/shop/controllers/product/brand_controller.dart';
import 'package:e_commerce_application/features/shop/models/brand_model.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

class TBrandProduct extends StatelessWidget {
  const TBrandProduct({super.key, required this.brand});
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(brand.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TBrandCard(
                showBorder: true,
                brand: brand,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              FutureBuilder(
                  future: controller.getBrandProducts(brandId: brand.id),
                  builder: (context, snapshot) {
                    const loader = TVerticalProductShimmer();
                    final widget = TCloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;
                    final brandProducts = snapshot.data!;
                    return TSortableProducts(
                      products: brandProducts,
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
