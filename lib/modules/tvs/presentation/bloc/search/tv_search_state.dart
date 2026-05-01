part of 'tv_search_bloc.dart';

class TvSearchState extends Equatable {
  final RequestState state;
  final List<Tv> searchResult;
  final String message;

  const TvSearchState({
    this.state = RequestState.Empty,
    this.searchResult = const [],
    this.message = '',
  });

  TvSearchState copyWith({RequestState? state, List<Tv>? searchResult, String? message}) {
    return TvSearchState(
      state: state ?? this.state,
      searchResult: searchResult ?? this.searchResult,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [state, searchResult, message];
}
