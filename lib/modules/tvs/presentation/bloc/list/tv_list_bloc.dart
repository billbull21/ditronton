import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/state_enum.dart';
import '../../../domain/entities/tv.dart';
import '../../../domain/usecases/get_now_playing_tvs.dart';
import '../../../domain/usecases/get_popular_tvs.dart';
import '../../../domain/usecases/get_top_rated_tvs.dart';

part 'tv_list_event.dart';
part 'tv_list_state.dart';

class TvListBloc extends Bloc<TvListEvent, TvListState> {
  final GetNowPlayingTvs getNowPlayingTvs;
  final GetPopularTvs getPopularTvs;
  final GetTopRatedTvs getTopRatedTvs;

  TvListBloc({
    required this.getNowPlayingTvs,
    required this.getPopularTvs,
    required this.getTopRatedTvs,
  }) : super(const TvListState()) {
    on<FetchNowPlayingTvs>(_onFetchNowPlayingTvs);
    on<FetchPopularTvs>(_onFetchPopularTvs);
    on<FetchTopRatedTvs>(_onFetchTopRatedTvs);
  }

  Future<void> _onFetchNowPlayingTvs(FetchNowPlayingTvs event, Emitter<TvListState> emit) async {
    emit(state.copyWith(nowPlayingState: RequestState.Loading));
    final result = await getNowPlayingTvs.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(nowPlayingState: RequestState.Error, message: failure.message));
      },
      (tvsData) {
        emit(state.copyWith(nowPlayingState: RequestState.Loaded, nowPlayingTvs: tvsData));
      },
    );
  }

  Future<void> _onFetchPopularTvs(FetchPopularTvs event, Emitter<TvListState> emit) async {
    emit(state.copyWith(popularTvsState: RequestState.Loading));
    final result = await getPopularTvs.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(popularTvsState: RequestState.Error, message: failure.message));
      },
      (tvsData) {
        emit(state.copyWith(popularTvsState: RequestState.Loaded, popularTvs: tvsData));
      },
    );
  }

  Future<void> _onFetchTopRatedTvs(FetchTopRatedTvs event, Emitter<TvListState> emit) async {
    emit(state.copyWith(topRatedTvsState: RequestState.Loading));
    final result = await getTopRatedTvs.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(topRatedTvsState: RequestState.Error, message: failure.message));
      },
      (tvsData) {
        emit(state.copyWith(topRatedTvsState: RequestState.Loaded, topRatedTvs: tvsData));
      },
    );
  }
}
