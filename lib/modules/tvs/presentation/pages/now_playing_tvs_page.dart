import 'package:movie_dicoding_app/common/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/bloc/list/tv_list_bloc.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';

class NowPlayingTvsPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-tv';

  const NowPlayingTvsPage({super.key});

  @override
  State<NowPlayingTvsPage> createState() => _NowPlayingTvsPageState();
}

class _NowPlayingTvsPageState extends State<NowPlayingTvsPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvListBloc>().add(FetchNowPlayingTvs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Now Playing Tvs')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvListBloc, TvListState>(
          builder: (context, state) {
            if (state.nowPlayingState == RequestState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.nowPlayingState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.nowPlayingTvs[index];
                  return TvCard(tv);
                },
                itemCount: state.nowPlayingTvs.length,
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
