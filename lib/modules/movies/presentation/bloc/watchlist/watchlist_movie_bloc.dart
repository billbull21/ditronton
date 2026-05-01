import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/state_enum.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_watchlist_movies.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMovieBloc({required this.getWatchlistMovies}) : super(const WatchlistMovieState()) {
    on<FetchWatchlistMovies>(_onFetchWatchlistMovies);
  }

  Future<void> _onFetchWatchlistMovies(
    FetchWatchlistMovies event,
    Emitter<WatchlistMovieState> emit,
  ) async {
    emit(state.copyWith(watchlistState: RequestState.Loading));

    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(watchlistState: RequestState.Error, message: failure.message));
      },
      (moviesData) {
        emit(
          state.copyWith(
            watchlistState: RequestState.Loaded,
            watchlistMovies: moviesData,
            message: '',
          ),
        );
      },
    );
  }
}
