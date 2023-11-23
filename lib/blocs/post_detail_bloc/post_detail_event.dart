part of 'post_detail_bloc.dart';

abstract class PostDetailEvent {}

class GetSelectedPostEvent extends PostDetailEvent {}

class ChangeLikeDetailPostEvent extends PostDetailEvent {
  final Post post;

  ChangeLikeDetailPostEvent({required this.post});
}

class DeletePostEvent extends PostDetailEvent {}
