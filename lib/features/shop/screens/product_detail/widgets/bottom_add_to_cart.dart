import 'package:e_commerce_application/common/widgets/icon/t_circular_icon.dart';
import 'package:e_commerce_application/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../models/products/product_model.dart';

class TBottomAddToCart extends StatelessWidget {
  final ProductModel product;
  const TBottomAddToCart({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final controller = CartController.instance;
    controller.updateAlreadyAddedProductCount(product);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: TSizes.defaultSpace,
        vertical: TSizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: isDark ? TColors.darkGrey : TColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusLg),
          topRight: Radius.circular(TSizes.cardRadiusLg),
        ),
      ),
      child: Obx(() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TCircularIcon(
                icon: Iconsax.minus ,
                width: 40,
                height: 40,
                color: Colors.white,
                backgroundColor: isDark ? TColors.grey : TColors.darkGrey,
                onPressed: () => controller.productQuantityInCart.value < 1 ? null : controller.productQuantityInCart.value -= 1,
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              Text(controller.productQuantityInCart.value.toString(), style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(width: TSizes.spaceBtwItems),
              TCircularIcon(
                icon: Iconsax.add,
                width: 40,
                height: 40,
                color: Colors.white,
                backgroundColor: TColors.black,
                onPressed: () => controller.productQuantityInCart.value += 1,
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () => controller.productQuantityInCart.value < 1 ? null : controller.addToCart(product),
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: TColors.black,
                side: const BorderSide(color: Colors.black)
            ),
            child: const Text('Add to Cart'),
          ),
        ],
      )),
    );
  }
}
