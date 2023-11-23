part of 'image_bloc.dart';

abstract class ImageEvent {
  const ImageEvent();
}

class GetImageFromMemoryEvent extends ImageEvent {}

class CheckAndDownloadImageEvent extends ImageEvent {
  final String uid;
  final String url;

  const CheckAndDownloadImageEvent({required this.uid, required this.url});
}

class ClearImageEvent extends ImageEvent {}

class UploadAvatarEvent extends ImageEvent {
  final File avatar;

  const UploadAvatarEvent({required this.avatar});
}

class ChangeAvatarStatusEvent extends ImageEvent {
  final AvatarStatus avatarStatus;

  const ChangeAvatarStatusEvent({required this.avatarStatus});
}
