import 'package:hive/hive.dart';

part 'card_item.g.dart';

@HiveType(typeId: 0)
class BasketItem extends HiveObject{
  @HiveField(0)
  String categoryId;
  @HiveField(1)
  String collectionId;
  @HiveField(2)
  int discountprice;
  @HiveField(3)
  String id;
  @HiveField(4)
  String name;
  @HiveField(5)
  int price;
  @HiveField(6)
  String thumbnail;
  @HiveField(7)
  int? realprice;
  @HiveField(8)
  num? persent;

  BasketItem(
    this.categoryId,
    this.collectionId,
    this.discountprice,
    this.id,
    this.name,
    this.price,
    this.thumbnail,
  ) {
    realprice = price + discountprice;
    persent = ((price - realprice!) / price) * 100;
    // this.thumbnail = 'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}';
  }
}
