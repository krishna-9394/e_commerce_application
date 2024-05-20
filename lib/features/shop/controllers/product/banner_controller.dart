import 'package:e_commerce_application/data/repositories/banners/banners_repository.dart';
import 'package:e_commerce_application/features/shop/models/banner_model.dart';
import 'package:e_commerce_application/utils/popups/loaders.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  // Rx Variable
  final isLoading = false.obs;
  final Rx<int> carouselCurrentIndex = 0.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;
  final _bannerRepository = Get.put(BannerRepository());

  @override
  void onInit() {
    fetchBanner();
    super.onInit();
  }

  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
  }

  /// -- Load Banner Data
  Future<void> fetchBanner() async {
    try {
      // show loader while loading banners.
      isLoading.value = true;
      // Fetch Categories from data Source(Firestore, API, etc..)
      final allBanners = await _bannerRepository.fetchBanners();

      // update categories list
      banners.assignAll(allBanners);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // Remove Loader
      isLoading.value = false;
    }
  }
}
