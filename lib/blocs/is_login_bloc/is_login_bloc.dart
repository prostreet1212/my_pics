import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'is_login_event.dart';

part 'is_login_state.dart';

class IsLoginBloc extends Bloc<IsLoginChangeEvent, IsLoginState> {
  IsLoginBloc() : super(const IsLoginState(isLogin: true)) {
    on<IsLoginChangeEvent>((event, emit) {
      emit(state.copyWith(!state.isLogin));
    });
  }
}
