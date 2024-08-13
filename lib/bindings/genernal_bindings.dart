import 'package:e_commerce_application/features/shop/controllers/product/variation_controller.dart';
import 'package:e_commerce_application/utils/helpers/network_manager.dart';
import 'package:get/get.dart';

class GeneralBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
  }
}
