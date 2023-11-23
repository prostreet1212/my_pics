import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../../../models/post.dart';

class UserInfoPanel extends StatelessWidget {
  const UserInfoPanel({Key? key, required this.post}) : super(key: key);
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 26),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircularProfileAvatar(
            post.avatar,
            errorWidget: (context, url, error) => const Icon(Icons.error),
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
                            color: Colors.black12, shape: BoxShape.circle),
                      );
                    },
                  ));
            },
            radius: 20,
            backgroundColor: Colors.black26,
            borderColor: Colors.transparent,
            imageFit: BoxFit.fitHeight,
            cacheImage: true,
            showInitialTextAbovePicture: false,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            post.name,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(
                Icons.access_time_filled,
                color: Colors.black26,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                post.timeAgo,
                style: const TextStyle(color: Colors.black26),
              )
            ],
          ))
        ],
      ),
    );
  }
}
