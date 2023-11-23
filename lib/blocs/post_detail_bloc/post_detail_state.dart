part of 'post_detail_bloc.dart';

enum DeleteStatus { initial, loading, complete, failure }

class PostDetailState extends Equatable {
  final Post selectedPost;
  final DeleteStatus deleteStatus;

  const PostDetailState(
      {this.selectedPost = const Post(),
      this.deleteStatus = DeleteStatus.initial});

  PostDetailState copyWith({Post? selectedPost, DeleteStatus? deleteStatus}) {
    return PostDetailState(
      selectedPost: selectedPost ?? this.selectedPost,
      deleteStatus: deleteStatus ?? this.deleteStatus,
    );
  }

  @override
  List<Object?> get props => [selectedPost, deleteStatus];
}
