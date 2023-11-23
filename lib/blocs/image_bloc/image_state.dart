part of 'image_bloc.dart';

enum AvatarStatus { initial, success, failure, loading, fromMemory }

class ImageState extends Equatable {
  final File? image;
  final AvatarStatus avatarStatus;
  final String message;
  final bool forChanged;
  final String avatarUrl;

  const ImageState(
      {this.image,
      this.avatarStatus = AvatarStatus.initial,
      this.message = '',
      this.forChanged = false,
      this.avatarUrl = ''});

  ImageState copyWith({
    File? image,
    AvatarStatus? avatarStatus,
    String? message,
    bool? forChanged,
    String? avatarUrl,
  }) {
    return ImageState(
      image: image ?? this.image,
      avatarStatus: avatarStatus ?? this.avatarStatus,
      message: message ?? this.message,
      forChanged: forChanged ?? this.forChanged,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  @override
  List<Object?> get props =>
      [image, avatarStatus, message, forChanged, avatarUrl];
}
