part of 'tv_list_bloc.dart';

sealed class TvListEvent extends Equatable {
  const TvListEvent();

  @override
  List<Object?> get props => [];
}

class FetchNowPlayingTvs extends TvListEvent {}

class FetchPopularTvs extends TvListEvent {}

class FetchTopRatedTvs extends TvListEvent {}
