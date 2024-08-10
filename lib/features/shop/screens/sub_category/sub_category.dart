import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/common/widgets/images/t_rounded_image.dart';
import 'package:e_commerce_application/common/widgets/products/product_cards/horizontal_product_card.dart';
import 'package:e_commerce_application/common/widgets/shimmer/horizontal_product_shimmer.dart';
import 'package:e_commerce_application/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_application/features/shop/controllers/product/category_controller.dart';
import 'package:e_commerce_application/features/shop/models/category_model.dart';
import 'package:e_commerce_application/features/shop/screens/all_products/all_products.dart';
import 'package:e_commerce_application/utils/constants/image_strings.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategoriesSCreen extends StatelessWidget {
  final CategoryModel category;
  const SubCategoriesSCreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(category.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Banner
              const TRoundedImage(
                imageURL: TImages.promoBanner1,
                width: double.infinity,
                applyImageRadius: true,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              // SubCategories
              FutureBuilder(
                future: controller.getSubCategory(category.id),
                builder: (context, snapshot) {
                  const loader = THorizontalProductShimmer();

                  final widget = TCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                    loader: loader,
                  );

                  if (widget != null) return widget;

                  final subcategories = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: subcategories.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      final subCategory = subcategories[index];

                      return FutureBuilder(
                          future: controller.getCategoryProducts(
                              categoryId: subCategory.id),
                          builder: (context, snapshot) {
                            final notingFound = Column(
                              children: [
                                TSectionHeading(
                                  title: subCategory.name,
                                  showActionButton: true,
                                  onPressed: () => Get.to(
                                    () => AllProducts(
                                      title: subCategory.name,
                                      futureMethod:
                                          controller.getCategoryProducts(
                                        categoryId: subCategory.id,
                                        limit: -1,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                    height: TSizes.spaceBtwItems / 2),
                              ],
                            );
                            final widget =
                                TCloudHelperFunctions.checkMultiRecordState(
                                    snapshot: snapshot,
                                    loader: loader,
                                    nothingFound: notingFound);

                            if (widget != null) return widget;

                            final products = snapshot.data!;

                            return Column(
                              children: [
                                // section heading
                                TSectionHeading(
                                  title: subCategory.name,
                                  showActionButton: true,
                                  onPressed: () => Get.to(
                                    () => AllProducts(
                                      title: subCategory.name,
                                      futureMethod:
                                          controller.getCategoryProducts(
                                        categoryId: subCategory.id,
                                        limit: -1,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                    height: TSizes.spaceBtwItems / 2),
                                SizedBox(
                                  height: 120,
                                  child: ListView.separated(
                                    itemCount: products.length,
                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder: (_, __) => const SizedBox(
                                        width: TSizes.spaceBtwItems),
                                    itemBuilder: (_, index) =>
                                        THorizontalProductCard(
                                      product: products[index],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: TSizes.spaceBtwSections),
                              ],
                            );
                          });
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
