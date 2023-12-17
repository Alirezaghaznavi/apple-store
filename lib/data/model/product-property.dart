class ProductProperty {
  String? title;
  String? value;

  ProductProperty(this.title, this.value);

  factory ProductProperty.fromJson(Map<String, dynamic> jsonObject) {
    return ProductProperty(jsonObject['title'], jsonObject['value']);
  }
}
