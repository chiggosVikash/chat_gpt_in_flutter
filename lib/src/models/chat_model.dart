
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chat_model.g.dart';

@JsonSerializable()
@immutable
class ChatModel{
  final String role;
  final String content;

  const ChatModel({required this.content,required this.role});

  factory ChatModel.fromJson(Map<String,dynamic> json)=> _$ChatModelFromJson(json);

  Map<String,dynamic> toJson()=> _$ChatModelToJson(this);

}