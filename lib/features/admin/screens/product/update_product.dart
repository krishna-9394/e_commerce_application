import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/features/admin/controllers/category_controller_admin.dart';
import 'package:e_commerce_application/features/personalization/controllers/update_username_controller.dart';
import 'package:e_commerce_application/utils/constants/image_strings.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/constants/text_strings.dart';
import 'package:e_commerce_application/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/images/circular_image.dart';
import '../../../../common/widgets/shimmer/shimmer_effect.dart';
import '../../controllers/brand_controller_admin.dart';
import '../../controllers/product_controller_admin.dart';

class ProductUpdateScreen extends StatelessWidget {
  const ProductUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductControllerAdmin());
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: false,
        title: Text('Update Category',
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Center(),
      // Obx(() {
      //   if (controller.brandList.isEmpty)
      //     controller.fetchBrandListAndLoadBrands();
      //   return SingleChildScrollView(
      //     scrollDirection: Axis.vertical,
      //     child: Padding(
      //       padding: const EdgeInsets.all(TSizes.defaultSpace),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           // Heading
      //           SizedBox(
      //             width: double.infinity,
      //             child: Column(
      //               children: [
      //                 Obx(
      //                       () {
      //                     final networkImage = controller.imageUrl.value;
      //                     final image = networkImage.isNotEmpty
      //                         ? networkImage
      //                         : TImages.defaultCategoryIcon;
      //
      //                     return controller.imageUploading.value
      //                         ? const TShimmerEffect(
      //                       width: 80,
      //                       height: 80,
      //                       radius: 80,
      //                     )
      //                         : TCircularImage(
      //                       image: image,
      //                       height: 80,
      //                       width: 80,
      //                       isNetworkImage: networkImage.isNotEmpty,
      //                     );
      //                   },
      //                 ),
      //                 TextButton(
      //                   onPressed: () => controller.uploadBrandImage(),
      //                   child: const Text('Update the Brand logo'),
      //                 ),
      //               ],
      //             ),
      //           ),
      //           const SizedBox(height: TSizes.spaceBtwSections),
      //           // TextField and Button
      //           Form(
      //             key: controller.formKey,
      //             child: Obx(
      //                   () => Column(
      //                 children: [
      //                   // Select the category to load
      //                   DropdownButtonFormField<String>(
      //                     value: controller.selectedBrandId.value.isEmpty
      //                         ? null
      //                         : controller.selectedBrandId.value,
      //                     items: controller.brandList.map((entry) {
      //                       return DropdownMenuItem<String>(
      //                         value: entry.key,
      //                         child: Text(entry.value),
      //                       );
      //                     }).toList(),
      //                     onChanged: (newValue) {
      //                       controller.selectedBrandId.value = newValue ?? "";
      //                       controller.displaySelectedBrand(
      //                           controller.selectedBrandId.value);
      //                     },
      //                     decoration: const InputDecoration(
      //                       labelText: 'Select Brand',
      //                       prefixIcon: Icon(Iconsax.category),
      //                     ),
      //                     validator: (value) =>
      //                     value == null ? 'Please select a Brand' : null,
      //                   ),
      //                   const SizedBox(height: TSizes.spaceBtwInputFields),
      //                   // category name
      //                   TextFormField(
      //                     controller: controller.brandName,
      //                     validator: (value) => TValidator.validateEmptyString(
      //                         'Brand Name', value),
      //                     expands: false,
      //                     decoration: const InputDecoration(
      //                       labelText: TTexts.brandName,
      //                       prefixIcon: Icon(Iconsax.user),
      //                     ),
      //                   ),
      //                   const SizedBox(height: TSizes.spaceBtwInputFields),
      //                   Padding(
      //                     padding: const EdgeInsets.all(16.0),
      //                     child: Column(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         const Text(
      //                           'Select Category',
      //                           style: TextStyle(
      //                               fontSize: 16, fontWeight: FontWeight.bold),
      //                         ),
      //                         const SizedBox(height: 10),
      //                         Obx(
      //                               () => Wrap(
      //                             spacing: 8.0,
      //                             runSpacing: 4.0,
      //                             children:
      //                             controller.categoryList.map((entry) {
      //                               return ChoiceChip(
      //                                 label: Text(entry.value),
      //                                 selected: controller.selectedCategory
      //                                     .contains(entry.key),
      //                                 onSelected: (bool selected) {
      //                                   if (selected) {
      //                                     controller.selectedCategory
      //                                         .add(entry.key);
      //                                   } else {
      //                                     controller.selectedCategory
      //                                         .remove(entry.key);
      //                                   }
      //                                   controller.selectedCategory.refresh();
      //                                 },
      //                                 selectedColor: Colors.blue,
      //                                 labelStyle: TextStyle(
      //                                   color: controller.selectedCategory
      //                                       .contains(entry.key)
      //                                       ? Colors.white
      //                                       : Colors.black,
      //                                 ),
      //                                 backgroundColor: Colors.grey[300],
      //                               );
      //                             }).toList(),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                   const SizedBox(height: TSizes.spaceBtwInputFields),
      //                   // checkbox for isFeatured
      //                   InputDecorator(
      //                     decoration: const InputDecoration(
      //                       border:
      //                       OutlineInputBorder(), // Border similar to TextFormField
      //                       contentPadding: EdgeInsets.all(12.0),
      //                     ),
      //                     child: Row(
      //                       children: [
      //                         Obx(
      //                               () => Checkbox(
      //                             value: controller.isFeatured.value,
      //                             onChanged: (value) =>
      //                                 controller.updateIsFeatured(),
      //                           ),
      //                         ),
      //                         const Text(TTexts.isFeatured),
      //                       ],
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //           const SizedBox(height: TSizes.spaceBtwSections),
      //           // Save Button
      //           SizedBox(
      //             width: double.infinity,
      //             child: ElevatedButton(
      //               onPressed: () => controller.updateBrandModel(),
      //               child: const Text('Update'),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   );
      // }),
    );
  }
}
