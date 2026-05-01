import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_dicoding_app/common/constants.dart';
import 'package:movie_dicoding_app/modules/movies/domain/entities/movie.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/bloc/list/movie_list_bloc.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/pages/movie_detail_page.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/pages/popular_movies_page.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/pages/top_rated_movies_page.dart';
import 'package:movie_dicoding_app/common/state_enum.dart';
import 'package:flutter/material.dart';

import 'now_playing_movies_page.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({super.key});

  @override
  State<HomeMoviePage> createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieListBloc>()
      ..add(FetchNowPlayingMovies())
      ..add(FetchPopularMovies())
      ..add(FetchTopRatedMovies());
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
              title: 'Now Playing',
              onTap: () => Navigator.pushNamed(context, NowPlayingMoviesPage.ROUTE_NAME),
            ),
            BlocBuilder<MovieListBloc, MovieListState>(
              builder: (context, state) {
                final nowPlayingState = state.nowPlayingState;
                if (nowPlayingState == RequestState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (nowPlayingState == RequestState.Loaded) {
                  return MovieList(state.nowPlayingMovies);
                } else {
                  return Text('Failed');
                }
              },
            ),
            _buildSubHeading(
              title: 'Popular',
              onTap: () => Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
            ),
            BlocBuilder<MovieListBloc, MovieListState>(
              builder: (context, state) {
                final popularMoviesState = state.popularMoviesState;
                if (popularMoviesState == RequestState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (popularMoviesState == RequestState.Loaded) {
                  return MovieList(state.popularMovies);
                } else {
                  return Text('Failed');
                }
              },
            ),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () => Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
            ),
            BlocBuilder<MovieListBloc, MovieListState>(
              builder: (context, state) {
                final topRatedMoviesState = state.topRatedMoviesState;
                if (topRatedMoviesState == RequestState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (topRatedMoviesState == RequestState.Loaded) {
                  return MovieList(state.topRatedMovies);
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
  final List<Movie> movies;

  const MovieList(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, MovieDetailPage.ROUTE_NAME, arguments: movie.id);
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
