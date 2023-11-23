part of 'nav_bar_bloc.dart';

class NavBarState extends Equatable {
  final int currentIndex;
  final String title;

  const NavBarState({required this.currentIndex, required this.title});

  NavBarState copyWith(int? currentIndex, String? title) {
    return NavBarState(
        currentIndex: currentIndex ?? this.currentIndex,
        title: title ?? this.title);
  }

  @override
  List<Object?> get props => [currentIndex, title];
}
