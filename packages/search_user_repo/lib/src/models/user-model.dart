class UserModel {
  final String? username;
  final String? url;
  final String? images;

  UserModel({this.images, this.url, this.username});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      url: json['url'],
      images: json['images']?['jpg']?['image_url'],
    );
  }
}
