class BannerCampin {
  String? categoryId;
  String? collectionId;
  String? id;
  String? thumbnail;
  BannerCampin(this.categoryId, this.collectionId, this.id, this.thumbnail);

  factory BannerCampin.fromJsone(Map<String, dynamic> jsonObject) {
    return BannerCampin(
      jsonObject['categoryId'],
      jsonObject['collectionId'],
      jsonObject['id'],
      'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
    );
  }
}
