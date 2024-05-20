import 'package:e_commerce_application/data/repositories/brands/brands_repository.dart';
import 'package:e_commerce_application/data/repositories/products/product_repository.dart';
import 'package:e_commerce_application/features/shop/models/brand_model.dart';
import 'package:e_commerce_application/features/shop/models/products/product_model.dart';
import 'package:e_commerce_application/utils/popups/loaders.dart';
import 'package:get/get.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  final repository = Get.put(BrandRepository());
  RxBool isLoading = false.obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;

  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

  //  Load Brands
  Future<void> getFeaturedBrands() async {
    try {
      // show loader while loading Brands
      isLoading.value = true;

      final brands = await repository.getAllBrands();

      allBrands.assignAll(brands);

      featuredBrands.assignAll(
          brands.where((brand) => brand.isFeatured ?? false).take(4));
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // stop loader
      isLoading.value = false;
    }
  }

  // Get Brand for Category
  Future<List<BrandModel>> getBrandForCategory(String categoryId) async {
    try {
      final brands = await repository.getBrandsForCategory(categoryId);
      return brands;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  // Get Brand specific products from data source
  Future<List<ProductModel>> getBrandProducts({required String brandId, int limit = -1}) async {
    try {
      final products = await ProductRepository.instance
          .getProductsForBrands(brandId: brandId, limit: limit);
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
    return <ProductModel>[];
  }
}
