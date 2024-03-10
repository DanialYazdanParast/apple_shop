class Category {
  String? collectionId;
  String? color;
  String? icon;
  String? id;
  String? thumbnail;
  String? title;

  Category(
    this.collectionId,
    this.color,
    this.icon,
    this.id,
    this.thumbnail,
    this.title,
  );

  factory Category.fromMapJson(Map<String, dynamic> jasonObject) {
    return Category(
      jasonObject['collectionId'],
      jasonObject['color'],
      'http://startflutter.ir/api/files/${jasonObject['collectionId']}/${jasonObject['id']}/${jasonObject['icon']}',
      jasonObject['id'],
      'http://startflutter.ir/api/files/${jasonObject['collectionId']}/${jasonObject['id']}/${jasonObject['thumbnail']}',
      jasonObject['title'],
    );
  }
}
