class Product {
  String categoryId;
  String collectionId;
  String collectionName;
  String description;
  int discountprice;
  String id;
  String name;
  String popularity;
  int price;
  int quantity;
  String thumbnail;
  int? realprice;
  num? persent;

  Product(
    this.categoryId,
    this.collectionId,
    this.collectionName,
    this.description,
    this.discountprice,
    this.id,
    this.name,
    this.popularity,
    this.price,
    this.quantity,
    this.thumbnail,
  ) {
    realprice = price + discountprice;
    persent = ((price - realprice!) / price) * 100;
  }

  factory Product.fromJson(Map<String, dynamic> jsonObject) {
    return Product(
      jsonObject['category'],
      jsonObject['collectionId'],
      jsonObject['collectionName'],
      jsonObject['description'],
      jsonObject['discount_price'],
      jsonObject['id'],
      jsonObject['name'],
      jsonObject['popularity'],
      jsonObject['price'],
      jsonObject['quantity'],
      'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
    );
  }
}
