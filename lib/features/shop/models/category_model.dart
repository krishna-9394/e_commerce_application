import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id, name, image, parentId;
  bool isFeatured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isFeatured,
    this.parentId = '',
  });

  // Empty Helper Function
  static CategoryModel empty() => CategoryModel(
        id: "",
        name: "",
        image: "",
        parentId: "",
        isFeatured: false,
      );

  // convert model to json structure
  Map<String, dynamic> toJson() {
    return {
      'Image': image,
      'IsFeatured': isFeatured,
      'Name': name,
      'ParentId': parentId,
    };
  }

  // Map Json Oriented Document Snapshot from Firebase to CategoryModel
  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      // Map JSON Record to the model
      return CategoryModel(
          id: document.id,
          name: data['Name'] ?? "",
          image: data['Image'] ?? "",
          isFeatured: data['IsFeatured'] ?? false,
          parentId: data['ParentId'] ?? "");
    } else {
      return CategoryModel.empty();
    }
  }
}
