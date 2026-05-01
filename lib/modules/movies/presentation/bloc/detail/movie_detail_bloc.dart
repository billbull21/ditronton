import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/state_enum.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/entities/movie_detail.dart';
import '../../../domain/usecases/get_movie_detail.dart';
import '../../../domain/usecases/get_movie_recommendations.dart';
import '../../../domain/usecases/get_watchlist_status.dart';
import '../../../domain/usecases/remove_watchlist.dart';
import '../../../domain/usecases/save_watchlist.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(const MovieDetailState()) {
    on<FetchMovieDetail>(_onFetchMovieDetail);
    on<LoadMovieWatchlistStatus>(_onLoadMovieWatchlistStatus);
    on<AddMovieToWatchlist>(_onAddMovieToWatchlist);
    on<RemoveMovieFromWatchlist>(_onRemoveMovieFromWatchlist);
    on<ResetMessage>(_onResetMessage);
  }

  Future<void> _onFetchMovieDetail(FetchMovieDetail event, Emitter<MovieDetailState> emit) async {
    emit(state.copyWith(movieState: RequestState.Loading));

    final detailResult = await getMovieDetail.execute(event.id);
    final recommendationResult = await getMovieRecommendations.execute(event.id);

    await detailResult.fold(
      (failure) async {
        emit(state.copyWith(movieState: RequestState.Error, message: failure.message));
      },
      (movie) async {
        emit(state.copyWith(movie: movie, recommendationState: RequestState.Loading));

        recommendationResult.fold(
          (failure) {
            emit(state.copyWith(recommendationState: RequestState.Error, message: failure.message));
          },
          (movies) {
            emit(
              state.copyWith(
                recommendationState: RequestState.Loaded,
                movieRecommendations: movies,
              ),
            );
          },
        );

        emit(state.copyWith(movieState: RequestState.Loaded));
      },
    );
  }

  Future<void> _onLoadMovieWatchlistStatus(
    LoadMovieWatchlistStatus event,
    Emitter<MovieDetailState> emit,
  ) async {
    final result = await getWatchListStatus.execute(event.id);
    emit(state.copyWith(isAddedToWatchlist: result));
  }

  Future<void> _onAddMovieToWatchlist(
    AddMovieToWatchlist event,
    Emitter<MovieDetailState> emit,
  ) async {
    final result = await saveWatchlist.execute(event.movie);

    final message = result.fold((failure) => failure.message, (successMessage) => successMessage);

    final watchlistStatus = await getWatchListStatus.execute(event.movie.id);
    emit(state.copyWith(watchlistMessage: message, isAddedToWatchlist: watchlistStatus));
  }

  Future<void> _onRemoveMovieFromWatchlist(
    RemoveMovieFromWatchlist event,
    Emitter<MovieDetailState> emit,
  ) async {
    final result = await removeWatchlist.execute(event.movie);

    final message = result.fold((failure) => failure.message, (successMessage) => successMessage);

    final watchlistStatus = await getWatchListStatus.execute(event.movie.id);
    emit(state.copyWith(watchlistMessage: message, isAddedToWatchlist: watchlistStatus));
  }

  Future<void> _onResetMessage(
    ResetMessage event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(state.copyWith(watchlistMessage: ''));
  }
}
