import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:my_pics/models/user.dart';

class Post extends Equatable {
  final String postId;
  final String uid;
  final Timestamp? datePublish;
  final String url;
  final String description;
  final String name;
  final String avatar;
  final String timeAgo;
  final List<String> likes;
  final List<ProfileUser> likeList;

  const Post(
      {this.postId = '',
      this.uid = '',
      this.datePublish,
      this.url = '',
      this.description = '',
      this.name = '',
      this.avatar = '',
      this.timeAgo = '',
      this.likes = const [],
      this.likeList = const []});

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'uuid': uid,
      'datePublish': datePublish,
      'url': url,
      'description': description,
      'likes': likes
      /*'name': name,
      'avatar': avatar,*/
    };
  }

  factory Post.fromJson(Map<String, dynamic> map) {
    return Post(
        postId: map['postId'],
        uid: map['uuid'],
        datePublish: map['datePublish'],
        url: map['url'],
        description: map['description'],
        name: map['name'] ?? '',
        avatar: map['avatar'] ?? '',
        likes: List<String>.from(map['likes'] ?? []));
  }

  Post copyWith(
      {String? postId,
      String? url,
      Timestamp? datePublish,
      String? description,
      String? name,
      String? avatar,
      String? timeAgo,
      List<String>? likes,
      List<ProfileUser>? likeList}) {
    return Post(
        postId: postId ?? this.postId,
        uid: uid,
        datePublish: datePublish ?? this.datePublish,
        url: url ?? this.url,
        description: description ?? this.description,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        timeAgo: timeAgo ?? this.timeAgo,
        likes: likes ?? this.likes,
        likeList: likeList ?? this.likeList);
  }

  @override
  List<Object?> get props => [
        postId,
        uid,
        datePublish,
        url,
        description,
        name,
        avatar,
        timeAgo,
        likes,
        likeList
      ];
}
