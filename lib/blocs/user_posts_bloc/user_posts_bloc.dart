import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../../models/post.dart';
import '../../../../../../../models/user.dart';
import '../../../../../../../utils/utils.dart';

part 'user_posts_event.dart';

part 'user_posts_state.dart';

class UserPostsBloc extends Bloc<UserPostsEvent, UserPostsState> {
  UserPostsBloc() : super(const UserPostsState()) {
    on<GetUserPostsEvent>(_getUserPostsEvent);
  }

  void _getUserPostsEvent(
      GetUserPostsEvent event, Emitter<UserPostsState> emit) async {
    emit(state.copyWith(userPostsStatus: UserPostsStatus.loading));
    await emit.forEach(userPostsStream, onData: (s) {
      for (var post in s) {
        if (kDebugMode) {
          print(post.description);
        }
      }
      return state.copyWith(
          userPosts: s, userPostsStatus: UserPostsStatus.success);
    });
  }

  Stream<List<Post>> userPostsStream = FirebaseFirestore.instance
      .collection('posts')
      .orderBy('datePublish', descending: true)
      .where('uuid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
}
