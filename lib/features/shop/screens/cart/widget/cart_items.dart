import 'package:e_commerce_application/common/widgets/products/cart/add_and_remove_button_with_count.dart';
import 'package:e_commerce_application/common/widgets/products/cart/cart_item.dart';
import 'package:e_commerce_application/common/widgets/texts/product_price_text.dart';
import 'package:e_commerce_application/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TCartItems extends StatelessWidget {
  final bool showAddRemoveButton;
  const TCartItems({
    super.key,
    this.showAddRemoveButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Obx(() {
      return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (_, index) => Obx(() {
          final item = controller.cartItems[index];
          return Column(
            children: [
              TCardItem(
                cartItemModel: item,
              ),
              if (showAddRemoveButton)
                const SizedBox(height: TSizes.spaceBtwItems),
              if (showAddRemoveButton)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 70),
                        TProductQuantityWithRemoveButton(
                          quantity: item.quantity,
                          add: () => controller.addOneToCart(item),
                          remove: () => controller.removeOneFromCart(item),
                        ),
                      ],
                    ),
                    TProductPriceText(
                      price: (item.quantity * item.price).toStringAsFixed(1),
                    ),
                  ],
                )
            ],
          );
        }),
        separatorBuilder: (_, __) =>
            const SizedBox(height: TSizes.spaceBtwItems),
        itemCount: controller.cartItems.length,
      );
    });
  }
}
