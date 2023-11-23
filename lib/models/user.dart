import 'package:equatable/equatable.dart';

class ProfileUser extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String avatarUrl;

  const ProfileUser(
      {this.uid = '', this.name = '', this.email = '', this.avatarUrl = ''});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
    };
  }

  factory ProfileUser.fromMap(Map<String, dynamic> map) {
    return ProfileUser(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      avatarUrl: map['avatarUrl'],
    );
  }

  ProfileUser copyWith(
      {String? uid, String? name, String? email, String? avatarUrl}) {
    return ProfileUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: uid ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  @override
  List<Object?> get props => [uid, name, email, avatarUrl];
}
