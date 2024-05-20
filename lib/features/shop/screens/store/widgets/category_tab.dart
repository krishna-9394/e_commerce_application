import 'package:e_commerce_application/common/widgets/layout/grid_layout.dart';
import 'package:e_commerce_application/common/widgets/products/product_cards/vertical_product_card.dart';
import 'package:e_commerce_application/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:e_commerce_application/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_application/features/shop/controllers/product/category_controller.dart';
import 'package:e_commerce_application/features/shop/models/category_model.dart';
import 'package:e_commerce_application/features/shop/screens/all_products/all_products.dart';
import 'package:e_commerce_application/features/shop/screens/store/widgets/category_brand.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TCategoryTab extends StatelessWidget {
  final CategoryModel category;

  const TCategoryTab({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Brand
              CategoryBrands(category: category),
              const SizedBox(height: TSizes.spaceBtwItems),
              FutureBuilder(
                future: controller.getCategoryProducts(categoryId: category.id),
                builder: (context, snapshot) {
                  final response = Column(children: [
                    TSectionHeading(
                        title: 'You might like',
                        showActionButton: true,
                        onPressed: () => Get.to(() => AllProducts(
                            title: category.name,
                            futureMethod: controller.getCategoryProducts(
                              categoryId: category.id,
                              limit: -1,
                            ))),
                      ),
                      
                  ],);
                  final widget = TCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                    loader: const TVerticalProductShimmer(), 
                    nothingFound: response,
                  );

                  if (widget != null) return widget;
                  final products = snapshot.data!;
                  return Column(
                    children: [
                      /// Products
                      TSectionHeading(
                        title: 'You might like',
                        showActionButton: true,
                        onPressed: () => Get.to(() => AllProducts(
                            title: category.name,
                            futureMethod: controller.getCategoryProducts(
                              categoryId: category.id,
                              limit: -1,
                            ))),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      TGridLayout(
                        itemCount: products.length,
                        itemBuiler: (_, index) => TVerticalProductCard(
                          product: products[index],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
