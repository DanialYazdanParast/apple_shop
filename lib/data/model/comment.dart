class Comment {
  String id;
  String text;
  String productId;
  String userId;
  String userThumbnailUrl;
  String name;
  String avatar;
  Comment(this.id, this.text, this.productId, this.userId,
      this.userThumbnailUrl, this.name, this.avatar);

  factory Comment.fromMapson(Map<String, dynamic> jsonObject) {
    return Comment(
      jsonObject['id'],
      jsonObject['text'],
      jsonObject['product_id'],
      jsonObject['user_id'],
      'http://startflutter.ir/api/files/${jsonObject['expand']['user_id']['collectionName']}/${jsonObject['expand']['user_id']['id']}/${jsonObject['expand']['user_id']['avatar']}',
      jsonObject['expand']['user_id']['name'],
      jsonObject['expand']['user_id']['avatar'],
    );
  }
}
