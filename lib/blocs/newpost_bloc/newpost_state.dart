part of 'newpost_bloc.dart';

enum PostStatus { disable, loading, enable, failure, tryagain }

class NewPostState extends Equatable {
  final String uid;
  final Timestamp? datePublish;
  final File? postFile;
  final String postText;
  final PostStatus postStatus;

  const NewPostState(
      {this.uid = '',
      this.datePublish,
      this.postFile,
      this.postText = '',
      this.postStatus = PostStatus.disable});

  NewPostState copyWith(
      {String? uid,
      Timestamp? datePublish,
      File? postFile,
      String? postText,
      PostStatus? postStatus}) {
    return NewPostState(
      uid: uid ?? this.uid,
      datePublish: datePublish ?? this.datePublish,
      postFile: postFile ?? this.postFile,
      /*postFile: postStatus == PostStatus.tryagain&&postStatus==null
          ? null
          :postFile==this.postFile
          ?(this.postFile):postFile,*/
      postText: postText ?? this.postText,
      postStatus: postStatus ?? this.postStatus,
    );
  }

  @override
  List<Object?> get props => [uid, datePublish, postFile, postText, postStatus];
}
