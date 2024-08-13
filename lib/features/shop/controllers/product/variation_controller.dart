import 'package:e_commerce_application/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commerce_application/features/shop/controllers/product/image_slider_cotroller.dart';
import 'package:e_commerce_application/features/shop/models/products/product_model.dart';
import 'package:e_commerce_application/features/shop/models/products/product_variation_model.dart';
import 'package:get/get.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  /// Variables
  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;

  /// Select Attribute and Variation
  void onAttributeSelected(
      ProductModel product, attributeName, attributeValue) {
    // When attribute is Selected  we will first add that attribute to the selectedAttributes
    final selectedAttributes =
        Map<String, dynamic>.from(this.selectedAttributes);
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    final selectedVariation = product.productVariations!.firstWhere(
      (variation) =>
          _isSameAttributeValues(variation.attributeValues, selectedAttributes),
      orElse: () => ProductVariationModel.empty(),
    );

    // show the selected Variations image as a Main Images
    if (selectedVariation.image.isNotEmpty) {
      ImageSliderController.instance.selectedProductImage.value =
          selectedVariation.image;
    }

    // show the selected Variations image as a Main Images
    if (selectedVariation.id.isNotEmpty) {
      final cartController = CartController.instance;
      cartController.productQuantityInCart.value = cartController.getVariationQuantityInCart(product.id, selectedVariation.id);
    }

    // Assign selected variations
    this.selectedVariation.value = selectedVariation;

    // update the selected product variation status
    getProductVariationStockStatus();
  }

  /// Check if selected attribute matches any variation attributes
  bool _isSameAttributeValues(
    Map<String, dynamic> variationAttributes,
    Map<String, dynamic> selectedAttributes,
  ) {
    // checking the number of variationAttributes is equal to selectedAttributes
    if (variationAttributes.length != selectedAttributes.length) return false;
    // if any of the attributes is different then return e.g [Green, Large] x [Green, Small]
    for (final key in variationAttributes.keys) {
      // Attribute[Key] = Value which could be [Green, Small, Cotton] etc
      if (variationAttributes[key] != selectedAttributes[key]) return false;
    }

    // TODO: Not able to understand;
    return true;
  }

  /// Check attribute availability / Stock in variations
  Set<String?> getAttributesAvailabilityInVariation(
    List<ProductVariationModel> variations,
    String attributeName,
  ) {
    // pass the variation to check which attributes are available and the stock is not 0
    final availableVariationsAttributeValues = variations
        .where((variation) =>
            variation.attributeValues[attributeName] != null &&
            variation.attributeValues[attributeName]!.isNotEmpty &&
            variation.stock > 0)
        // fetch all the non-empty attribute of variations
        .map((variation) => variation.attributeValues[attributeName] as String)
        .toSet();
    return availableVariationsAttributeValues;
  }

  /// Check product variation Stock Status
  void getProductVariationStockStatus() {
    variationStockStatus.value =
        selectedVariation.value.stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  /// Reset Selected Attributes when switching the products
  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }

  //
  String getVariationPrice() {
    const String currencySign = '\u{20B9}';
    String price = (selectedVariation.value.salePrice > 0
            ? selectedVariation.value.salePrice
            : selectedVariation.value.price)
        .toString();
    return '$currencySign $price';
  }
}
