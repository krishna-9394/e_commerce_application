import 'dart:convert';

import 'package:e_commerce_application/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:e_commerce_application/data/repositories/products/product_repository.dart';
import 'package:e_commerce_application/features/shop/models/products/product_model.dart';
import 'package:e_commerce_application/utils/local_storage/storage_utility.dart';
import 'package:e_commerce_application/utils/popups/loaders.dart';
import 'package:get/get.dart';

class FavouriteController extends GetxController {
  static FavouriteController get instance => Get.find();

  final favourites = <String, bool>{}.obs;
  final itemToggled = false.obs;

  @override
  void onInit() {
    super.onInit();
    initFavourite();
  }

  // methods to initialize favorites by reading from local storage
  void initFavourite() {
    final json = TLocalStorage.instance().readData('favourites');
    if (json != null) {
      final storedFavourites = jsonDecode(json) as Map<String, dynamic>;
      favourites.assignAll(
          storedFavourites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavourite(String productId) {
    return favourites[productId] ?? false;
  }

  void toggleFavouriteIcon(String productId) {
    if (!favourites.containsKey(productId)) {
      favourites[productId] = true;
      saveFavouriteToStorage();
      itemToggled.value = !itemToggled.value;
      TLoaders.customToast(message: 'Product has been added to the Wishlist');
    } else {
      TLocalStorage.instance().removeData(productId);
      favourites.remove(productId);
      saveFavouriteToStorage();
      favourites.refresh();
      itemToggled.value = !itemToggled.value;
      TLoaders.customToast(message: 'Product has been removed to the Wishlist');
    }
  }

  void saveFavouriteToStorage() {
    final encodedFavourites = json.encode(favourites);
    TLocalStorage.instance().saveData('favourites', encodedFavourites);
  }

  Future<List<ProductModel>> favouriteProducts() async {
    return await ProductRepository.instance
        .getFavouriteProducts(favourites.keys.toList());
  }
}
