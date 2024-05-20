import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/data/services/firebase_storage_services.dart';
import 'package:e_commerce_application/features/shop/models/brand_model.dart';
import 'package:e_commerce_application/utils/exceptions/firebase_exceptions.dart';
import 'package:e_commerce_application/utils/exceptions/format_exceptions.dart';
import 'package:e_commerce_application/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  // variables
  final _db = FirebaseFirestore.instance;

  /// Get all Brands
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection('brands').get();
      final list = snapshot.docs
          .map((document) => BrandModel.fromSnapshot(document))
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

  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      // Query all the documents where categoryId matches the provided categoryID
      QuerySnapshot brandCategoryQuery = await _db
          .collection('brandcategory')
          .where('categoryId', isEqualTo: categoryId)
          .get();

      // Extract the brandIds from the documents
      List<String> brandIds = brandCategoryQuery.docs
          .map((doc) => doc['brandId'] as String)
          .toList();

      // Check if brandIds is empty before querying the brands collection
      if (brandIds.isEmpty) {
        // Return an empty list if no brands are found for the category
        return [];
      }

      // Query to get all the documents where brandId is in the list of brandIds
      final brandQuery =
          await _db.collection('brands').where('Id', whereIn: brandIds).get();

      // Extract the Brand Name and other relevant data
      List<BrandModel> brands =
          brandQuery.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();
      int count = 0;
      List<BrandModel> updatedProducts = [];
      for (BrandModel brand in brands) {
        if (count == 2) break;
        updatedProducts.assign(brand);
        count++;
      }
      return updatedProducts;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.toString());
    } on FormatException catch (e) {
      throw TFormatException(e.toString());
    } on PlatformException catch (e) {
      throw TPlatformException(e.toString());
    } catch (e) {
      print('info: ${e.toString()}');
      throw 'Something went wrong. Please try again';
    }
  }

  /// Upload Categories to cloud
  Future<void> uploadDummyData(List<BrandModel> brands) async {
    try {
      final storage = Get.put(TFirebaseStorageServices());

      // loop through each banners from the local asset
      for (var brand in brands) {
        // get ImageData link from the local asset
        final file = await storage.getImageDataFromAssets(brand.image);
        // Upload image and get its URL
        final url = await storage.uploadImageData('brands', file, brand.image);
        // Assign url to Banner.ImageUrl attribute
        brand.image = url;
        // Store Banner in Firestore
        await _db.collection('brands').doc().set(brand.toJson());
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
