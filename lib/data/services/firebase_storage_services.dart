import 'dart:io';

import 'package:e_commerce_application/utils/exceptions/firebase_exceptions.dart';
import 'package:e_commerce_application/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TFirebaseStorageServices extends GetxController {
  static TFirebaseStorageServices get instance => Get.find();

  final _firebaseStorage = FirebaseStorage.instance;

  // upload local Assets from IDE
  // Returns a Uint8List containing image data
  Future<Uint8List> getImageDataFromAssets(String path) async {
    try {
      final byteData = await rootBundle.load(path);
      final imageData = byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      return imageData;
    } catch (e) {
      throw 'Error loading image data $e';
    }
  }

  // Upload the ImageData on cloud firebase storage
  // Return the download URL of the uploaded image
  Future<String> uploadImageData(
      String path, Uint8List image, String name) async {
    try {
      final ref = _firebaseStorage.ref(path).child(name);
      await ref.putData(image);
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.toString());
    } on PlatformException catch (e) {
      throw TPlatformException(e.toString());
    } on SocketException catch (e) {
      throw 'Network Error${e.toString()}';
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Upload the Image on cloud firebase storage
  // Return the download URL of the uploaded image
  Future<String> uploadImageFile(String path, XFile image) async {
    try {
      final ref = _firebaseStorage.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.toString());
    } on PlatformException catch (e) {
      throw TPlatformException(e.toString());
    } on SocketException catch (e) {
      throw 'Network Error${e.toString()}';
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
