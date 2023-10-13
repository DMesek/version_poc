import 'package:json_annotation/json_annotation.dart';

part 'post_response.g.dart';

@JsonSerializable()
class Post {
  final String title;
  final String body;

  Post({
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) =>
      _$PostResponseFromJson(json);

  @override
  String toString() => '$title $body';
}
