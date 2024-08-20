import 'package:e_commerce_application/features/admin/screens/upload_screen.dart';
import 'package:e_commerce_application/features/shop/models/brand_category.dart';
import 'package:e_commerce_application/features/shop/models/brand_model.dart';
import 'package:e_commerce_application/utils/constants/image_strings.dart';
import 'package:e_commerce_application/utils/helpers/network_manager.dart';
import 'package:e_commerce_application/utils/popups/full_screen_loaders.dart';
import 'package:e_commerce_application/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/repositories/uploads/brand_upload_repository.dart';
import '../../../utils/constants/sizes.dart';

class BrandControllerAdmin extends GetxController {
  static BrandControllerAdmin get instance => Get.find();

  final uploadsRepository = Get.put(BrandUploadsRepository());
  final brandName = TextEditingController();

  final isFeatured = false.obs;
  final imageUploading = false.obs;
  final imageUrl = "".obs;
  final productCount = 0.obs;
  final loadingData = false.obs;
  final brandModel = BrandModel.empty().obs;
  final selectedBrandId = "".obs;
  final categoryList = <MapEntry<String, String>>[].obs;
  final brandList = <MapEntry<String, String>>[].obs;
  final brandCategoryList = <BrandCategoryModel>[].obs;
  final selectedCategory = <String>{}.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeData();
    loadCategoryList();
    super.onInit();
  }

  void initializeData() async {
    isFeatured.value = false;
    imageUploading.value = false;
    brandName.text = "";
    imageUrl.value = "";
    productCount.value = 0;
    selectedBrandId.value = "";
    categoryList.clear();
    brandList.clear();
    brandCategoryList.clear();
    selectedCategory.clear();
    brandModel.value = BrandModel.empty();
  }

  void updateIsFeatured() {
    isFeatured.value = !isFeatured.value;
  }

  void fetchBrandListAndLoadBrands() async {
    loadingData.value = !loadingData.value;
    await loadBrandModelList();
    var sortedEntries = brandList..sort((a, b) => a.key.compareTo(b.key));
    await displaySelectedBrand(sortedEntries.first.key);
    loadingData.value = !loadingData.value;
  }

  void addBrand() async {
    try {
      // start loading
      TFullScreenLoader.openLoadingDialog(
        'We are uploading brand information...',
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

      if(imageUrl.value.isEmpty) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Update user's first and last name in firebase firestore
      brandModel.value.id = "";
      brandModel.value.name = brandName.text;
      brandModel.value.isFeatured = isFeatured.value;
      brandModel.value.productsCount = 0;
      String id = await uploadsRepository.uploadBrandData(brandModel.value);
      for(String categoryId in selectedCategory) {
        BrandCategoryModel brandCategory = BrandCategoryModel(
          brandId: id,
          categoryId: categoryId,
        );
        await uploadsRepository.uploadBrandCategoryData(brandCategory);
      }
      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Brand details has been uploaded.',
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

  Future<void> uploadBrandImage() async {
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
        imageUrl.value =
        await uploadsRepository.uploadImage('brands/', image);
        // update user Image Record
        brandModel.value.image = imageUrl.value;
        brandModel.refresh();
      }
      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Brand logo has been uploaded!.',
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

  Future<void> loadCategoryList() async {
    try {
      categoryList.clear();
      final list = await uploadsRepository.fetchCategoryList();
      list.forEach((key, value) {
        categoryList.add(MapEntry(key, value));
      });
      categoryList;
      categoryList.refresh();
    } catch(e) {
      TLoaders.errorSnackBar(title: 'Oh snap!', message: "Error in loading categories list.");
      categoryList.clear();
    }
  }

  Future<void> loadBrandModelList() async {
    loadingData.value = !loadingData.value;
    brandList.clear();
    try {
      final list = await uploadsRepository.fetchBrandList();
      list.forEach((key, value) {
        brandList.add(MapEntry(key, value));
      });
    } catch(e) {
      TLoaders.errorSnackBar(title: 'Oh snap!', message: "Error in loading brands list.");
      categoryList.clear();
    }
    loadingData.value = !loadingData.value;
  }

  // for updating the brand
  Future<void> displaySelectedBrand(String id) async {
    try {
      BrandModel brand = await uploadsRepository.getBrandDetails(id);
      brandName.text = brand.name;
      isFeatured.value = brand.isFeatured ?? false;
      imageUrl.value = brand.image;
      brandModel.value = brand;
      selectedCategory.clear();
      productCount.value = brand.productsCount ?? 0;
      final list = await uploadsRepository.fetchBrandCategoryModelList(id);
      for (var element in list) {
        selectedCategory.add(element);
      }
      selectedCategory.refresh();
    } catch(e) {
      TLoaders.errorSnackBar(title: 'Oh snap!', message: "Error in loading brand detail.");
      categoryList.clear();
    }
  }

  // for updating the category
  void updateBrandModel() async {
    try {
      // start loading
      TFullScreenLoader.openLoadingDialog(
        'We are updating brand information...',
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

      if(imageUrl.value.isEmpty) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // TODO: when you replace the image it should delete the previous image but it is not deleting the previous image.
      // Update brand's details in firebase firestore
      brandModel.value.id = selectedBrandId.value;
      brandModel.value.name = brandName.text;
      brandModel.value.isFeatured = isFeatured.value;
      brandModel.value.productsCount = productCount.value;
      brandModel.value.image = imageUrl.value;
      // fetch the previous selected category list
      Set<String> set = <String>{};
      set.addAll(await uploadsRepository.fetchBrandCategoryModelList(selectedBrandId.value));
      // set difference
      final setKeysToBeRemoved = set.difference(selectedCategory);
      final setKeysToBeAdded = selectedCategory.difference(set);
      // removed the brandcategory which not selected.
      for(String id in setKeysToBeRemoved) {
        await uploadsRepository.deleteBrandCategoryModel(id);
      }
      // added the brandcategory which is selected.
      for(String id in setKeysToBeAdded) {
        await uploadsRepository.uploadBrandCategoryData(BrandCategoryModel(brandId: selectedBrandId.value, categoryId: id));
      }
      // update the brand details
      await uploadsRepository.updateBrandData(brandModel.value);

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

  void deleteBrand() async {
    try {
      // start loading
      TFullScreenLoader.openLoadingDialog(
        'We are removing brand information...',
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

      // fetched the imageUrl and deleted the image from the storage;
      final brand = await uploadsRepository.getBrandDetails(selectedBrandId.value);
      await uploadsRepository.deleteImage(brand.image);
      // delete the BrandCategoryModel one by one.
      final docList = await uploadsRepository.fetchBrandCategoryModelDocIdList(selectedBrandId.value);
      for(String id in docList) {
        await uploadsRepository.deleteBrandCategoryModel(id);
      }
      // delete the brand details
      await uploadsRepository.deleteBrandModelData(selectedBrandId.value);

      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Brand details has been removed.',
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

  // Delete account warning
  void deleteBrandWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Delete Brand',
      middleText:
      'Are you sure you want to delete brand permanently? This action is not reversible and all the data will be removed permanently.',
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
          child: const Text("Cancel"),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () async => deleteBrand(),
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

}
