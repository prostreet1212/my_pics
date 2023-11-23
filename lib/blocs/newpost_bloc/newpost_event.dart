part of 'newpost_bloc.dart';

abstract class NewPostEvent {
  NewPostEvent();
}

class GetPostImageFromMemoryEvent extends NewPostEvent {
  GetPostImageFromMemoryEvent();
}

class AddPostEvent extends NewPostEvent {
  File? postImage;
  String postText;

  AddPostEvent({this.postImage, required this.postText});
}

class ChangePostTextEvent extends NewPostEvent {
  final String newText;

  ChangePostTextEvent({required this.newText});
}

class ChangeStatusEvent extends NewPostEvent {
  PostStatus postStatus;

  ChangeStatusEvent({required this.postStatus});
}
