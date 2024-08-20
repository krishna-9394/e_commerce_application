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

class CategoryDeleteScreen extends StatelessWidget {
  const CategoryDeleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryControllerAdmin());
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Delete Category',
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TextField and Button
              Form(
                key: controller.formKey,
                child: Obx(
                  () => Column(
                    children: [
                      // Select the category to load
                      DropdownButtonFormField<String>(
                        value: controller.selectedParentId.value.isEmpty
                            ? null
                            : controller.selectedParentId.value,
                        items:
                            controller.parentCategoryMap.entries.map((entry) {
                          return DropdownMenuItem<String>(
                            value: entry.key,
                            child: Text(entry.value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          controller.selectedParentId.value = newValue ?? "";
                        },
                        decoration: const InputDecoration(
                          labelText: 'Select Category',
                          prefixIcon: Icon(Iconsax.category),
                        ),
                        validator: (value) =>
                            value == null ? 'Please select a category' : null,
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
                  onPressed: () => controller.deleteCategoryWarningPopup(),
                  child: const Text('Delete'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
