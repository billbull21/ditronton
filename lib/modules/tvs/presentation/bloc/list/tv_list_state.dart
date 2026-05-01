part of 'tv_list_bloc.dart';

class TvListState extends Equatable {
  final List<Tv> nowPlayingTvs;
  final RequestState nowPlayingState;
  final List<Tv> popularTvs;
  final RequestState popularTvsState;
  final List<Tv> topRatedTvs;
  final RequestState topRatedTvsState;
  final String message;

  const TvListState({
    this.nowPlayingTvs = const [],
    this.nowPlayingState = RequestState.Empty,
    this.popularTvs = const [],
    this.popularTvsState = RequestState.Empty,
    this.topRatedTvs = const [],
    this.topRatedTvsState = RequestState.Empty,
    this.message = '',
  });

  TvListState copyWith({
    List<Tv>? nowPlayingTvs,
    RequestState? nowPlayingState,
    List<Tv>? popularTvs,
    RequestState? popularTvsState,
    List<Tv>? topRatedTvs,
    RequestState? topRatedTvsState,
    String? message,
  }) {
    return TvListState(
      nowPlayingTvs: nowPlayingTvs ?? this.nowPlayingTvs,
      nowPlayingState: nowPlayingState ?? this.nowPlayingState,
      popularTvs: popularTvs ?? this.popularTvs,
      popularTvsState: popularTvsState ?? this.popularTvsState,
      topRatedTvs: topRatedTvs ?? this.topRatedTvs,
      topRatedTvsState: topRatedTvsState ?? this.topRatedTvsState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    nowPlayingTvs,
    nowPlayingState,
    popularTvs,
    popularTvsState,
    topRatedTvs,
    topRatedTvsState,
    message,
  ];
}
