import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/features/admin/controllers/brand_controller_admin.dart';
import 'package:e_commerce_application/features/admin/controllers/product_controller_admin.dart';
import 'package:e_commerce_application/utils/constants/image_strings.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/constants/text_strings.dart';
import 'package:e_commerce_application/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/images/circular_image.dart';
import '../../../../common/widgets/shimmer/shimmer_effect.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../personalization/screens/profile/widget/profile_menu.dart';

class ProductAdditionScreen extends StatelessWidget {
  const ProductAdditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductControllerAdmin());
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Add Product',
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
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
                        final networkImage = controller.thumbnailUrl.value;
                        final image = networkImage.isNotEmpty
                            ? networkImage
                            : TImages.defaultCategoryIcon;

                        return controller.imageUploading.value
                            ? const TShimmerEffect(
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
                      onPressed: () => controller.uploadProductThumbnail(),
                      child: const Text('Set the Product Thumbnail'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              // TextField and Button
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    // Product Title
                    TextFormField(
                      controller: controller.productTitle,
                      validator: (value) => TValidator.validateEmptyString(
                          'Product Title', value),
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: TTexts.productTitle,
                        prefixIcon: Icon(Iconsax.user),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    // Product Name
                    TextFormField(
                      controller: controller.productName,
                      validator: (value) =>
                          TValidator.validateEmptyString('Product Name', value),
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: TTexts.productName,
                        prefixIcon: Icon(Iconsax.user),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    // is Featured
                    InputDecorator(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
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
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    // Product Type
                    Obx(() => DropdownButtonFormField<String>(
                          value: controller.selectedProductType.value.isEmpty
                              ? null
                              : controller.selectedProductType.value,
                          items: controller.productTypeMap.entries.map((entry) {
                            return DropdownMenuItem<String>(
                              value: entry.value.toString(),
                              child: Text(entry.key),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            controller.selectedProductType.value =
                                newValue ?? "";
                          },
                          decoration: const InputDecoration(
                            labelText: 'Select Product Type',
                            prefixIcon: Icon(Iconsax.category),
                          ),
                          validator: (value) => value == null
                              ? 'Please select a Product Type'
                              : null,
                        )),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    // Product Description
                    TextFormField(
                      controller: controller.description,
                      validator: (value) =>
                          TValidator.validateEmptyString('Description', value),
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: TTexts.productDescription,
                        prefixIcon: Icon(Iconsax.user),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    // dropdown list for category
                    Obx(() => DropdownButtonFormField<String>(
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
                            controller.selectedCategoryId.value =
                                newValue ?? "";
                            if (controller
                                .selectedCategoryId.value.isNotEmpty) {
                              controller.loadBrandList(
                                  controller.selectedCategoryId.value);
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'Select Category',
                            prefixIcon: Icon(Iconsax.category),
                          ),
                          validator: (value) =>
                              value == null ? 'Please select a category' : null,
                        )),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    // dropdown list for brand
                    Obx(() => DropdownButtonFormField<String>(
                          value: controller.selectedBrandId.value.isEmpty
                              ? null
                              : controller.selectedBrandId.value,
                          items: controller.brandMap.entries.map((entry) {
                            return DropdownMenuItem<String>(
                              value: entry.key,
                              child: Text(entry.value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            controller.selectedBrandId.value = newValue ?? "";
                          },
                          decoration: const InputDecoration(
                            labelText: 'Select Brand',
                            prefixIcon: Icon(Iconsax.category),
                          ),
                          validator: (value) =>
                              value == null ? 'Please select a Brand' : null,
                        )),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    // Product Attributes defining.
                    InputDecorator(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(12.0),
                      ),
                      child: Column(
                        children: [
                          TSectionHeading(
                            title: 'Product Attributes',
                            showActionButton: true,
                            buttonTitle: 'Add',
                            onPressed: () =>
                                controller.addProductAttributePopup(),
                          ),
                          const SizedBox(height: TSizes.spaceBtwItems),
                          Obx(() => Column(
                            children: List.generate(
                              controller.productAttributeModels.length,
                                  (index) => TProfileMenu(
                                    isActionButtonRequired: false,
                                question: controller
                                    .productAttributeModels[index].getName(),
                                answer: controller.productAttributeModels[index]
                                    .getValues(),
                                onPressed: () {},
                              ),
                            ).toList(),
                          ),),
                        ],
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    // Product Variation
                    InputDecorator(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(12.0),
                      ),
                      child: Column(
                        children: [
                          TSectionHeading(
                            title: 'Product Variations',
                            showActionButton: true,
                            buttonTitle: 'Add',
                            onPressed: () =>
                                controller.addProductAttributePopup(),
                          ),
                          const SizedBox(height: TSizes.spaceBtwItems),
                          Obx(() => Column(
                            children: List.generate(
                              controller.productAttributeModels.length,
                                  (index) => TProfileMenu(
                                isActionButtonRequired: false,
                                question: controller
                                    .productAttributeModels[index].getName(),
                                answer: controller.productAttributeModels[index]
                                    .getValues(),
                                onPressed: () {},
                              ),
                            ).toList(),
                          ),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.addProduct(),
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
