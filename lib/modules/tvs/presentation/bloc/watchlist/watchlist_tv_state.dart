part of 'watchlist_tv_bloc.dart';

class WatchlistTvState extends Equatable {
  final List<Tv> watchlistTvs;
  final RequestState watchlistState;
  final String message;

  const WatchlistTvState({
    this.watchlistTvs = const [],
    this.watchlistState = RequestState.Empty,
    this.message = '',
  });

  WatchlistTvState copyWith({
    List<Tv>? watchlistTvs,
    RequestState? watchlistState,
    String? message,
  }) {
    return WatchlistTvState(
      watchlistTvs: watchlistTvs ?? this.watchlistTvs,
      watchlistState: watchlistState ?? this.watchlistState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [watchlistTvs, watchlistState, message];
}
