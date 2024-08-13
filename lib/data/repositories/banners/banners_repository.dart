import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/data/services/firebase_storage_services.dart';
import 'package:e_commerce_application/features/shop/models/banner_model.dart';
import 'package:e_commerce_application/utils/constants/firebase_directory_name_constants.dart';
import 'package:e_commerce_application/utils/exceptions/firebase_exceptions.dart';
import 'package:e_commerce_application/utils/exceptions/format_exceptions.dart';
import 'package:e_commerce_application/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  // variables
  final _db = FirebaseFirestore.instance;

  /// Get all Banners
  Future<List<BannerModel>> fetchBanners() async {
    try {
      final snapshot = await _db
          .collection(TDirectoryNames.banners)
          .where('Active', isEqualTo: true)
          .get();
      final list = snapshot.docs
          .map((document) => BannerModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.toString());
    } on FormatException catch (e) {
      throw TFormatException(e.toString());
    } on PlatformException catch (e) {
      throw TPlatformException(e.toString());
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get all SubCategories

  /// Upload Categories to cloud
  Future<void> uploadDummyData(List<BannerModel> banners) async {
    try {
      final storage = Get.put(TFirebaseStorageServices());

      // loop through each banners from the local asset
      for (var banner in banners) {
        // get ImageData link from the local asset
        final file = await storage.getImageDataFromAssets(banner.imageUrl);
        // Upload image and get its URL
        final url =
            await storage.uploadImageData(TDirectoryNames.banners, file, banner.imageUrl);
        // Assign url to Banner.ImageUrl attribute
        banner.imageUrl = url;
        // Store Banner in Firestore
        await _db.collection(TDirectoryNames.banners).doc().set(banner.toJson());
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.toString());
    } on FormatException catch (e) {
      throw TFormatException(e.toString());
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
