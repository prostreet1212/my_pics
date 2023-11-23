import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../../models/post.dart';
import '../../../../../../../models/user.dart';
import '../../../../../../../utils/utils.dart';

part 'post_detail_event.dart';

part 'post_detail_state.dart';

class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  Post post;

  PostDetailBloc(this.post) : super(PostDetailState(selectedPost: post)) {
    on<GetSelectedPostEvent>(_getSelectedPostEvent);
    on<ChangeLikeDetailPostEvent>(_changeLikeDetailPostEvent);
    on<DeletePostEvent>(_deletePostEvent);
  }

  void _deletePostEvent(
      DeletePostEvent event, Emitter<PostDetailState> emit) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('users')
        .child(state.selectedPost.uid)
        .child('posts')
        .child(state.selectedPost.postId);
    await storageReference.delete().then((value) async {
      try {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(state.selectedPost.postId)
            .delete()
            .then((value) {})
            .whenComplete(() {
          emit(state.copyWith(deleteStatus: DeleteStatus.complete));
        }).onError((error, stackTrace) {
          if (kDebugMode) {
            print('ошибка $error');
          }
        }).catchError((e) {
          if (kDebugMode) {
            print('ошибка $e');
          }
        });
      } catch (e) {
        if (kDebugMode) {
          print('ошибка $e');
        }
      }
    });
  }

  void _changeLikeDetailPostEvent(
      ChangeLikeDetailPostEvent event, Emitter<PostDetailState> emit) async {
    if (event.post.likes.contains(FirebaseAuth.instance.currentUser!.uid)) {
      Post post = event.post;
      List<String> likes = [...post.likes]
        ..remove(FirebaseAuth.instance.currentUser!.uid);
      post = post.copyWith(likes: likes);

      await FirebaseFirestore.instance
          .collection('posts')
          .doc(event.post.postId)
          .update(post.toJson())
          .then((value) {});
    } else {
      Post post = event.post;
      List<String> likes = [
        ...post.likes,
        FirebaseAuth.instance.currentUser!.uid
      ];
      post = post.copyWith(likes: likes);

      await FirebaseFirestore.instance
          .collection('posts')
          .doc(event.post.postId)
          .update(post.toJson())
          .then((value) {});
    }
  }

  void _getSelectedPostEvent(
      GetSelectedPostEvent event, Emitter<PostDetailState> emit) async {
    await emit.forEach(selectedPostStream(postId: state.selectedPost.postId),
        onData: (selectedPost) {
      StreamSubscription postSubscription =
          selectedPostStream(postId: state.selectedPost.postId)
              .listen((event) {});
      if (selectedPost.isNotEmpty) {
        return state.copyWith(selectedPost: selectedPost[0]);
      } else {
        postSubscription.cancel();
        return state.copyWith(selectedPost: const Post());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('onError');
      }
    });
  }

  Stream<List<Post>> selectedPostStream({required String postId}) {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .snapshots()
        .map((convert) {
      if (convert.exists) {
        Iterable<Stream<Post>> iterablePost = [convert].map((f) {
          Stream<Post> posts = Stream.value(f).map<Post>((document) {
            return Post.fromJson(document.data()!);
          });
          Stream<ProfileUser> user = FirebaseFirestore.instance
              .collection("users")
              .doc(f.data()!['uuid'])
              .snapshots()
              .map<ProfileUser>((document) {
            return ProfileUser.fromMap(document.data()!);
          });

          Stream<List<ProfileUser>> likes = FirebaseFirestore.instance
              .collection("users")
              .where('uid',
                  whereIn: (List<String>.from(f.data()!['likes']).isEmpty)
                      ? ['emptyList1111111111111']
                      : List<String>.from(f.data()!['likes']))
              .snapshots()
              .map((event) {
            return event.docs
                .map((e) => ProfileUser.fromMap(e.data()))
                .toList();
          });
          Stream<Post> streamPost = Rx.combineLatest3(
              posts,
              user,
              likes,
              (posts, user, likes) => posts.copyWith(
                  name: user.name,
                  avatar: user.avatarUrl,
                  timeAgo: getTimeAgo(posts.datePublish!.toDate()),
                  likeList: likes));
          return streamPost;
        });
        return iterablePost;
      } else {
        Iterable<Stream<Post>> emptyIterable = [].map((e) {
          Stream<Post> post = Stream.value(e);
          return post;
        });
        return emptyIterable;
      }
    }).switchMap((observables) {
      return observables.isNotEmpty
          ? Rx.combineLatestList(observables)
          : Stream.value([]);
    });
  }
}
