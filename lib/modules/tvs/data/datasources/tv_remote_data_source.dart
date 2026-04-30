import 'package:movie_dicoding_app/modules/tvs/data/models/tv_detail_model.dart';
import 'package:movie_dicoding_app/modules/tvs/data/models/tv_model.dart';
import 'package:movie_dicoding_app/modules/tvs/data/models/tv_response.dart';
import 'package:movie_dicoding_app/common/exception.dart';

import '../../../../common/network/dio_client.dart';

abstract class TvRemoteDataSource {
  Future<List<TvModel>> getNowPlayingTvs();
  Future<List<TvModel>> getPopularTvs();
  Future<List<TvModel>> getTopRatedTvs();
  Future<TvDetailResponse> getTvDetail(int id);
  Future<List<TvModel>> getTvRecommendations(int id);
  Future<List<TvModel>> searchTvs(String query);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final DioClient client;

  TvRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvModel>> getNowPlayingTvs() async {
    final response =
        await client.get('/tv/airing_today');

    if (response.statusCode == 200) {
      return TvResponse.fromJson(response.data).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvDetailResponse> getTvDetail(int id) async {
    final response =
        await client.get('/tv/$id');

    if (response.statusCode == 200) {
      return TvDetailResponse.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvRecommendations(int id) async {
    final response = await client
        .get('/tv/$id/recommendations');

    if (response.statusCode == 200) {
      return TvResponse.fromJson(response.data).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getPopularTvs() async {
    final response =
        await client.get('/tv/popular');

    if (response.statusCode == 200) {
      return TvResponse.fromJson(response.data).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTopRatedTvs() async {
    final response =
        await client.get('/tv/top_rated');

    if (response.statusCode == 200) {
      return TvResponse.fromJson(response.data).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> searchTvs(String query) async {
    final response = await client.get('/search/tv?query=$query');

    if (response.statusCode == 200) {
      return TvResponse.fromJson(response.data).tvList;
    } else {
      throw ServerException();
    }
  }
}
