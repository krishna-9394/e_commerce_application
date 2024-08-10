import 'package:e_commerce_application/common/widgets/icon/t_circular_icon.dart';
import 'package:e_commerce_application/features/shop/controllers/product/favourite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TFavouriteIcons extends StatelessWidget {
  final String productId;
  const TFavouriteIcons({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouriteController());
    return Obx(() => TCircularIcon(
      icon: controller.isFavourite(productId) ? Iconsax.heart5 : Iconsax.heart,
      color: Colors.red,
      onPressed: () => controller.toggleFavouriteIcon(productId),
    ));
  }
}
