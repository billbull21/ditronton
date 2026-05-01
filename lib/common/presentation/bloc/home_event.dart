part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class ChangePageEvent extends HomeEvent {
  final String title;
  final Widget page;

  const ChangePageEvent({
    required this.title,
    required this.page
  });

  @override
  List<Object> get props => [title, page];
}