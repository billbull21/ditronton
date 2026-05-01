import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/state_enum.dart';
import '../../../domain/entities/tv.dart';
import '../../../domain/usecases/get_watchlist_tvs.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTvs getWatchlistTvs;

  WatchlistTvBloc({required this.getWatchlistTvs}) : super(const WatchlistTvState()) {
    on<FetchWatchlistTvs>(_onFetchWatchlistTvs);
  }

  Future<void> _onFetchWatchlistTvs(FetchWatchlistTvs event, Emitter<WatchlistTvState> emit) async {
    emit(state.copyWith(watchlistState: RequestState.Loading));

    final result = await getWatchlistTvs.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(watchlistState: RequestState.Error, message: failure.message));
      },
      (tvsData) {
        emit(
          state.copyWith(watchlistState: RequestState.Loaded, watchlistTvs: tvsData, message: ''),
        );
      },
    );
  }
}
