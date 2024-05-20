import 'package:e_commerce_application/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:e_commerce_application/common/widgets/shimmer/category_shimmer.dart';
import 'package:e_commerce_application/features/shop/controllers/product/category_controller.dart';
import 'package:e_commerce_application/features/shop/screens/sub_category/sub_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Obx(() {
      if (controller.isLoading.value) {
        return const TCategoryShimmer();
      }

      if (controller.featuredCategories.isEmpty) {
        return Center(
          child: Text(
            'No data Found!',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: Colors.white),
          ),
        );
      }
      return SizedBox(
        height: 80,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: controller.featuredCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final category = controller.featuredCategories[index];
            return TVerticalImageText(
              text: category.name,
              image: category.image,
              onTap: () => Get.to(() => const SubCategoriesSCreen()),
            );
          },
        ),
      );
    });
  }
}
