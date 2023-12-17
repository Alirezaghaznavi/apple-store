class ProductImage {
  String imageUrl;
  String productsId;
  ProductImage(this.imageUrl, this.productsId);

  factory ProductImage.fromJson(Map<String, dynamic> jsonObject) {
    return ProductImage(
        'http://alirezagtech.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['image']}',
        jsonObject['productId']);
  }
}
