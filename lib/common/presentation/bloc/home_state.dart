part of 'home_bloc.dart';

class HomeState extends Equatable {

  final String title;
  final Widget activePage;

  const HomeState({
    this.title = 'MOVIES', 
    this.activePage = const HomeMoviePage(),
  });

  HomeState copyWith({String? title, Widget? activePage}) {
    return HomeState(
      title: title ?? this.title,
      activePage: activePage ?? this.activePage,
    );
  }

  @override
  List<Object> get props => [title, activePage];
}
