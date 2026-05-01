import 'package:movie_dicoding_app/common/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/bloc/list/movie_list_bloc.dart';
import 'package:movie_dicoding_app/modules/movies/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieListBloc>().add(FetchPopularMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Popular Movies')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieListBloc, MovieListState>(
          builder: (context, state) {
            if (state.popularMoviesState == RequestState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.popularMoviesState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.popularMovies[index];
                  return MovieCard(movie);
                },
                itemCount: state.popularMovies.length,
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
