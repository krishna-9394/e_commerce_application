import 'package:e_commerce_application/data/repositories/uploads/product_upload_repository.dart';
import 'package:e_commerce_application/features/admin/screens/upload_screen.dart';
import 'package:e_commerce_application/features/shop/models/products/product_model.dart';
import 'package:e_commerce_application/features/shop/models/products/product_variation_model.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/image_strings.dart';
import 'package:e_commerce_application/utils/device/device_utility.dart';
import 'package:e_commerce_application/utils/helpers/network_manager.dart';
import 'package:e_commerce_application/utils/popups/full_screen_loaders.dart';
import 'package:e_commerce_application/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/constants/dummy_data.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/validators/validation.dart';
import '../../shop/models/category_model.dart';
import '../../shop/models/products/product_attribute_model.dart';

class ProductControllerAdmin extends GetxController {
  static ProductControllerAdmin get instance => Get.find();

  final uploadsRepository = Get.put(ProductUploadsRepository());
  final productTitle = TextEditingController();
  final description = TextEditingController();
  final productName = TextEditingController();

  final isFeatured = false.obs;
  final imageUploading = false.obs;
  final thumbnailUrl = "".obs;
  final priceRange = "".obs;
  final stock = 0.obs;

  final selectedBrandId = "".obs;
  final selectedCategoryId = "".obs;
  final selectedProductType = ProductType.single.toString().obs;

  final productImagesUrl = <String>[].obs;
  final productAttributeModels = <ProductAttributeModel>[].obs;
  final productVariations = <ProductVariationModel>[].obs;

  final brandMap = <String, String>{}.obs;
  final categoryMap = <String, String>{}.obs;

  // product attribute stuff
  final productAttributeName = TextEditingController();
  final productAttributeValueCount = TextEditingController();
  final productAttributeModel = ProductAttributeModel.empty().obs;
  final productVariationModel = ProductVariationModel.empty().obs;
  RxList<TextEditingController> productAttributeValues = <TextEditingController>[].obs;

  GlobalKey<FormState> attributeFormKey = GlobalKey<FormState>();
  final productAttrValueCount = 0.obs;
  final productAttrName = "Option".obs;
  GlobalKey<FormState> variationFormKey = GlobalKey<FormState>();
  final productVariationValueCount = 0.obs;
  final productVariationName = "Option".obs;
  final loadingData = false.obs;
  Rx<ProductModel> product = ProductModel.empty().obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final productTypeMap = {
    'Single': ProductType.single,
    'Variable': ProductType.variable,
  };

  @override
  void onInit() {
    initializeData();
    loadCategoryList();
    super.onInit();
  }

  void initializeData() async {
    productTitle.text = "";
    productName.text = "";
    description.text = "";
    productAttributeValueCount.text = "0";

    isFeatured.value = false;
    imageUploading.value = false;
    thumbnailUrl.value = "";
    priceRange.value = "";
    stock.value = 0;

    selectedBrandId.value = "";
    selectedCategoryId.value = "";
    selectedProductType.value = ProductType.single.toString();

    productImagesUrl.clear();
    productAttributeModels.clear();
    productVariations.clear();

    brandMap.clear();
    categoryMap.clear();
  }

  void updateIsFeatured() {
    isFeatured.value = !isFeatured.value;
  }

  Future<void> loadBrandList(String id) async {
    try {
      brandMap.clear();
      final set =
          await uploadsRepository.fetchCategoryBrandListWithGivenCategoryId(id);
      final list =
          await uploadsRepository.fetchBrandListWithGivenBrandIdList(set);
      list.forEach((key, value) {
        brandMap[key] = value;
      });
      brandMap.refresh();
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Oh snap!', message: "Error in loading brand list.");
      brandMap.clear();
    }
  }

  Future<void> loadCategoryList() async {
    try {
      categoryMap.clear();
      final list = await uploadsRepository.fetchCategoryList();
      list.forEach((key, value) {
        categoryMap[key] = value;
      });
      categoryMap.refresh();
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Oh snap!', message: "Error in loading categories list.");
      categoryMap.clear();
    }
  }

