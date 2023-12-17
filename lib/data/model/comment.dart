class Comment {
  String id;
  String text;
  String productId;
  String userId;
  String userAvatarUrl;
  String name;
  String username;
  String avatar;

  Comment(
    this.id,
    this.text,
    this.productId,
    this.userId,
    this.userAvatarUrl,
    this.avatar,
    this.name,
    this.username,
  );

  factory Comment.fromJson(Map<String, dynamic> jsonObject) {
    return Comment(
      jsonObject['id'],
      jsonObject['text'],
      jsonObject['productId'],
      jsonObject['userId'],
      "http://alirezagtech.ir/api/files/${jsonObject['expand']['userId']['collectionName']}/${jsonObject['expand']['userId']['id']}/${jsonObject['expand']['userId']['avatar']}",
      jsonObject['expand']['userId']['avatar'],
      jsonObject['expand']['userId']['name'],
      jsonObject['expand']['userId']['username'],
    );
  }
}
