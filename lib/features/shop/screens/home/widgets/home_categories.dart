import 'package:e_commerce_application/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:e_commerce_application/features/shop/screens/sub_category/sub_category.dart';
import 'package:e_commerce_application/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 9,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return TVerticalImageText(
            text: 'Shoes Catergory',
            image: TImages.shoeIcon,
            onTap: () => Get.to(() => const SubCategoriesSCreen()),
          );
        },
      ),
    );
  }
}
