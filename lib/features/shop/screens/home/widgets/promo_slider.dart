import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_application/common/widgets/custom_shape/container/circular_container.dart';
import 'package:e_commerce_application/common/widgets/images/t_rounded_image.dart';
import 'package:e_commerce_application/common/widgets/shimmer/shimmer_efftect.dart';
import 'package:e_commerce_application/features/shop/controllers/banner_controller.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(
      () {
        if (controller.isLoading.value) {
          return const TShimmerEfftect(
            width: double.infinity,
            height: 190,
          );
        }

        if (controller.banners.isEmpty) {
          return const Center(
            child: Text('No Data Found!'),
          );
        }

        return Column(
          children: [
            CarouselSlider(
              items: controller.banners
                  .map(
                    (banner) => Container(
                      margin: const EdgeInsets.all(5),
                      child: TRoundedImage(
                        imageURL: banner.imageUrl,
                        isNetworkImage: true,
                        onTap: () => Get.toNamed(banner.targetScreen),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                viewportFraction: 1.0,
                onPageChanged: (index, _) =>
                    controller.updatePageIndicator(index),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < controller.banners.length; i++)
                  TCircularContainer(
                    height: 4,
                    width: 20,
                    margin: const EdgeInsets.only(right: 10),
                    color: controller.carouselCurrentIndex.value == i
                        ? Colors.green
                        : Colors.grey,
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
