import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comments.g.dart';

@JsonSerializable()
class Comments extends Equatable {
  final int? id;
  final int? postId;
  final String? name;
  final String? email;
  final String? body;

  const Comments({
    this.id,
    this.postId,
    this.name,
    this.email,
    this.body,
  });

  factory Comments.fromJson(Map<String, dynamic> json) =>
      _$CommentsFromJson(json);

  @override
  List<Object?> get props => [
        id,
        postId,
        name,
        email,
        body,
      ];
}
