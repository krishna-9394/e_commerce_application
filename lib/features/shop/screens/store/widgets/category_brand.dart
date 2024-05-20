import 'package:e_commerce_application/common/widgets/brands/brand_show_case.dart';
import 'package:e_commerce_application/common/widgets/shimmer/box_shimmer.dart';
import 'package:e_commerce_application/common/widgets/shimmer/list_tile_shimmer.dart';
import 'package:e_commerce_application/features/shop/controllers/product/brand_controller.dart';
import 'package:e_commerce_application/features/shop/models/category_model.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
      future: controller.getBrandForCategory(category.id),
      builder: (context, snapshot) {
        /// Handle loader, No Records or Error Message
        const loader = Column(children: [
          TListTileShimmer(),
          SizedBox(height: TSizes.spaceBtwItems),
          TBoxShimmer(),
          SizedBox(height: TSizes.spaceBtwItems),
        ]);

        final widget = TCloudHelperFunctions.checkMultiRecordState(
            snapshot: snapshot, loader: loader, nothingFound: const Center(child: Text('No Brands Found!')));
        // TODO: for Furniture category it shows No data found

        if (widget != null) return widget;

        final brands = snapshot.data!;

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: brands.length,
          itemBuilder: (_, index) {
            final brand = brands[index];
            return FutureBuilder(
                future:
                    controller.getBrandProducts(brandId: brand.id, limit: 3),
                builder: ((context, snapshot) {
                  // Handle loader, No Records or error Message
                  final widget = TCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                    loader: loader,
                  );
                  if (widget != null) return widget;

                  final products = snapshot.data!;
                  return TBrandShowCase(
                      brand: brand,
                      images: products
                          .map((product) => product.thumbnail)
                          .toList());
                }));
          },
        );
      },
    );
  }
}

