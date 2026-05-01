import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../modules/movies/presentation/pages/home_movie_page.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<ChangePageEvent>(_onChangePage);
  }

  Future<void> _onChangePage(ChangePageEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(title: event.title, activePage: event.page));
  }
}