import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/event_transformer.dart';
import '../../../../../common/state_enum.dart';
import '../../../domain/entities/tv.dart';
import '../../../domain/usecases/search_tvs.dart';

part 'tv_search_event.dart';
part 'tv_search_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTvs searchTvs;

  TvSearchBloc({required this.searchTvs}) : super(const TvSearchState()) {
    on<FetchTvSearch>(_onFetchTvSearch, transformer: debounce(const Duration(milliseconds: 500)));
  }

  Future<void> _onFetchTvSearch(FetchTvSearch event, Emitter<TvSearchState> emit) async {
    emit(state.copyWith(state: RequestState.Loading));

    final result = await searchTvs.execute(event.query);
    result.fold(
      (failure) {
        emit(state.copyWith(state: RequestState.Error, message: failure.message));
      },
      (data) {
        emit(state.copyWith(state: RequestState.Loaded, searchResult: data, message: ''));
      },
    );
  }
}
