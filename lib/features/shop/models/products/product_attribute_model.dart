class ProductAttributeModel {
  String? name;
  List<String>? values;

  ProductAttributeModel({this.name, this.values});

  // Json Formate
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'values': values,
    };
  }

  factory ProductAttributeModel.empty() {
    return ProductAttributeModel(name: '', values: []);
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

  String getValues() {

    return values!.join(', ');
  }

  String getName() {
    return name ?? "";
  }
}
