import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'image_event.dart';

part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  ImageBloc() : super(const ImageState()) {
    on<GetImageFromMemoryEvent>(_getImageFromMemoryEvent);
    on<CheckAndDownloadImageEvent>(_checkAndDownloadImageEvent);
    on<ClearImageEvent>(_clearImageEvent);
    on<UploadAvatarEvent>(_uploadAvatarEvent);
  }

  void _clearImageEvent(ClearImageEvent event, Emitter<ImageState> emit) {
    emit(const ImageState());
  }

  Future _getImageFromMemoryEvent(
    GetImageFromMemoryEvent event,
    Emitter<ImageState> emit,
  ) async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxHeight: 200);
    if (pickedFile != null) {
      File selectedImage = File(pickedFile.path);
      emit(state.copyWith(
          image: selectedImage, avatarStatus: AvatarStatus.fromMemory));
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
    }
  }

  Future _checkAndDownloadImageEvent(
      CheckAndDownloadImageEvent event, Emitter<ImageState> emit) async {
    emit(state.copyWith(avatarUrl: event.url));
  }

  Future<void> _uploadAvatarEvent(
      UploadAvatarEvent event, Emitter<ImageState> emit) async {
    String downloadUrl;
    String uid = FirebaseAuth.instance.currentUser!.uid;
    emit(state.copyWith(avatarStatus: AvatarStatus.loading));
    Reference storageReference =
        storage.ref().child('users').child(uid).child('avatar').child(uid);

    var uploadTask = storageReference.putFile(event.avatar);

    await uploadTask.whenComplete(() async {
      if (uploadTask.snapshot.state == TaskState.success) {
        downloadUrl = await storageReference.getDownloadURL();
        try {
          DocumentSnapshot<Map<String, dynamic>> snapshot =
              await firestore.collection('users').doc(uid).get();
          if (snapshot.exists) {
            Map<String, dynamic> userData =
                snapshot.data() as Map<String, dynamic>;
            userData['avatarUrl'] = downloadUrl;

            await FirebaseFirestore.instance
                .collection('users')
                .doc(uid)
                .update(userData);

            emit(state.copyWith(
                message: 'Аватар изменен',
                forChanged: !(state.forChanged),
                avatarUrl: downloadUrl,
                avatarStatus: AvatarStatus.success));
          }
        } catch (e) {
          emit(state.copyWith(
              message: 'Ошибка загрузки изображения',
              forChanged: !(state.forChanged),
              avatarStatus: AvatarStatus.failure));
        }
      } else {
        emit(state.copyWith(
            message: 'Ошибка загрузки изображения',
            forChanged: !(state.forChanged),
            avatarStatus: AvatarStatus.failure));
      }
    });
  }
}
