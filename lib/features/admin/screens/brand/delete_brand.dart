import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/features/admin/controllers/brand_controller_admin.dart';
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

class BrandDeleteScreen extends StatelessWidget {
  const BrandDeleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandControllerAdmin());
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Delete Brand',
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Obx(() {
          if(controller.brandList.isEmpty) controller.loadBrandModelList();
          return Padding(
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
                        // Select the Brands to load
                        DropdownButtonFormField<String>(
                          value: controller.selectedBrandId.value.isEmpty
                              ? null
                              : controller.selectedBrandId.value,
                          items:
                          controller.brandList.map((entry) {
                            return DropdownMenuItem<String>(
                              value: entry.key,
                              child: Text(entry.value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            controller.selectedBrandId.value = newValue ?? "";
                          },
                          decoration: const InputDecoration(
                            labelText: 'Select a Brand',
                            prefixIcon: Icon(Iconsax.category),
                          ),
                          validator: (value) =>
                          value == null ? 'Please select a Brand' : null,
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
                    onPressed: () => controller.deleteBrandWarningPopup(),
                    child: const Text('Delete'),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
