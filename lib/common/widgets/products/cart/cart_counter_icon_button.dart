import 'package:e_commerce_application/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commerce_application/features/shop/screens/cart/cart.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TCartCounterIconButton extends StatelessWidget {
  final Color? iconColor, counterBackgroundColor, counterTextColor;
  const TCartCounterIconButton({
    super.key,
    this.iconColor,
    this.counterBackgroundColor,
    this.counterTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    final dark = THelperFunctions.isDarkMode(context);

    return Stack(
      children: [
        IconButton(
          onPressed: () => Get.to(()=> const CartScreen()),
          icon: Icon(
            Iconsax.shopping_bag,
            color: iconColor,
          ),
        ),
        Positioned(
            right: 0,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: TColors.black,
              ),
              child: Center(
                  child: Obx(() => Text(
                        controller.noOfCartItems.value.toString(),
                        style: Theme.of(context).textTheme.labelLarge!.apply(
                              fontSizeFactor: 0.8,
                              color: counterTextColor ?? (dark? TColors.black : TColors.white),
                            ),
                      ))),
            ))
      ],
    );
  }
}
