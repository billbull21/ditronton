import 'package:movie_dicoding_app/modules/movies/data/models/movie_detail_model.dart';
import 'package:movie_dicoding_app/modules/movies/data/models/movie_model.dart';
import 'package:movie_dicoding_app/modules/movies/data/models/movie_response.dart';
import 'package:movie_dicoding_app/common/exception.dart';

import '../../../../common/network/dio_client.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<MovieDetailResponse> getMovieDetail(int id);
  Future<List<MovieModel>> getMovieRecommendations(int id);
  Future<List<MovieModel>> searchMovies(String query);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final DioClient client;

  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response =
        await client.get('/movie/now_playing');

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(response.data).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailResponse> getMovieDetail(int id) async {
    final response =
        await client.get('/movie/$id');

    if (response.statusCode == 200) {
      return MovieDetailResponse.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getMovieRecommendations(int id) async {
    final response = await client.get('/movie/$id/recommendations');

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(response.data).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response =
        await client.get('/movie/popular');

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(response.data).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final response =
        await client.get('/movie/top_rated');

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(response.data).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await client.get('/search/movie', queryParameters: {'query': query});

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(response.data).movieList;
    } else {
      throw ServerException();
    }
  }
}
