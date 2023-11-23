import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../blocs/newpost_bloc/newpost_bloc.dart';

class AddPostImage extends StatelessWidget {
  const AddPostImage({Key? key, required this.newPostState}) : super(key: key);

  final NewPostState newPostState;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(20, 0, 0, 0),
        borderRadius: BorderRadius.circular(10),
      ),
      width: MediaQuery.of(context).size.width,
      height: 180,
      child: InkResponse(
        containedInkWell: true,
        highlightShape: BoxShape.circle,
        onTap: newPostState.postStatus == PostStatus.loading ||
                newPostState.postStatus == PostStatus.tryagain
            ? null
            : () {
                BlocProvider.of<NewPostBloc>(context)
                    .add(GetPostImageFromMemoryEvent());
              },
        child: newPostState.postFile == null &&
                newPostState.postStatus == PostStatus.disable
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/add_image.png',
                    scale: 1.5,
                  ),
                  const Text(
                    'Выбрать фото',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  const SizedBox(height: 10)
                ],
              )
            : newPostState.postStatus == PostStatus.tryagain
                ? Image.asset(
                    'assets/images/try_again_image.png',
                    scale: 1.5,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      newPostState.postFile!,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
      ),
    );
  }
}
