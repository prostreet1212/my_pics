import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../blocs/newpost_bloc/newpost_bloc.dart';

class NamePostTextField extends StatelessWidget {
  const NamePostTextField({Key? key, required this.textState})
      : super(key: key);
  final NewPostState textState;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: textState.postStatus == PostStatus.loading ? false : true,
      cursorColor: const Color.fromARGB(255, 170, 193, 238),
      decoration: const InputDecoration(
        labelText: 'Описание',
        labelStyle:
            TextStyle(color: Color.fromARGB(255, 170, 193, 238), fontSize: 20),
        contentPadding: EdgeInsets.all(0.0),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 170, 193, 238)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 170, 193, 238),
          ),
        ),
      ),
      onChanged: (String newValue) {
        BlocProvider.of<NewPostBloc>(context)
            .add(ChangePostTextEvent(newText: newValue));
      },
    );
  }
}
