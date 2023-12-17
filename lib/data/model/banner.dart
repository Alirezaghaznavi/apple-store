class BannerCamping {
  String id;
  String categoryId;
  String collectionId;
  String thumbnail;

  BannerCamping(this.id, this.categoryId, this.collectionId, this.thumbnail);

  factory BannerCamping.fromJson(Map<String, dynamic> jsonObject) {
    return BannerCamping(
      jsonObject['id'],
      jsonObject['categoryId'],
      jsonObject['collectionId'],
      'http://alirezagtech.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
    );
  }
}
