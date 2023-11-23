part of 'user_posts_bloc.dart';

enum UserPostsStatus {
  initial,
  loading,
  success,
  failure,
}

class UserPostsState extends Equatable {
  final List<Post> userPosts;
  final UserPostsStatus userPostsStatus;

  const UserPostsState(
      {this.userPosts = const [],
      this.userPostsStatus = UserPostsStatus.initial});

  UserPostsState copyWith(
      {List<Post>? userPosts, UserPostsStatus? userPostsStatus}) {
    return UserPostsState(
      userPosts: userPosts ?? this.userPosts,
      userPostsStatus: userPostsStatus ?? this.userPostsStatus,
    );
  }

  @override
  List<Object?> get props => [userPosts, userPostsStatus];
}
