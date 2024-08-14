import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/common/widgets/loader/animation_loader.dart';
import 'package:e_commerce_application/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commerce_application/features/shop/screens/cart/widget/cart_items.dart';
import 'package:e_commerce_application/features/shop/screens/checkout/checkout.dart';
import 'package:e_commerce_application/navigation_menu.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../utils/constants/image_strings.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Obx(() {
        final emptyWidget = TAnimationLoaderWidget(
          text: "Whoops! Cart is Empty.",
          animation: TImages.cartAnimation,
          showAction: true,
          actionText: 'Let\'s fill it',
          onActionPressed: () => Get.off(()=> const NavigationMenu()),
        );
        if(controller.cartItems.isEmpty) {
          return Expanded(child: emptyWidget,);
        } else {
          return const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: TCartItems(),
            ),
          );
        }
      }),
      bottomNavigationBar: Obx(() {
        return  controller.cartItems.isEmpty ? const SizedBox(height: 0,width: 0,) :  Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: ElevatedButton(
            onPressed: () => Get.to(() => const CheckoutScreen()),
            child: Text('Checkout \u{20B9}${controller.totalCartPrice.value}'),
          ),
        );
      }),
    );
  }
}
