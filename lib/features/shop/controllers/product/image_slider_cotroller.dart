import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_application/features/shop/models/products/product_model.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageSliderController extends GetxController {
  static ImageSliderController get instance => Get.find();

  // Rx Variable
  final selectedProductImage = ''.obs;

  // Get all images from products and Variations
  List<String> getAllProductImages(ProductModel product) {
    // Use set to add unique images only
    Set<String> images = {};

    // assign Thumbnail as Selected Image
    selectedProductImage.value = product.thumbnail;

    // Get all the images from Product model if not null
    if (product.images != null) {
      images.addAll(product.images!);
    } else {
      images.add(product.thumbnail);
    }

    // Get all images from the Product Variation if not null.
    if (product.productVariations != null ||
        product.productVariations!.isNotEmpty) {
      images.addAll(
          product.productVariations!.map((variation) => variation.image));
    }

    return images.toList();
  }

  /// -- Show Image Popup
  void showEnlargedImage(String image) {
    Get.to(
        fullscreenDialog: true,
        () => Dialog.fullscreen(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: TSizes.defaultSpace * 2,
                      horizontal: TSizes.defaultSpace,
                    ),
                    child: CachedNetworkImage(imageUrl: image),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 150,
                      child: OutlinedButton(
                          child: const Text('Close'),
                          onPressed: () => Get.back()),
                    ),
                  )
                ],
              ),
            ));
  }
}