  void addProduct() async {
    try {
      // start loading
      TFullScreenLoader.openLoadingDialog(
        'We are uploading category information...',
        TImages.docerAnimation,
      );

      // Checking connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // validating the form
      if (!formKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (thumbnailUrl.value.isEmpty) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Update user's first and last name in firebase firestore
      // category.value.id = "";
      // category.value.name = productTitle.text;
      // category.value.isFeatured = isFeatured.value;
      // category.value.parentId = selectedParentId.value;
      // await uploadsRepository.uploadCategoryData(category.value);

      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Category details has been uploaded.',
      );

      Get.offAll(() => const UploadScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(
        title: 'Oh snap!',
        message: e.toString(),
      );
    }
  }

  void addProductAttributeModel() async {
    try {
      // Checking connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // validating the form
      if (!attributeFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Update user's first and last name in firebase firestore
      productAttributeModel.value.name = productAttributeName.text;
      productAttributeModel.value.values = productAttributeValues.map((e) => e.text).toList();
      productAttributeModels.add(productAttributeModel.value);
      productAttributeModel.value = ProductAttributeModel.empty();
      productAttributeModel.refresh();

      Navigator.of(Get.overlayContext!).pop();

      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Category details has been uploaded.',
      );
    } catch (e) {
      Navigator.of(Get.overlayContext!).pop();

      TLoaders.errorSnackBar(
        title: 'Oh snap!',
        message: e.toString(),
      );
    }
  }

  Future<void> uploadProductThumbnail() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );
      // TODO: #1 make a image cropper to crop image
      if (image != null) {
        imageUploading.value = true;
        thumbnailUrl.value =
            await uploadsRepository.uploadImage('products/thumbnail/', image);
        // update user Image Record
        product.value.thumbnail = thumbnailUrl.value;
        product.refresh();
      }
      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Product thumbnail has been uploaded!.',
      );
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Oh Snap',
        message: 'Something went wrong: $e',
      );
    } finally {
      imageUploading.value = false;
    }
  }

  // for updating the category
  void fetchCategoryModelsListAndLoadCategory() async {
    loadingData.value = !loadingData.value;
    await loadCategoryList();
    // await loadParentCategoryList();
    var sortedEntries = categoryMap.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    await displayTheSelectedCategory(sortedEntries.first.key);
    loadingData.value = !loadingData.value;
  }

  // for updating the category
  Future<void> displayTheSelectedCategory(String key) async {
    try {
      // CategoryModel categoryModel = await uploadsRepository.getCategoryDetails(key);
      // productTitle.text = categoryModel.name;
      // isFeatured.value = categoryModel.isFeatured;
      // thumbnailUrl.value = categoryModel.image;
      // selectedCategoryId.value = categoryModel.id;
      // selectedParentId.value = categoryModel.parentId;
      // category.value = categoryModel;
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Oh snap!', message: "Error in loading category detail.");
      categoryMap.clear();
    }
  }

  // for updating the category
  void updateCategory() async {
    try {
      // start loading
      TFullScreenLoader.openLoadingDialog(
        'We are updating category information...',
        TImages.docerAnimation,
      );

      // Checking connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // validating the form
      if (!formKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // if(thumbnailUrl.value.isEmpty) {
      //   TFullScreenLoader.stopLoading();
      //   return;
      // }
      //
      // // Update user's first and last name in firebase firestore
      // category.value.id = selectedCategoryId.value;
      // category.value.name = productTitle.text;
      // category.value.isFeatured = isFeatured.value;
      // category.value.parentId = selectedParentId.value;
      // await uploadsRepository.updateCategoryData(category.value);

      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Category details has been updated.',
      );

      Get.offAll(() => const UploadScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(
        title: 'Oh snap!',
        message: e.toString(),
      );
    }
  }

  void deleteCategory() async {
    try {
      // start loading
      TFullScreenLoader.openLoadingDialog(
        'We are removing category information...',
        TImages.docerAnimation,
      );

      // Checking connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // validating the form
      // if (!formKey.currentState!.validate()) {
      //   TFullScreenLoader.stopLoading();
      //   return;
      // }
      //
      // CategoryModel category = await uploadsRepository.getCategoryDetails(selectedParentId.value);
      // await uploadsRepository.deleteImage(category.image);
      // await uploadsRepository.deleteCategoryData(selectedParentId.value);
      //
      // TFullScreenLoader.stopLoading();
      //
      // TLoaders.successSnackBar(
      //   title: 'Congratulations',
      //   message: 'Category details has been removed.',
      // );

      Get.offAll(() => const UploadScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(
        title: 'Oh snap!',
        message: e.toString(),
      );
    }
  }

  // Delete account warning
  void deleteCategoryWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Delete Category',
      middleText:
          'Are you sure you want to delete category permanently? This action is not reversible and all the data will be removed permanently.',
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
          child: const Text("Cancel"),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () async => deleteCategory(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            side: const BorderSide(color: Colors.red),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
            child: Text('Delete'),
          ),
        ),
      ],
    );
  }

  // Adding Product Attribute
  void addProductVariationPopup() async {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Add Product Attribute',
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: TDeviceUtils.getScreenHeight() * 0.36,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: attributeFormKey,
                child: Column(
                  children: [
                    const SizedBox(height: TSizes.spaceBtwItems/4),
                    TextFormField(
                      controller: productAttributeName,
                      keyboardType: TextInputType.name,
                      validator: (value) => TValidator.validateEmptyString(
                          'Attribute Name', value),
                      decoration: const InputDecoration(
                        labelText: TTexts.productAttributeName,
                        prefixIcon: Icon(Iconsax.user),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) productAttrName.value = value;

                      },
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    TextFormField(
                      controller: productAttributeValueCount,
                      keyboardType: TextInputType.number,
                      validator: (value) => TValidator.validateEmptyString(
                          'Attribute Count', value),
                      decoration: const InputDecoration(
                        labelText: TTexts.productAttributeValueCount,
                        prefixIcon: Icon(Iconsax.user),
                      ),
                      onChanged: (value) {
                        productAttrValueCount.value = int.parse(value);
                        for(int i = 0; i < productAttrValueCount.value; i++) {
                          productAttributeValues.add(TextEditingController());
                        }
                        productAttributeValues.refresh();
                        productAttributeModel.refresh();
                      },
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Obx(() {
                      if (productAttrValueCount.value != 0) {
                        return Column(
                          children: List.generate(
                            productAttrValueCount.value,
                            (index) => Column(
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.name,
                                  validator: (value) =>
                                      TValidator.validateEmptyString(
                                          'Option', value),
                                  onChanged: (value) {
                                    productAttributeModel.value.values![index] = value;
                                    productAttributeModel.refresh();
                                  },
                                  decoration: InputDecoration(
                                    labelText: '${productAttrName.value} ${index + 1}',
                                    prefixIcon: const Icon(Iconsax.user),
                                  ),
                                ),
                                const SizedBox(height: TSizes.spaceBtwItems),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox(height: TSizes.spaceBtwSections);
                      }
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
          child: const Text("Cancel", style: TextStyle(color: Colors.red)),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () async => addProductAttributeModel(),
          style: ElevatedButton.styleFrom(
            backgroundColor: TColors.primary,
            side: const BorderSide(color: TColors.primary),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
            child: Text('Save'),
          ),
        ),
      ],
    );
  }

  // Adding Product Attribute
  void addProductAttributePopup() async {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Add Product Variations',
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: TDeviceUtils.getScreenHeight() * 0.36,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: attributeFormKey,
                child: Column(
                  children: [
                    const SizedBox(height: TSizes.spaceBtwItems/4),
                    TextFormField(
                      controller: productAttributeName,
                      keyboardType: TextInputType.name,
                      validator: (value) => TValidator.validateEmptyString(
                          'Attribute Name', value),
                      decoration: const InputDecoration(
                        labelText: TTexts.productAttributeName,
                        prefixIcon: Icon(Iconsax.user),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) productAttrName.value = value;
                      },
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    TextFormField(
                      controller: productAttributeValueCount,
                      keyboardType: TextInputType.number,
                      validator: (value) => TValidator.validateEmptyString(
                          'Attribute Count', value),
                      decoration: const InputDecoration(
                        labelText: TTexts.productAttributeValueCount,
                        prefixIcon: Icon(Iconsax.user),
                      ),
                      onChanged: (value) {
                        productAttrValueCount.value = int.parse(value);
                        for(int i = 0; i < productAttrValueCount.value; i++) {
                          var textEditingController = TextEditingController();
                          textEditingController.text = '';
                          productAttributeValues.add(textEditingController);
                        }
                        productAttributeValues.refresh();
                        productAttributeModel.refresh();
                      },
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Obx(() {
                      if (productAttrValueCount.value != 0) {
                        return Column(
                          children: List.generate(
                            productAttrValueCount.value,
                            (index) => Column(
                              children: [
                                TextFormField(
                                  controller: productAttributeValues[index],
                                  keyboardType: TextInputType.name,
                                  validator: (value) =>
                                      TValidator.validateEmptyString(
                                          'Option', value),
                                  decoration: InputDecoration(
                                    labelText: '${productAttrName.value} ${index + 1}',
                                    prefixIcon: const Icon(Iconsax.user),
                                  ),
                                ),
                                const SizedBox(height: TSizes.spaceBtwItems),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox(height: TSizes.spaceBtwSections);
                      }
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
          child: const Text("Cancel", style: TextStyle(color: Colors.red)),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () async => addProductAttributeModel(),
          style: ElevatedButton.styleFrom(
            backgroundColor: TColors.primary,
            side: const BorderSide(color: TColors.primary),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
            child: Text('Save'),
          ),
        ),
      ],
    );
  }
}
