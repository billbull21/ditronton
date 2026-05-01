import 'package:movie_dicoding_app/common/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/bloc/list/tv_list_bloc.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';

class PopularTvsPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';

  const PopularTvsPage({super.key});

  @override
  State<PopularTvsPage> createState() => _PopularTvsPageState();
}

class _PopularTvsPageState extends State<PopularTvsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TvListBloc>().add(FetchPopularTvs()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Popular Tvs')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvListBloc, TvListState>(
          builder: (context, state) {
            if (state.popularTvsState == RequestState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.popularTvsState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.popularTvs[index];
                  return TvCard(tv);
                },
                itemCount: state.popularTvs.length,
              );
            } else {
              return Center(key: Key('error_message'), child: Text(state.message));
            }
          },
        ),
      ),
    );
  }
}
