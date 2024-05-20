class ProductAttributeModel {
  String? name;
  final List<String>? values;

  ProductAttributeModel({this.name, this.values});

  // Json Formate
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'values': values,
    };
  }

  // convert the Json Oriented document snapshot from Firebase to ProductAttributeModel
  factory ProductAttributeModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return ProductAttributeModel();
    return ProductAttributeModel(
      name: data.containsKey('Name') ? data['Name'] : '',
      values: List<String>.from(data['values']),
    );
  }
}
