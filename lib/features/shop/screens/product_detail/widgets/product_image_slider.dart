import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/common/widgets/custom_shape/curved_edges/curved_edges_widget.dart';
import 'package:e_commerce_application/common/widgets/images/t_rounded_image.dart';
import 'package:e_commerce_application/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:e_commerce_application/features/shop/controllers/product/image_slider_cotroller.dart';
import 'package:e_commerce_application/features/shop/models/products/product_model.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TProductImageSlider extends StatelessWidget {
  final ProductModel product;
  const TProductImageSlider({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ImageSliderController());
    final images = controller.getAllProductImages(product);
    return CurvedEdgesWidget(
      child: Container(
        color: isDark ? TColors.darkGrey : TColors.light,
        child: Stack(
          children: [
            /// Larged Image
            Container(
              padding: const EdgeInsets.all(TSizes.productImageRadius * 2),
              height: 400,
              child: Center(
                child: Obx(() {
                  final image = controller.selectedProductImage.value;
                  return GestureDetector(
                    onTap: () => controller.showEnlargedImage(image),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      progressIndicatorBuilder: (_, __, downloadProgress) =>
                          CircularProgressIndicator(
                        value: downloadProgress.progress,
                        color: TColors.primary,
                      ),
                    ),
                  );
                }),
              ),
            ),

            /// Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  itemCount: images.length,
                  itemBuilder: (_, index) => Obx(() {
                    final selectedImage =
                        controller.selectedProductImage.value == images[index];
                    return TRoundedImage(
                      width: 80,
                      isNetworkImage: true,
                      imageURL: images[index],
                      backgroundColor: isDark ? TColors.dark : TColors.white,
                      border: selectedImage
                          ? Border.all(color: TColors.primary, width: 2)
                          : Border.all(color: Colors.transparent, width: 2),
                      padding: const EdgeInsets.all(TSizes.sm),
                      onTap: () => controller.selectedProductImage.value = images[index],
                    );
                  }),
                ),
              ),
            ),

            /// Appbar
            TAppBar(
              showBackArrow: true,
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const TFavouriteIcons()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
