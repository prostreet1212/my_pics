import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../../../blocs/newpost_bloc/newpost_bloc.dart';

class AddPostButton extends StatelessWidget {
  const AddPostButton({Key? key, required this.newPostState}) : super(key: key);

  final NewPostState newPostState;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: newPostState.postStatus == PostStatus.enable
            ? const LinearGradient(
                colors: [Color.fromARGB(255, 59, 67, 180), Colors.lightBlue])
            : null,
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          disabledForegroundColor: Colors.white,
          disabledBackgroundColor: Colors.black26,
          minimumSize: const Size.fromHeight(50),
          backgroundColor: newPostState.postStatus == PostStatus.enable
              ? Colors.transparent
              : Colors.blue,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: newPostState.postStatus == PostStatus.enable ||
                newPostState.postStatus == PostStatus.failure
            ? () {
                FocusScope.of(context).unfocus();
                BlocProvider.of<NewPostBloc>(context).add(AddPostEvent(
                    postImage:
                        BlocProvider.of<NewPostBloc>(context).state.postFile,
                    postText: newPostState.postText));
              }
            : newPostState.postStatus == PostStatus.tryagain
                ? () {
                    BlocProvider.of<NewPostBloc>(context)
                        .add(ChangeStatusEvent(postStatus: PostStatus.disable));
                  }
                : null,
        icon: newPostState.postStatus == PostStatus.enable ||
                newPostState.postStatus == PostStatus.failure
            ? Image.asset(
                'assets/images/lightning.png',
                scale: 1.7,
              )
            : newPostState.postStatus == PostStatus.tryagain
                ? Image.asset(
                    'assets/images/add_again.png',
                    scale: 1.7,
                  )
                : const SizedBox(),
        label: newPostState.postStatus == PostStatus.loading
            ? SpinKitThreeInOut(
                size: 30,
                itemBuilder: (context, index) {
                  return const DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.blueAccent, shape: BoxShape.circle),
                  );
                },
              )
            : Text(
                newPostState.postStatus != PostStatus.tryagain
                    ? 'Опубликовать'
                    : 'Сделать ещё публикацию',
                style: const TextStyle(fontSize: 18),
              ),
      ),
    );
  }
}
