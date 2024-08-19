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
import '../../../../common/widgets/shimmer/shimmer_efftect.dart';

class CategoryUpdateScreen extends StatelessWidget {
  const CategoryUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryControllerAdmin());
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: false,
        title: Text('Update Category',
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Obx(() {
        if(controller.parentCategoryMap.isEmpty) controller.fetchCategoryModelsListAndLoadCategory();
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Heading
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Obx(
                        () {
                          final networkImage = controller.imageUrl.value;
                          final image = networkImage.isNotEmpty
                              ? networkImage
                              : TImages.defaultCategoryIcon;

                          return controller.imageUploading.value
                              ? const TShimmerEfftect(
                                  width: 80,
                                  height: 80,
                                  radius: 80,
                                )
                              : TCircularImage(
                                  image: image,
                                  height: 80,
                                  width: 80,
                                  isNetworkImage: networkImage.isNotEmpty,
                                );
                        },
                      ),
                      TextButton(
                        onPressed: () => controller.uploadCategoryImage(),
                        child: const Text('Set the Category Picture'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                // TextField and Button
                Form(
                  key: controller.formKey,
                  child: Obx(
                    () => Column(
                      children: [
                        // Select the category to load
                        DropdownButtonFormField<String>(
                          value: controller.selectedCategoryId.value.isEmpty
                              ? null
                              : controller.selectedCategoryId.value,
                          items: controller.categoryMap.entries.map((entry) {
                            return DropdownMenuItem<String>(
                              value: entry.key,
                              child: Text(entry.value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            controller.selectedCategoryId.value = newValue ?? "";
                            controller.displayTheSelectedCategory(
                                controller.selectedCategoryId.value);
                          },
                          decoration: const InputDecoration(
                            labelText: 'Select Category',
                            prefixIcon: Icon(Iconsax.category),
                          ),
                          validator: (value) =>
                              value == null ? 'Please select a category' : null,
                        ),
                        const SizedBox(height: TSizes.spaceBtwInputFields),
                        // category name
                        TextFormField(
                          controller: controller.categoryName,
                          validator: (value) => TValidator.validateEmptyString(
                              'Category Name', value),
                          expands: false,
                          decoration: const InputDecoration(
                            labelText: TTexts.categoryName,
                            prefixIcon: Icon(Iconsax.user),
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwInputFields),
                        // select the parentId
                        DropdownButtonFormField<String>(
                          value: controller.selectedParentId.value.isEmpty
                              ? ''
                              : controller.selectedParentId.value,
                          items: [
                            const DropdownMenuItem<String>(
                              value: '', // Representing the "None" option
                              child: Text('None'),
                            ),
                            ...controller.parentCategoryMap.entries.map((entry) {
                              return DropdownMenuItem<String>(
                                value: entry.key, // The key should be the value here
                                child: Text(entry.value), // Display the value from the map
                              );
                            }),
                          ],
                          onChanged: (newValue) {
                            controller.selectedParentId.value = newValue ?? "";
                          },
                          decoration: const InputDecoration(
                            labelText: 'Select Parent Category',
                            prefixIcon: Icon(Iconsax.category),
                          ),
                          validator: (value) =>
                          value == null ? 'Please select a category' : null,
                        ),
                        const SizedBox(height: TSizes.spaceBtwInputFields),
                        // checkbox for isFeatured
                        InputDecorator(
                          decoration: const InputDecoration(
                            border:
                                OutlineInputBorder(), // Border similar to TextFormField
                            contentPadding: EdgeInsets.all(12.0),
                          ),
                          child: Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                  value: controller.isFeatured.value,
                                  onChanged: (value) =>
                                      controller.updateIsFeatured(),
                                ),
                              ),
                              const Text(TTexts.isFeatured),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.updateCategory(),
                    child: const Text('Update'),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
