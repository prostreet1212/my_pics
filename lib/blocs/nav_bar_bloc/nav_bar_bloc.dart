import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'nav_bar_event.dart';

part 'nav_bar_state.dart';

class NavBarBloc extends Bloc<NavBarEvent, NavBarState> {
  List<String> titleList = ['Лента', 'Новый пост', 'Настройки профиля'];

  NavBarBloc()
      : super(const NavBarState(currentIndex: 0, title: 'Настройки профиля')) {
    on<NavBarEvent>(_navBarEvent);
  }

  void _navBarEvent(NavBarEvent event, Emitter<NavBarState> emit) {
    emit(NavBarState(
        currentIndex: event.index, title: titleList.elementAt(event.index)));
  }
}
