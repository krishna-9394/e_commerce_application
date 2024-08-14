import 'package:e_commerce_application/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commerce_application/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce_application/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commerce_application/features/shop/controllers/product/checkout_controller.dart';
import 'package:e_commerce_application/features/shop/controllers/product/order_controller.dart';
import 'package:e_commerce_application/features/shop/controllers/product/variation_controller.dart';
import 'package:e_commerce_application/utils/helpers/network_manager.dart';
import 'package:get/get.dart';

import '../utils/local_storage/storage_utility.dart';

class GeneralBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
    Get.put(CheckoutController());
    Get.put(AddressController());
  }
}
