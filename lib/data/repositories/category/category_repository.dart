import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/data/services/firebase_storage_services.dart';
import 'package:e_commerce_application/features/shop/models/category_model.dart';
import 'package:e_commerce_application/utils/exceptions/firebase_exceptions.dart';
import 'package:e_commerce_application/utils/exceptions/format_exceptions.dart';
import 'package:e_commerce_application/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  // variable
  final _db = FirebaseFirestore.instance;

  /// Get all Categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('categories').get();
      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
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
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final snapshot = await _db.collection('categories').where('ParentId', isEqualTo: categoryId).get();
      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
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


  /// Upload Categories to cloud
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      final storage = Get.put(TFirebaseStorageServices());
      // loop through each category from the local asset
      for (var category in categories) {
        // get ImageData link from the local asset
        final file = await storage.getImageDataFromAssets(category.image);
        // Upload image and get its URL
        final url =
            await storage.uploadImageData('categories', file, category.name);
        // Assign url to category.image attribute
        category.image = url;
        // Store Category in Firestore
        await _db
            .collection('categories')
            .doc(category.id)
            .set(category.toJson());
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
