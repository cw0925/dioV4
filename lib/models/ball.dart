import 'package:json_annotation/json_annotation.dart';

part 'ball.g.dart';


@JsonSerializable()
class Ball extends Object {

  @JsonKey(name: 'blue')
  String blue;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'date')
  String date;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'red')
  String red;

  Ball(this.blue,this.code,this.content,this.date,this.msg,this.name,this.red,);

  factory Ball.fromJson(Map<String, dynamic> srcJson) => _$BallFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BallToJson(this);

}