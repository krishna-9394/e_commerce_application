import 'package:e_commerce_application/data/repositories/banners/banners_repository.dart';
import 'package:e_commerce_application/data/repositories/brands/brands_repository.dart';
import 'package:e_commerce_application/data/repositories/category/category_repository.dart';
import 'package:e_commerce_application/data/repositories/products/product_repository.dart';
import 'package:e_commerce_application/data/repositories/relations/relations.dart';
import 'package:e_commerce_application/utils/constants/dummy_data.dart';
import 'package:e_commerce_application/utils/popups/loaders.dart';
import 'package:get/get.dart';

enum uploads {
  category,
  banner,
  product,
  brand,
  relation,
}

class UploadDataController extends GetxController {
  static UploadDataController get instance => Get.find();

  // Variables
  final isUploading = false.obs;
  final whichUpload = uploads.banner.obs;
  final _categoriesRepository = Get.put(CategoryRepository());
  final _bannersRepository = Get.put(BannerRepository());
  final _productRepository = Get.put(ProductRepository());
  final _brandRepository = Get.put(BrandRepository());
  final _relationsRepository = Get.put(RelationsRepository());

  void uploadCategories() async {
    try {
      whichUpload.value = uploads.category;
      isUploading.value = true;
      // uploading dummy data
      await _categoriesRepository.uploadDummyData(TDummyData.categories);

      TLoaders.successSnackBar(
          title: 'Successfully Uploaded',
          message: 'Categories data successfully uploaded.');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      isUploading.value = false;
    }
  }

  void uploadBrands() async {
    try {
       whichUpload.value = uploads.brand;
      isUploading.value = true;
      // uploading dummy data
      await _brandRepository.uploadDummyData(TDummyData.brands);

      TLoaders.successSnackBar(
          title: 'Successfully Uploaded',
          message: 'Banners data successfully uploaded.');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      isUploading.value = false;
    }
  }

  void uploadProducts() async {
    try {
       whichUpload.value = uploads.product;
      isUploading.value = true;
      // uploading dummy data
      await _productRepository.uploadDummyData(TDummyData.products);

      TLoaders.successSnackBar(
          title: 'Successfully Uploaded',
          message: 'Product data successfully uploaded.');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      isUploading.value = false;
    }
  }

  void uploadBanners() async {
    try {
       whichUpload.value = uploads.banner;
      isUploading.value = true;
      // uploading dummy data
      await _bannersRepository.uploadDummyData(TDummyData.banners);

      TLoaders.successSnackBar(
          title: 'Successfully Uploaded',
          message: 'Banners data successfully uploaded.');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      isUploading.value = false;
    }
  }

  void uploadRelations() async {
    try {
       whichUpload.value = uploads.relation;
      isUploading.value = true;
      // uploading dummy data
      await _relationsRepository.uploadDummyData(brandCategoryRelations: TDummyData.brandCategoryModel);
      await _relationsRepository.uploadDummyData(productCategoryRelations: TDummyData.productCategoryModel);

      TLoaders.successSnackBar(
          title: 'Successfully Uploaded',
          message: 'Relations data successfully uploaded.');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      isUploading.value = false;
    }
  }
}
