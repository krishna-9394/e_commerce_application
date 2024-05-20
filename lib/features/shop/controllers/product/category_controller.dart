import 'package:e_commerce_application/data/repositories/category/category_repository.dart';
import 'package:e_commerce_application/data/repositories/products/product_repository.dart';
import 'package:e_commerce_application/features/shop/models/category_model.dart';
import 'package:e_commerce_application/features/shop/models/products/product_model.dart';
import 'package:e_commerce_application/utils/popups/loaders.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final _categoryRepository = Get.put(CategoryRepository());
  final isLoading = false.obs;
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  /// -- Load Category Data
  Future<void> fetchCategories() async {
    try {
      // show loader while loading categories.
      isLoading.value = true;
      // Fetch Categories from data Source(Firestore, API, etc..)
      final categories = await _categoryRepository.getAllCategories();
      // update categories list
      allCategories.assignAll(categories);
      // Filter featured categories
      featuredCategories.assignAll(allCategories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .take(8)
          .toList());
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // Remove Loader
      isLoading.value = false;
    }
  }

  /// -- Load Selected Category Data

  /// -- Get Category or Sub-Category Products
  Future<List<ProductModel>> getCategoryProducts({
    required String categoryId,
    int limit = 4,
  }) async {
    // Fetch limited (4) products against each subcategory.
    final products = await ProductRepository.instance
        .getProductsForCategory(categoryId: categoryId, limit: limit);
    return products;
  }
}
