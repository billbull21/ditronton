import 'package:movie_dicoding_app/common/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/bloc/list/tv_list_bloc.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';

class TopRatedTvsPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  const TopRatedTvsPage({super.key});

  @override
  State<TopRatedTvsPage> createState() => _TopRatedTvsPageState();
}

class _TopRatedTvsPageState extends State<TopRatedTvsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TvListBloc>().add(FetchTopRatedTvs()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Top Rated TV Shows')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvListBloc, TvListState>(
          builder: (context, state) {
            if (state.topRatedTvsState == RequestState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.topRatedTvsState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.topRatedTvs[index];
                  return TvCard(tv);
                },
                itemCount: state.topRatedTvs.length,
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
