import 'package:hive_flutter/hive_flutter.dart';

part 'card-item.g.dart';

@HiveType(typeId: 0)
class BasketItem {
  @HiveField(0)
  String id;
  @HiveField(1)
  String collectionId;
  @HiveField(2)
  String thumbnail;
  @HiveField(3)
  int discountPrice;
  @HiveField(4)
  int price;
  @HiveField(5)
  String name;
  @HiveField(6)
  String categoryId;
  @HiveField(7)
  int? realPrice;
  @HiveField(8)
  num? percent;

  BasketItem(this.id, this.collectionId, this.thumbnail, this.discountPrice,
      this.price, this.name, this.categoryId) {
    realPrice = price + discountPrice;
    percent = ((price - realPrice!) / price) * 100;
  }
}
