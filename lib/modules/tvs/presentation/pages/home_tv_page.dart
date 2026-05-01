import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_dicoding_app/common/constants.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/entities/tv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/bloc/list/tv_list_bloc.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/pages/tv_detail_page.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/pages/popular_tvs_page.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/pages/top_rated_tvs_page.dart';
import 'package:movie_dicoding_app/common/state_enum.dart';
import 'package:flutter/material.dart';

import 'now_playing_tvs_page.dart';

class HomeTvPage extends StatefulWidget {
  const HomeTvPage({super.key});

  @override
  State<HomeTvPage> createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvListBloc>()
      ..add(FetchNowPlayingTvs())
      ..add(FetchPopularTvs())
      ..add(FetchTopRatedTvs());
  }

  @override
  Widget build(BuildContext context) {
    // [@atention] this widget needs parent that contains scaffold to show.
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSubHeading(
              title: 'Airing Today',
              onTap: () => Navigator.pushNamed(context, NowPlayingTvsPage.ROUTE_NAME),
            ),
            BlocBuilder<TvListBloc, TvListState>(
              builder: (context, state) {
                final nowPlayingState = state.nowPlayingState;
                if (nowPlayingState == RequestState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (nowPlayingState == RequestState.Loaded) {
                  return MovieList(state.nowPlayingTvs);
                } else {
                  return Text('Failed');
                }
              },
            ),
            _buildSubHeading(
              title: 'Popular',
              onTap: () => Navigator.pushNamed(context, PopularTvsPage.ROUTE_NAME),
            ),
            BlocBuilder<TvListBloc, TvListState>(
              builder: (context, state) {
                final popularTvsState = state.popularTvsState;
                if (popularTvsState == RequestState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (popularTvsState == RequestState.Loaded) {
                  return MovieList(state.popularTvs);
                } else {
                  return Text('Failed');
                }
              },
            ),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () => Navigator.pushNamed(context, TopRatedTvsPage.ROUTE_NAME),
            ),
            BlocBuilder<TvListBloc, TvListState>(
              builder: (context, state) {
                final topRatedTvsState = state.topRatedTvsState;
                if (topRatedTvsState == RequestState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (topRatedTvsState == RequestState.Loaded) {
                  return MovieList(state.topRatedTvs);
                } else {
                  return Text('Failed');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: kHeading6),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [Text('See More'), Icon(Icons.arrow_forward_ios)]),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Tv> movies;

  MovieList(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, TvDetailPage.ROUTE_NAME, arguments: movie.id);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
