import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_pics/models/post.dart';

part 'newpost_event.dart';

part 'newpost_state.dart';

class NewPostBloc extends Bloc<NewPostEvent, NewPostState> {
  FirebaseStorage storage = FirebaseStorage.instance;
  TextEditingController namePostController = TextEditingController();

  NewPostBloc() : super(const NewPostState()) {
    on<GetPostImageFromMemoryEvent>(_getPostImageFromMemoryEvent);
    on<AddPostEvent>(_addPostEvent);
    on<ChangePostTextEvent>(_changePostTextEvent);
    on<ChangeStatusEvent>(_changeStatusEvent);
  }

  Future<void> _getPostImageFromMemoryEvent(
      GetPostImageFromMemoryEvent event, Emitter<NewPostState> emit) async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxWidth: 1200);
    if (pickedFile != null) {
      File selectedImage = File(pickedFile.path);
      emit(state.copyWith(postFile: selectedImage));
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
    }
  }

  Future<void> _addPostEvent(
      AddPostEvent event, Emitter<NewPostState> emit) async {
    emit(state.copyWith(postStatus: PostStatus.loading));
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      String docId = FirebaseFirestore.instance.collection('posts').doc().id;

      Reference storageReference =
          storage.ref().child('users').child(uid).child('posts').child(docId);

      UploadTask? uploadTask = storageReference.putFile(event.postImage!);
      uploadTask.timeout(const Duration(seconds: 20), onTimeout: () async {
        if (kDebugMode) {
          print('таймаут');
        }
        await uploadTask!.cancel().whenComplete(
            () => emit(state.copyWith(postStatus: PostStatus.failure)));
        throw TimeoutException('Upload timed out');
      });

      await uploadTask.then((p0) => null);

      uploadTask.snapshotEvents.listen((event) {
        if (event.state == TaskState.canceled) {
          uploadTask = null;
        }
      });

      await uploadTask!.whenComplete(() async {
        String downloadUrl = await storageReference.getDownloadURL();
        Timestamp datePublish = Timestamp.fromDate(DateTime.now());
        Post post = Post(
            postId: docId,
            uid: uid,
            datePublish: datePublish,
            url: downloadUrl,
            description: event.postText);
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(docId)
            .set(post.toJson())
            .then((value) {
          emit(const NewPostState(postStatus: PostStatus.tryagain));
        });
      });
    } catch (error) {
      if (kDebugMode) {
        print('ошибка $error');
      }
      emit(state.copyWith(postStatus: PostStatus.failure));
    }
  }

  void _changePostTextEvent(
      ChangePostTextEvent event, Emitter<NewPostState> emit) {
    emit(state.copyWith(postText: event.newText));
  }

  void _changeStatusEvent(ChangeStatusEvent event, Emitter<NewPostState> emit) {
    emit(state.copyWith(postStatus: event.postStatus));
  }
}
