import 'package:e_commerce_application/common/widgets/layout/grid_layout.dart';
import 'package:e_commerce_application/common/widgets/products/product_cards/vertical_product_card.dart';
import 'package:e_commerce_application/features/shop/controllers/product/all_product_controller.dart';
import 'package:e_commerce_application/features/shop/models/products/product_model.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key,
    required this.products,
  });
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    controller.assignProducts(products);
    return Column(
      children: [
        DropdownButtonFormField(
          items: [
            'Name',
            'Higher Price',
            'Lower Price',
            'Sale',
            'Newest',
            'Popularity'
          ]
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              )
              .toList(),
          decoration: const InputDecoration(
            prefix: Padding(
                padding: EdgeInsets.only(right: 10, left: 5),
                child: Icon(Iconsax.sort)),
          ),
          onChanged: (value) {
            // sort the products based on the options selected
            controller.sortProducts(value!);
          },
          value: controller.selectedSortOption.value,
        ),
        const SizedBox(height: TSizes.defaultSpace),
        Obx(() => TGridLayout(
              itemCount: controller.products.length,
              itemBuiler: (_, index) => TVerticalProductCard(
                product: controller.products[index],
              ),
            ))
      ],
    );
  }
}
