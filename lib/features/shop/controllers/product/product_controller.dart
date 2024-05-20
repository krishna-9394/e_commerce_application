import 'package:e_commerce_application/data/repositories/banners/banners_repository.dart';
import 'package:e_commerce_application/data/repositories/products/product_repository.dart';
import 'package:e_commerce_application/features/shop/models/banner_model.dart';
import 'package:e_commerce_application/features/shop/models/products/product_model.dart';
import 'package:e_commerce_application/utils/constants/dummy_data.dart';
import 'package:e_commerce_application/utils/popups/loaders.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  // Rx Variable
  final isLoading = false.obs;
  final Rx<int> carouselCurrentIndex = 0.obs;
  final RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  final _productRepository = Get.put(ProductRepository());

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
  }

  /// -- Load Featured Products Data
  Future<void> fetchFeaturedProducts() async {
    try {
      // show loader while loading Products.
      isLoading.value = true;
      // Fetch Products from data Source(Firestore, API, etc..)
      final products = await _productRepository.getFeaturedProducts();

      // update categories list
      featuredProducts.assignAll(products);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // Remove Loader
      isLoading.value = false;
    }
  }

  /// -- Load Products Data
  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      // Fetch Products from data Source(Firestore, API, etc..)
      final products = await _productRepository.getAllFeaturedProducts();
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return <ProductModel>[];
    }
  }

  /// -- Get the Product price or Price range for variation
  String getProductPrice(ProductModel product) {
    const String currencySign = '\u{20B9}';
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    // If no variation exist, return the simple price or sale price
    if (product.productType == ProductType.single.toString()) {
      double priceToConsider =
          (product.salePrice > 0.0 ? product.salePrice : product.price);
      return '$currencySign$priceToConsider';
    } else {
      // calculate the smallest and largest price among the variations
      for (var variation in product.productVariations!) {
        double priceToConsider =
            product.salePrice > 0.0 ? variation.salePrice : variation.price;
        if (smallestPrice >= priceToConsider) {
          smallestPrice = priceToConsider;
        }
        if (priceToConsider >= largestPrice) {
          largestPrice = priceToConsider;
        }
      }
    }
    if (smallestPrice.isEqual(largestPrice)) {
      return largestPrice.toString();
    } else {
      if (smallestPrice == double.infinity) smallestPrice = 0;
      // Otherwise return a price range
      return '$currencySign$smallestPrice - $currencySign$largestPrice';
    }
  }

  /// -- Calculated Discount Percentage
  String? calculateSaleDiscount(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) {
      return null;
    } else if (originalPrice <= 0.0) {
      return null;
    } else {
      double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
      return percentage.toStringAsFixed(0);
    }
  }

  /// -- Check the product status
  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }
}
