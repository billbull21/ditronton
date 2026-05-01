import 'package:flutter/cupertino.dart';
import 'package:movie_dicoding_app/common/state_enum.dart';
import 'package:movie_dicoding_app/common/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/bloc/watchlist/watchlist_tv_bloc.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';

class WatchlistTvsPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';

  const WatchlistTvsPage({super.key});

  @override
  State<WatchlistTvsPage> createState() => _WatchlistTvsPageState();
}

class _WatchlistTvsPageState extends State<WatchlistTvsPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistTvBloc>().add(FetchWatchlistTvs());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistTvBloc>().add(FetchWatchlistTvs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Watchlist TV Shows')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
          builder: (context, state) {
            if (state.watchlistState == RequestState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.watchlistState == RequestState.Loaded) {
              if (state.watchlistTvs.isEmpty) {
                return Center(
                  key: Key('empty_message'),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(CupertinoIcons.cube_box, size: 64),
                      SizedBox(height: 8),
                      Text('No TV shows in watchlist'),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.watchlistTvs[index];
                  return TvCard(tv);
                },
                itemCount: state.watchlistTvs.length,
              );
            } else {
              return Center(key: Key('error_message'), child: Text(state.message));
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
