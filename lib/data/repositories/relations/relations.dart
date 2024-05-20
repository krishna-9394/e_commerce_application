import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/data/services/firebase_storage_services.dart';
import 'package:e_commerce_application/features/shop/models/brand_category.dart';
import 'package:e_commerce_application/features/shop/models/product_category.dart';
import 'package:e_commerce_application/features/shop/models/products/product_model.dart';
import 'package:e_commerce_application/utils/constants/dummy_data.dart';
import 'package:e_commerce_application/utils/exceptions/firebase_exceptions.dart';
import 'package:e_commerce_application/utils/exceptions/format_exceptions.dart';
import 'package:e_commerce_application/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RelationsRepository extends GetxController {
  static RelationsRepository get instance => Get.find();

  // variable
  final _db = FirebaseFirestore.instance;

  /// Upload Products to cloud
  Future<void> uploadDummyData({
    List<ProductCategoryModel>? productCategoryRelations,
    List<BrandCategoryModel>? brandCategoryRelations,
  }) async {
    try {
      if (productCategoryRelations != null) {
        for (var relation in productCategoryRelations) {
          // Store products in Firestore
          await _db.collection('productcategory').doc().set(relation.toJson());
        }
      }
      if (brandCategoryRelations != null) {
        for (var relation in brandCategoryRelations) {
          // Store products in Firestore
          await _db.collection('brandcategory').doc().set(relation.toJson());
        }
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
