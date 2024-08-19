import 'package:e_commerce_application/features/admin/screens/upload_screen.dart';
import 'package:e_commerce_application/utils/constants/image_strings.dart';
import 'package:e_commerce_application/utils/helpers/network_manager.dart';
import 'package:e_commerce_application/utils/popups/full_screen_loaders.dart';
import 'package:e_commerce_application/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/repositories/uploads/category_upload_repository.dart';
import '../../../utils/constants/sizes.dart';
import '../../shop/models/category_model.dart';

class BrandControllerAdmin extends GetxController {
  static BrandControllerAdmin get instance => Get.find();

  final uploadsRepository = Get.put(BrandControllerAdmin());
  final categoryName = TextEditingController();

  final isFeatured = false.obs;
  final imageUploading = false.obs;
  final imageUrl = "".obs;
  final parentCategoryMap = <String, String>{}.obs;
  final categoryMap = <String, String>{}.obs;
  final selectedParentId = "".obs;
  final selectedCategoryId = "".obs;
  final loadingData = false.obs;
  Rx<CategoryModel> category = CategoryModel.empty().obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeData();
    loadParentCategoryList();
    super.onInit();
  }

  void initializeData() async {
    categoryName.text = "";
    isFeatured.value = false;
    imageUploading.value = false;
    imageUrl.value = "";
    selectedParentId.value = "";
    parentCategoryMap.clear();
    categoryMap.clear();
    category.value = CategoryModel.empty();
  }

  void updateIsFeatured() {
    isFeatured.value = !isFeatured.value;
  }

  Future<void> loadParentCategoryList() async {
    try {
      final list = await uploadsRepository.fetchCategoryList();
      list.forEach((key, value) {
        parentCategoryMap[key] = value;
      });
    } catch(e) {
      TLoaders.errorSnackBar(title: 'Oh snap!', message: "Error in loading categories list.");
      parentCategoryMap.clear();
    }
  }

  void addCategory() async {
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

      if(imageUrl.value.isEmpty) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Update user's first and last name in firebase firestore
      category.value.id = "";
      category.value.name = categoryName.text;
      category.value.isFeatured = isFeatured.value;
      category.value.parentId = selectedParentId.value;
      await uploadsRepository.uploadCategoryData(category.value);

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

  Future<void> uploadCategoryImage() async {
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
        await uploadsRepository.uploadImage('categories/', image);
        // update user Image Record
        category.value.image = imageUrl.value;
        category.refresh();
      }
      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Category image has been uploaded!.',
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
      final list = await uploadsRepository.fetchCategoryList();
      list.forEach((key, value) {
        categoryMap[key] = value;
      });
    } catch(e) {
      TLoaders.errorSnackBar(title: 'Oh snap!', message: "Error in loading categories list.");
      categoryMap.clear();
    }
  }

  // for updating the category
  void fetchCategoryModelsListAndLoadCategory() async {
    loadingData.value = !loadingData.value;
    await loadCategoryList();
    await loadParentCategoryList();
    var sortedEntries = categoryMap.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    await displayTheSelectedCategory(sortedEntries.first.key);
    loadingData.value = !loadingData.value;
  }

  // for updating the category
  Future<void> displayTheSelectedCategory(String key) async {
    try {
      CategoryModel categoryModel = await uploadsRepository.getCategoryDetails(key);
      categoryName.text = categoryModel.name;
      isFeatured.value = categoryModel.isFeatured;
      imageUrl.value = categoryModel.image;
      selectedCategoryId.value = categoryModel.id;
      selectedParentId.value = categoryModel.parentId;
      category.value = categoryModel;
    } catch(e) {
      TLoaders.errorSnackBar(title: 'Oh snap!', message: "Error in loading category detail.");
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

      if(imageUrl.value.isEmpty) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Update user's first and last name in firebase firestore
      category.value.id = selectedCategoryId.value;
      category.value.name = categoryName.text;
      category.value.isFeatured = isFeatured.value;
      category.value.parentId = selectedParentId.value;
      await uploadsRepository.updateCategoryData(category.value);

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
      if (!formKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      CategoryModel category = await uploadsRepository.getCategoryDetails(selectedParentId.value);
      await uploadsRepository.deleteImage(category.image);
      await uploadsRepository.deleteCategoryData(selectedParentId.value);

      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Category details has been removed.',
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

}
