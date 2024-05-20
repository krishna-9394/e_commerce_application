import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productsCount;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured,
    this.productsCount,
  });

  static BrandModel empty() => BrandModel(id: '', name: '', image: '');

  // convert BrandModel to json to store data in firebase.
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'ImageUrl': image,
      'ProductCount': productsCount,
      'IsFeatured': isFeatured,
    };
  }

  // Map Json Oriented Snapshot document from Firebase to BrandModel
  factory BrandModel.fromSnapshot(DocumentSnapshot document) {
    if (document.data() == null) return BrandModel.empty();
    final data = document.data() as Map<String, dynamic>;
    if (data.isEmpty) return BrandModel.empty();
    return BrandModel(
      id: data['Id'] ?? '',
      name: data['Name'] ?? '',
      image: data['ImageUrl'] ?? '',
      productsCount: data['ProductCount'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
    );
  }
  // Map Json Oriented Snapshot document from Firebase to BrandModel
  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return BrandModel.empty();
    return BrandModel(
      id: data['Id'] ?? '',
      name: data['Name'] ?? '',
      image: data['ImageUrl'] ?? '',
      productsCount: data['ProductCount'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
    );
  }
}
