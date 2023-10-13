// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostResponseFromJson(Map<String, dynamic> json) => Post(
      title: json['title'] as String,
      body: json['body'] as String,
    );

Map<String, dynamic> _$PostResponseToJson(Post instance) => <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
    };
