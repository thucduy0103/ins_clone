// import 'package:json_annotation/json_annotation.dart';

// @JsonSerializable()
class Post {
  String? id;
  String? name;
  String? avatar;
  String? image;
  String? content;
  String? createdAt;

  Post({
    this.id,
    this.name,
    this.avatar,
    this.image,
    this.content,
    this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json["id"],
        name: json['name'],
        avatar: json["avatar"],
        image: json['image'],
        content: json["content"],
        createdAt: json["createdAt"]);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'avatar': avatar,
        'image': image,
        'content': content,
        'createAt': createdAt
      };
}
