import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_pics/models/user.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  FirebaseAuth authService = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  AuthBloc() : super(const AuthState()) {
    on<SignupButtonPressedEvent>(_signupButtonPressedEvent);
    on<LoginButtonPressedEvent>(_loginButtonPressedEvent);
    on<UpdateNameUserEvent>(_updateNameUserEvent);
    on<CheckUserEvent>(_checkUserEvent);
    on<ClearUserEvent>(_clearUserEvent);
    on<CompleteRegistration>(_completeRegistration);
    on<ChangeAvatarUrlEvent>(_changeAvatarUrlEvent);
  }

  void _changeAvatarUrlEvent(
      ChangeAvatarUrlEvent event, Emitter<AuthState> emit) {
    emit(
        state.copyWith(user: state.user!.copyWith(avatarUrl: event.avatarUrl)));
  }

  Future<void> _clearUserEvent(
      ClearUserEvent event, Emitter<AuthState> emit) async {
    emit(
      state.copyWith(
        message: '',
        authStatus: AuthStatus.initial,
        forChanged: false,
        user: const ProfileUser(),
        checkStatus: AuthStatus.initial,
        completeStatus: AuthStatus.initial,
      ),
    );
  }

  Future<void> _checkUserEvent(
      CheckUserEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(checkStatus: AuthStatus.loading));
    //await Future.delayed(const Duration(milliseconds: 2500));
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection('users').doc(firebaseUser.uid).get();

      if (snapshot.data() != null) {
        Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
        ProfileUser profileUser = ProfileUser.fromMap(userData);
        if (profileUser.name != '') {
          emit(state.copyWith(
              checkStatus: AuthStatus.success, user: profileUser));
        } else {
          emit(state.copyWith(checkStatus: AuthStatus.failure, user: null));
        }
      } else {
        emit(state.copyWith(checkStatus: AuthStatus.failure, user: null));
      }
    } else {
      emit(state.copyWith(checkStatus: AuthStatus.failure, user: null));
    }
  }

  Future<void> _signupButtonPressedEvent(
    SignupButtonPressedEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(state.copyWith(authStatus: AuthStatus.loading));
      await authService.createUserWithEmailAndPassword(
          email: event.email, password: event.password);
      User? firebaseUser = FirebaseAuth.instance.currentUser;
      ProfileUser profileUser = ProfileUser(
          uid: firebaseUser!.uid, name: '', email: firebaseUser.email!);
      try {
        await firestore
            .collection('users')
            .doc(firebaseUser.uid)
            .set(profileUser.toMap());
        emit(state.copyWith(
            message: 'checkUser',
            authStatus: AuthStatus.success,
            user: profileUser));
      } catch (e) {
        emit(state.copyWith(
            message: 'Не удалось добавить пользователя $e',
            authStatus: AuthStatus.failure,
            forChanged: !(state.forChanged)));
      }
    } on FirebaseAuthException catch (error) {
      String errorMessage = _determineError(error);
      if (errorMessage == 'Такой пользователь уже зарегистрирован') {
        await authService.signInWithEmailAndPassword(
            email: event.email, password: event.password);
        User? firebaseUser = FirebaseAuth.instance.currentUser;
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await firestore.collection('users').doc(firebaseUser!.uid).get();
        Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
        ProfileUser profileUser = ProfileUser.fromMap(userData);
        //если пользователь зареган
        if (profileUser.name != '') {
          emit(state.copyWith(
              message: errorMessage,
              authStatus: AuthStatus.failure,
              user: profileUser));
        } else {
          emit(state.copyWith(
              message: 'edit',
              authStatus: AuthStatus.success,
              user: profileUser));
        }
      } else {
        emit(state.copyWith(
            message: errorMessage,
            authStatus: AuthStatus.failure,
            forChanged: !(state.forChanged)));
      }
    }
  }

  Future<void> _loginButtonPressedEvent(
    LoginButtonPressedEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(state.copyWith(authStatus: AuthStatus.loading));
      await authService.signInWithEmailAndPassword(
          email: event.email, password: event.password);

      User firebaseUser = FirebaseAuth.instance.currentUser!;
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection('users').doc(firebaseUser.uid).get();
      Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
      ProfileUser profileUser = ProfileUser.fromMap(userData);
      if (profileUser.name == '') {
        emit(state.copyWith(
            message: 'Прежде чем войти в аккаунт, завершите регистрацию',
            authStatus: AuthStatus.failure,
            forChanged: !(state.forChanged)));
      } else {
        emit(state.copyWith(
            message: 'login',
            authStatus: AuthStatus.success,
            user: profileUser));
      }
    } on FirebaseAuthException catch (error) {
      String errorMessage = _determineError(error);
      emit(state.copyWith(
          message: errorMessage,
          authStatus: AuthStatus.failure,
          forChanged: !(state.forChanged)));
    }
  }

  Future<void> _updateNameUserEvent(
    UpdateNameUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection('users').doc(event.uid).get();
      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
        userData['name'] = event.newName;

        await FirebaseFirestore.instance
            .collection('users')
            .doc(event.uid)
            .update(userData);
        emit(state.copyWith(
            message: 'Новое имя сохранено',
            forChanged: !(state.forChanged),
            user: state.user!.copyWith(name: event.newName)));
      }
    } catch (e) {
      emit(state.copyWith(
          message: 'Не удалось: $e', forChanged: !(state.forChanged)));
    }
  }

  Future<void> _completeRegistration(
      CompleteRegistration event, Emitter<AuthState> emit) async {
    emit(state.copyWith(completeStatus: AuthStatus.loading));
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection('users').doc(state.user!.uid).get();
      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
        userData['name'] = event.name;

        FirebaseFirestore.instance
            .collection('users')
            .doc(state.user!.uid)
            .update(userData);
        if (event.avatar == null) {
          emit(state.copyWith(
              message: 'Регистрация пройдена',
              forChanged: !(state.forChanged),
              user: state.user!.copyWith(name: event.name),
              completeStatus: AuthStatus.success));
        } else {
          Reference storageReference = storage
              .ref()
              .child('users')
              .child(state.user!.uid)
              .child('avatar')
              .child(state.user!.uid);
          TaskSnapshot uploadTask =
              await storageReference.putFile(event.avatar!);

          if (uploadTask.state == TaskState.success) {
            String downloadUrl = await storageReference.getDownloadURL();

            try {
              DocumentSnapshot<Map<String, dynamic>> snapshot = await firestore
                  .collection('users')
                  .doc(state.user!.uid)
                  .get();
              if (snapshot.exists) {
                Map<String, dynamic> userData =
                    snapshot.data() as Map<String, dynamic>;
                userData['avatarUrl'] = downloadUrl;

                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(state.user!.uid)
                    .update(userData);
                emit(state.copyWith(
                    message: 'Регистрация пройдена',
                    forChanged: !(state.forChanged),
                    user: state.user!
                        .copyWith(name: event.name, avatarUrl: downloadUrl),
                    //avatarStatus: AuthStatus.success,
                    completeStatus: AuthStatus.success));
              }
            } catch (e) {
              emit(state.copyWith(
                  message: 'Регистрация пройдена',
                  forChanged: !(state.forChanged),
                  user: state.user!.copyWith(name: event.name, avatarUrl: ''),
                  completeStatus: AuthStatus.success));
            }
          } else {
            emit(state.copyWith(
                message: 'Регистрация пройдена',
                forChanged: !(state.forChanged),
                user: state.user!.copyWith(name: event.name, avatarUrl: ''),
                completeStatus: AuthStatus.success));
          }
        }
      }
    } catch (e) {
      emit(state.copyWith(
          message: 'Ошибка регистрации: $e',
          forChanged: !(state.forChanged),
          completeStatus: AuthStatus.failure));
    }
  }

  String _determineError(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-email':
        return 'Неверный e-mail';
      case 'user-disabled':
        return 'Пользователь отключен';
      case 'user-not-found':
        return 'Пользователь не найден';
      case 'wrong-password':
        return 'неправильный пароль';
      case 'email-already-in-use':
      case 'account-exists-with-different-credential':
        return 'Такой пользователь уже зарегистрирован';
      case 'invalid-credential':
        return 'недопустимые учетные данные';
      case 'operation-not-allowed':
        return 'операция не разрешена';
      case 'weak-password':
        return 'Пароль ненадежен';
      case 'network-request-failed':
        return 'Ошибка интернет-соединения';
      case 'ERROR_MISSING_GOOGLE_AUTH_TOKEN':
      default:
        return 'Ошибка Google авторизации';
    }
  }
}
