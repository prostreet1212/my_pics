part of 'newsline_bloc.dart';

enum AllPostsStatus {
  initial,
  loading,
  success,
  failure,
}

class NewslineState extends Equatable {
  final List<Post> allPosts;
  final AllPostsStatus allPostsStatus;

  const NewslineState({
    this.allPosts = const [],
    this.allPostsStatus = AllPostsStatus.initial,
  });

  NewslineState copyWith(
      {List<Post>? allPosts,
      AllPostsStatus? allPostsStatus,
      Post? selectedPost}) {
    return NewslineState(
      allPosts: allPosts ?? this.allPosts,
      allPostsStatus: allPostsStatus ?? this.allPostsStatus,
    );
  }

  @override
  List<Object?> get props => [
        allPosts,
        allPostsStatus,
      ];
}
