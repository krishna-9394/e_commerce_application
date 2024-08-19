import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../features/shop/models/category_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class BrandUploadsRepository extends GetxController {
  static BrandUploadsRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // upload Images
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
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

  // Function to save Category Model.
  Future<void> uploadCategoryData(CategoryModel category) async {
    try {
      final id = const Uuid().v1();
      category.id = id;
      await _db.collection("brands").doc(id).set(category.toJson());
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

  // Function to save Category Model.
  Future<void> updateCategoryData(CategoryModel updatedCategory) async {
    try {
      final id = updatedCategory.id;
      await _db
          .collection("brands")
          .doc(updatedCategory.id)
          .update(updatedCategory.toJson());
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

  // Function to save Category Model.
  Future<void> deleteCategoryData(String id) async {
    try {
      await _db.collection("brands").doc(id).delete();
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

  // Function to delete Image from firebase storage.
  Future<void> deleteImage(String imageUrl) async {
    try {
      final RegExp regExp = RegExp(r'/o/(.*)\?alt=media');
      final RegExpMatch? match = regExp.firstMatch(imageUrl);

      if (match != null) {
        // Decode the file path to handle spaces and special characters
        final String filePath = Uri.decodeFull(match.group(1)!);

        // Delete the file from Firebase Storage
        await FirebaseStorage.instance.ref(filePath).delete();

      } else {
        throw "Could not extract file path from imageUrl";
      }
    } catch (e) {
      throw "Error deleting image: $e";
    }
  }

  // Function to fetch user details based on user ID
  Future<CategoryModel> getCategoryDetails(String id) async {
    try {
      final documentSnapshot = await _db
          .collection("brands").doc(id)
          .get();
      if(documentSnapshot.exists) {
        return CategoryModel.fromSnapshot(documentSnapshot);
      } else {
        return CategoryModel.empty();
      }
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


  // Function to fetch user details based on user ID
  Future<Map<String, String>> fetchCategoryList() async {
    try {
      final documentSnapshot = await _db
          .collection("brands")
          .get();
      var map = <String, String>{};
      for(var doc in documentSnapshot.docs) {
        final category = CategoryModel.fromSnapshot(doc);
        map[category.id] = category.name;
      }
      return map;
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
}