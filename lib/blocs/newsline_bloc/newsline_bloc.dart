import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pics/models/user.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../../../models/post.dart';
import '../../../../../../../utils/utils.dart';

part 'newsline_event.dart';

part 'newsline_state.dart';

class NewslineBloc extends Bloc<NewslineEvent, NewslineState> {
  NewslineBloc() : super(const NewslineState()) {
    on<GetAllPostsEvent>(_getAllPostsEvent);
    on<ChangeLikeEvent>(_changeLikeEvent);
    on<ChangeSelectedPostEvent>(_changeSelectedPostEvent);
  }

  void _changeSelectedPostEvent(
      ChangeSelectedPostEvent event, Emitter<NewslineState> emit) {
    emit(state.copyWith(selectedPost: event.post));
  }

  Future _getAllPostsEvent(
      GetAllPostsEvent event, Emitter<NewslineState> emit) async {
    emit(state.copyWith(allPostsStatus: AllPostsStatus.loading));
    await emit.forEach(combinePostsStream, onData: (s) {
      return state.copyWith(
          allPosts: s, allPostsStatus: AllPostsStatus.success);
    });
  }
}

void _changeLikeEvent(
    ChangeLikeEvent event, Emitter<NewslineState> emit) async {
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
/*
Stream<List<Post>> selectedPostStream({required String postId}) {
  return FirebaseFirestore.instance
      .collection('posts')
      .doc(postId)
      .snapshots()
      .map((convert) {
    Iterable<Stream<Post>> t = [convert].map((f) {
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
        return event.docs.map((e) => ProfileUser.fromMap(e.data())).toList();
      });
      Stream<Post> a = Rx.combineLatest3(
          posts,
          user,
          likes,
          (posts, user, likes) => posts.copyWith(
              name: user.name,
              avatar: user.avatarUrl,
              timeAgo: getTimeAgo(posts.datePublish!.toDate()),
              likeList: likes));
      return a;
    });

    return t;
  }).switchMap((observables) {
    return observables.isNotEmpty
        ? Rx.combineLatestList(observables)
        : Stream.value([]);
  });
}*/

Stream<List<Post>> combinePostsStream = FirebaseFirestore.instance
    .collection('posts')
    .orderBy('datePublish', descending: true)
    .snapshots()
    .map((convert) {
  Iterable<Stream<Post>> b = convert.docs.map((f) {
    Stream<Post> posts = Stream.value(f).map<Post>((document) {
      return Post.fromJson(document.data());
    });

    Stream<ProfileUser> user = FirebaseFirestore.instance
        .collection("users")
        .doc(f.data()['uuid'])
        .snapshots()
        .map<ProfileUser>((document) {
      return ProfileUser.fromMap(document.data()!);
    });

    Stream<List<ProfileUser>> likes = FirebaseFirestore.instance
        .collection("users")
        .where('uid',
            whereIn: (List<String>.from(f.data()['likes']).isEmpty)
                ? ['emptyList1111111111111']
                : List<String>.from(f.data()['likes']))
        .snapshots()
        .map((event) {
      return event.docs.map((e) => ProfileUser.fromMap(e.data())).toList();
    });

    Stream<Post> a = Rx.combineLatest3(
        posts,
        user,
        likes,
        (posts, user, likes) => posts.copyWith(
            name: user.name,
            avatar: user.avatarUrl,
            timeAgo: getTimeAgo(posts.datePublish!.toDate()),
            likeList: likes));
    return a;
  });
  return b;
}).switchMap((observables) {
  return observables.isNotEmpty
      ? Rx.combineLatestList(observables)
      : Stream.value([]);
});
