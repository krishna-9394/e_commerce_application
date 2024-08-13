import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/data/services/firebase_storage_services.dart';
import 'package:e_commerce_application/features/shop/models/products/product_model.dart';
import 'package:e_commerce_application/utils/constants/dummy_data.dart';
import 'package:e_commerce_application/utils/exceptions/firebase_exceptions.dart';
import 'package:e_commerce_application/utils/exceptions/format_exceptions.dart';
import 'package:e_commerce_application/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  // variable
  final _db = FirebaseFirestore.instance;

  /// Get limited featured products
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshots = await _db
          .collection('products')
          .where('IsFeatured', isEqualTo: true)
          .limit(4)
          .get();
      final list = snapshots.docs
          .map((document) => ProductModel.fromSnapshot(document))
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

  /// Get all featured products
  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshots = await _db
          .collection('products')
          .where('IsFeatured', isEqualTo: true)
          .get();
      final list = snapshots.docs
          .map((document) => ProductModel.fromSnapshot(document))
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

  /// Get list of all products
  Future<List<ProductModel>> fetchProductByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs
          .map((docs) => ProductModel.fromQuerySnapshot(docs))
          .toList();
      return productList;
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

  /// Get list of all products
  Future<List<ProductModel>> getFavouriteProducts(List<String> productIds) async {
    try {
      final snapshots = await _db
          .collection('products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      final list = snapshots.docs
          .map((document) => ProductModel.fromSnapshot(document))
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

  /// Get Products for Brands
  Future<List<ProductModel>> getProductsForBrands(
      {required String brandId, int limit = -1}) async {
    try {
      final snapshots = limit == -1
          ? await _db
              .collection('products')
              .where('Brand.Id', isEqualTo: brandId)
              .get()
          : await _db
              .collection('products')
              .where('Brand.Id', isEqualTo: brandId)
              .limit(limit)
              .get();
      final list = snapshots.docs
          .map((document) => ProductModel.fromSnapshot(document))
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

  /// Get Products for Category
  Future<List<ProductModel>> getProductsForCategory(
      {required String categoryId, int limit = -1}) async {
    try {
      final productCategoryQuery = limit == -1
          ? await _db
              .collection('productcategory')
              .where('categoryId', isEqualTo: categoryId)
              .get()
          : await _db
              .collection('productcategory')
              .where('categoryId', isEqualTo: categoryId)
              .limit(limit)
              .get();
      List<String> productIds = productCategoryQuery.docs
          .map((doc) => doc['productId'] as String)
          .toList();

      final productQuery = await _db
          .collection('products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      List<ProductModel> products = productQuery.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
      return products;
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

  /// Upload Products to cloud
  Future<void> uploadDummyData(List<ProductModel> products) async {
    try {
      final storage = Get.put(TFirebaseStorageServices());
      // loop through each products from the local asset
      for (var product in products) {
        // get ImageData link from the local asset
        final thumbnail =
            await storage.getImageDataFromAssets(product.thumbnail);
        // Upload image and get its URL
        final url = await storage.uploadImageData(
            'products/images', thumbnail, product.thumbnail.toString());
        // Assign url to Product.thumbnail attribute
        product.thumbnail = url;

        // list of product images
        if (product.images != null && product.images!.isNotEmpty) {
          List<String> imageUrl = [];
          for (var image in product.images!) {
            // Get image data link from local assets
            final assetImage = await storage.getImageDataFromAssets(image);

            // upload the image and get the Url
            final url = await storage.uploadImageData(
                'products/images', assetImage, image);

            // assign url to product.thumbnail attribute
            imageUrl.add(url);
          }
          product.images!.clear();
          product.images!.addAll(imageUrl);
        }

        // Upload Variation images
        if (product.productType == ProductType.variable.toString()) {
          for (var variation in product.productVariations!) {
            // Get image data link for local assets
            final assetImage =
                await storage.getImageDataFromAssets(variation.image);
            // Upload image and get its Url
            final url = await storage.uploadImageData(
                '/products/images', assetImage, variation.image);
            // Assign URL to variation.image attribute
            variation.image = url;
          }
        }
        // Store products in Firestore
        await _db.collection('products').doc(product.id).set(product.toJson());
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
