import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/state_enum.dart';
import '../../../domain/entities/tv.dart';
import '../../../domain/entities/tv_detail.dart';
import '../../../domain/usecases/get_tv_detail.dart';
import '../../../domain/usecases/get_tv_recommendations.dart';
import '../../../domain/usecases/get_watchlist_status.dart';
import '../../../domain/usecases/remove_watchlist.dart';
import '../../../domain/usecases/save_watchlist.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  TvDetailBloc({
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(const TvDetailState()) {
    on<FetchTvDetail>(_onFetchTvDetail);
    on<LoadTvWatchlistStatus>(_onLoadTvWatchlistStatus);
    on<AddTvToWatchlist>(_onAddTvToWatchlist);
    on<RemoveTvFromWatchlist>(_onRemoveTvFromWatchlist);
    on<ResetMessage>(_onResetMessage);
  }

  Future<void> _onFetchTvDetail(FetchTvDetail event, Emitter<TvDetailState> emit) async {
    emit(state.copyWith(tvState: RequestState.Loading));

    final detailResult = await getTvDetail.execute(event.id);
    final recommendationResult = await getTvRecommendations.execute(event.id);

    await detailResult.fold(
      (failure) async {
        emit(state.copyWith(tvState: RequestState.Error, message: failure.message));
      },
      (tv) async {
        emit(state.copyWith(tv: tv, recommendationState: RequestState.Loading));

        recommendationResult.fold(
          (failure) {
            emit(state.copyWith(recommendationState: RequestState.Error, message: failure.message));
          },
          (tvs) {
            emit(state.copyWith(recommendationState: RequestState.Loaded, tvRecommendations: tvs));
          },
        );

        emit(state.copyWith(tvState: RequestState.Loaded));
      },
    );
  }

  Future<void> _onLoadTvWatchlistStatus(
    LoadTvWatchlistStatus event,
    Emitter<TvDetailState> emit,
  ) async {
    final result = await getWatchListStatus.execute(event.id);
    emit(state.copyWith(isAddedToWatchlist: result));
  }

  Future<void> _onAddTvToWatchlist(AddTvToWatchlist event, Emitter<TvDetailState> emit) async {
    final result = await saveWatchlist.execute(event.tv);

    final message = result.fold((failure) => failure.message, (successMessage) => successMessage);

    final watchlistStatus = await getWatchListStatus.execute(event.tv.id ?? 0);
    emit(state.copyWith(watchlistMessage: message, isAddedToWatchlist: watchlistStatus));
  }

  Future<void> _onRemoveTvFromWatchlist(
    RemoveTvFromWatchlist event,
    Emitter<TvDetailState> emit,
  ) async {
    final result = await removeWatchlist.execute(event.tv);

    final message = result.fold((failure) => failure.message, (successMessage) => successMessage);

    final watchlistStatus = await getWatchListStatus.execute(event.tv.id ?? 0);
    emit(state.copyWith(watchlistMessage: message, isAddedToWatchlist: watchlistStatus));
  }

  Future<void> _onResetMessage(ResetMessage event, Emitter<TvDetailState> emit) async {
    emit(state.copyWith(watchlistMessage: ''));
  }
}
