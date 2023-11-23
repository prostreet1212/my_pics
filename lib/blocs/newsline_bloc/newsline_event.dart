part of 'newsline_bloc.dart';

abstract class NewslineEvent {}

class GetAllPostsEvent extends NewslineEvent {}

class ChangeSelectedPostEvent extends NewslineEvent {
  final Post post;

  ChangeSelectedPostEvent({required this.post});
}

class ChangeLikeEvent extends NewslineEvent {
  final Post post;

  ChangeLikeEvent({required this.post});
}
