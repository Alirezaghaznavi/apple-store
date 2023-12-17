class Product {
  String id;
  String collectionId;
  String thumbnail;
  String description;
  int discountPrice;
  int price;
  String popularity;
  String name;
  int quantity;
  String categoryId;
  int? realPrice;
  num? percent;
  Product(
      this.id,
      this.collectionId,
      this.thumbnail,
      this.description,
      this.discountPrice,
      this.price,
      this.popularity,
      this.name,
      this.quantity,
      this.categoryId) {
    realPrice = price + discountPrice;
    percent = ((price - realPrice!) / price) * 100;
  }

  factory Product.fromJson(Map<String, dynamic> jsonObject) {
    return Product(
        jsonObject['id'],
        jsonObject['collectionId'],
        'http://alirezagtech.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
        jsonObject['description'],
        jsonObject['discountPrice'],
        jsonObject['price'],
        jsonObject['popularity'],
        jsonObject['name'],
        jsonObject['quantity'],
        jsonObject['categoryId']);
  }
}
