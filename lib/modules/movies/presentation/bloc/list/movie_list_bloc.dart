import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/state_enum.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_now_playing_movies.dart';
import '../../../domain/usecases/get_popular_movies.dart';
import '../../../domain/usecases/get_top_rated_movies.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MovieListBloc({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  }) : super(MovieListState()) {
    on<FetchNowPlayingMovies>(onFetchNowPlayingMovies);
    on<FetchPopularMovies>(onFetchPopularMovies);
    on<FetchTopRatedMovies>(onFetchTopRatedMovies);
  }

  Future<void> onFetchNowPlayingMovies(
    FetchNowPlayingMovies event,
    Emitter<MovieListState> emit,
  ) async {
    try {
      emit(state.copyWith(nowPlayingState: RequestState.Loading));
      final result = await getNowPlayingMovies.execute();
      result.fold(
        (failure) {
          emit(state.copyWith(nowPlayingState: RequestState.Error, message: failure.message));
        },
        (moviesData) {
          emit(state.copyWith(nowPlayingState: RequestState.Loaded, nowPlayingMovies: moviesData));
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          nowPlayingState: RequestState.Error,
          message: "Failed to Fetch Now Playing Movies",
        ),
      );
    }
  }

  Future<void> onFetchPopularMovies(FetchPopularMovies event, Emitter<MovieListState> emit) async {
    try {
      emit(state.copyWith(popularMoviesState: RequestState.Loading));
      final result = await getPopularMovies.execute();
      result.fold(
        (failure) {
          emit(state.copyWith(popularMoviesState: RequestState.Error, message: failure.message));
        },
        (moviesData) {
          emit(state.copyWith(popularMoviesState: RequestState.Loaded, popularMovies: moviesData));
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          popularMoviesState: RequestState.Error,
          message: "Failed to Fetch Popular Movies",
        ),
      );
    }
  }

  Future<void> onFetchTopRatedMovies(
    FetchTopRatedMovies event,
    Emitter<MovieListState> emit,
  ) async {
    try {
      emit(state.copyWith(topRatedMoviesState: RequestState.Loading));
      final result = await getTopRatedMovies.execute();
      result.fold(
        (failure) {
          emit(state.copyWith(topRatedMoviesState: RequestState.Error, message: failure.message));
        },
        (moviesData) {
          emit(
            state.copyWith(topRatedMoviesState: RequestState.Loaded, topRatedMovies: moviesData),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          topRatedMoviesState: RequestState.Error,
          message: "Failed to Fetch Top Rated Movies",
        ),
      );
    }
  }
}
