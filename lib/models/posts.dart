import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'posts.g.dart';

@JsonSerializable()
class Posts extends Equatable {
  final int? id;
  final int? userId;
  final String? title;
  final String? body;

  const Posts({
    this.id,
    this.userId,
    this.title,
    this.body,
  });

  factory Posts.fromJson(Map<String, dynamic> json) => _$PostsFromJson(json);

  @override
  List<Object?> get props => [
        id,
        userId,
        title,
        body,
      ];
}
