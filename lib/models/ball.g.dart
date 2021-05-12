// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ball.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ball _$BallFromJson(Map<String, dynamic> json) {
  return Ball(
    json['blue'] as String,
    json['code'] as String,
    json['content'] as String,
    json['date'] as String,
    json['msg'] as String,
    json['name'] as String,
    json['red'] as String,
  );
}

Map<String, dynamic> _$BallToJson(Ball instance) => <String, dynamic>{
      'blue': instance.blue,
      'code': instance.code,
      'content': instance.content,
      'date': instance.date,
      'msg': instance.msg,
      'name': instance.name,
      'red': instance.red,
    };
