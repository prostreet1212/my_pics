import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../../../models/post.dart';

class LikeUserPanel extends StatelessWidget {
  const LikeUserPanel({Key? key, required this.post}) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 26, right: 26, top: 16, bottom: 6),
          child: Text(
            'Нравится пользователям:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18, right: 18),
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: post.likeList.length,
              itemBuilder: (context, index) {
                return Card(
                  color: const Color.fromARGB(255, 240, 240, 240),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: ListTile(
                    leading: CircularProfileAvatar(
                      post.likeList[index].avatarUrl,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      progressIndicatorBuilder: (context, s, progress) {
                        return Container(
                          color: Colors.transparent,
                          height: 10,
                          width: 10,
                          child: SpinKitRotatingCircle(
                            size: 40,
                            itemBuilder: (context, index) {
                              return const DecoratedBox(
                                decoration: BoxDecoration(
                                    color: Colors.black12,
                                    shape: BoxShape.circle),
                              );
                            },
                          ),
                        );
                      },
                      radius: 25,
                      backgroundColor: Colors.black26,
                      borderColor: Colors.transparent,
                      imageFit: BoxFit.fitHeight,
                      cacheImage: true,
                      showInitialTextAbovePicture: false,
                    ),
                    title: Text(
                      post.likeList[index].name,
                      style: const TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(post.likeList[index].email),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
