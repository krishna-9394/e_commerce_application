import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/data/repositories/products/product_repository.dart';
import 'package:e_commerce_application/features/shop/models/products/product_model.dart';
import 'package:e_commerce_application/utils/popups/loaders.dart';
import 'package:get/get.dart';

class AllProductController extends GetxController {
  static AllProductController get instance => Get.find();

  final repository = ProductRepository.instance;
  final RxString selectedSortOption = 'Name'.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;

  void sortProducts(String sortOptions) {
    selectedSortOption.value = sortOptions;

    switch (selectedSortOption.value) {
      case 'Name':
        products.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Higher Price':
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Lower Price':
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Sale':
        products.sort((a, b) {
          if (a.salePrice > 0 && b.salePrice > 0) {
            return b.salePrice.compareTo(a.salePrice);
          } else if (a.salePrice > 0) {
            return -1;
          } else if (b.salePrice > 0) {
            return 1;
          } else {
            return 0;
          }
        });
        break;
      case 'Newest':
        products.sort((a, b) => a.date!.compareTo(b.date!));
        break;
      default:
        products.sort((a, b) => a.title.compareTo(b.title));
        break;
    }
  }

  void assignProducts(List<ProductModel> products) {
    this.products.clear();
    // Assign products to product list.
    this.products.assignAll(products);
    sortProducts('Name');
  }

  Future<List<ProductModel>> fetchProductByQuery(Query? query) async {
    try {
      if (query == null) return [];
      final products = await repository.fetchProductByQuery(query);
      TLoaders.errorSnackBar(title: 'Success!', message: 'Successfully fetched the products');// TODO
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
}
