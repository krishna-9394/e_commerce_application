import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_application/common/widgets/custom_shape/container/circular_container.dart';
import 'package:e_commerce_application/common/widgets/images/t_rounded_image.dart';
import 'package:e_commerce_application/features/shop/controllers/home_controller.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TPromoSlider extends StatelessWidget {
  final List<String> banner;
  const TPromoSlider({
    super.key,
    required this.banner,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        CarouselSlider(
          items: banner
              .map(
                (imageURL) => TRoundedImage(
                  imageURL: imageURL,
                ),
              )
              .toList(),
          options: CarouselOptions(
            viewportFraction: 1,
            onPageChanged: (index, _) => controller.updatePageIndicator(index),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < banner.length; i++)
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
        )
      ],
    );
  }
}
