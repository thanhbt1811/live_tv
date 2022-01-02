import 'package:equatable/equatable.dart';
import 'package:live_tv/model/comment_model.dart';

enum CommentStatus { initial, loading, success, failed }

class CommentState extends Equatable {
  final CommentStatus status;
  final List<CommentModel> comments;
  final DateTime updateAt;

  CommentState({
    required this.status,
    required this.comments,
    required this.updateAt,
  });

  factory CommentState.initial() => CommentState(
      status: CommentStatus.initial, comments: [], updateAt: DateTime.now());

  CommentState copyWith({CommentStatus? status, List<CommentModel>? comments}) {
    return CommentState(
        status: status ?? this.status,
        comments: comments ?? this.comments,
        updateAt: DateTime.now());
  }

  @override
  List<Object?> get props => [status, comments, updateAt];
}
