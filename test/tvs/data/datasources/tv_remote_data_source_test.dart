import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:movie_dicoding_app/modules/tvs/data/datasources/tv_remote_data_source.dart';
import 'package:movie_dicoding_app/modules/tvs/data/models/tv_detail_model.dart';
import 'package:movie_dicoding_app/modules/tvs/data/models/tv_response.dart';
import 'package:movie_dicoding_app/common/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../json_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

Response<dynamic> _dioResponse(dynamic data, int statusCode) {
  return Response(
    data: data,
    statusCode: statusCode,
    requestOptions: RequestOptions(path: ''),
  );
}

void main() {
  late TvRemoteDataSourceImpl dataSource;
  late MockDioClient mockDioClient;

  setUp(() {
    mockDioClient = MockDioClient();
    dataSource = TvRemoteDataSourceImpl(client: mockDioClient);
  });

  group('get Now Playing Tvs', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv_airing_today.json')))
        .tvList;

    test('should return list of Tv Model when the response code is 200',
        () async {
      // arrange
      when(mockDioClient.get('/tv/airing_today')).thenAnswer((_) async =>
          _dioResponse(
              json.decode(readJson('dummy_data/tv_airing_today.json')), 200));
      // act
      final result = await dataSource.getNowPlayingTvs();
      // assert
      expect(result, equals(tTvList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockDioClient.get('/tv/airing_today'))
          .thenAnswer((_) async => _dioResponse('Not Found', 404));
      // act
      final call = dataSource.getNowPlayingTvs();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Tvs', () {
    final tTvList =
        TvResponse.fromJson(json.decode(readJson('dummy_data/tv_popular.json')))
            .tvList;

    test('should return list of tvs when response is success (200)', () async {
      // arrange
      when(mockDioClient.get('/tv/popular')).thenAnswer((_) async =>
          _dioResponse(
              json.decode(readJson('dummy_data/tv_popular.json')), 200));
      // act
      final result = await dataSource.getPopularTvs();
      // assert
      expect(result, tTvList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockDioClient.get('/tv/popular'))
          .thenAnswer((_) async => _dioResponse('Not Found', 404));
      // act
      final call = dataSource.getPopularTvs();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Tvs', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv_top_rated.json')))
        .tvList;

    test('should return list of tvs when response code is 200', () async {
      // arrange
      when(mockDioClient.get('/tv/top_rated')).thenAnswer((_) async =>
          _dioResponse(
              json.decode(readJson('dummy_data/tv_top_rated.json')), 200));
      // act
      final result = await dataSource.getTopRatedTvs();
      // assert
      expect(result, tTvList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockDioClient.get('/tv/top_rated'))
          .thenAnswer((_) async => _dioResponse('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTvs();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv detail', () {
    final tId = 1;
    final tTvDetail = TvDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_detail.json')));

    test('should return tv detail when the response code is 200', () async {
      // arrange
      when(mockDioClient.get('/tv/$tId')).thenAnswer((_) async =>
          _dioResponse(
              json.decode(readJson('dummy_data/tv_detail.json')), 200));
      // act
      final result = await dataSource.getTvDetail(tId);
      // assert
      expect(result, equals(tTvDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockDioClient.get('/tv/$tId'))
          .thenAnswer((_) async => _dioResponse('Not Found', 404));
      // act
      final call = dataSource.getTvDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv recommendations', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv_recommendations.json')))
        .tvList;
    final tId = 1;

    test('should return list of Tv Model when the response code is 200',
        () async {
      // arrange
      when(mockDioClient.get('/tv/$tId/recommendations'))
          .thenAnswer((_) async => _dioResponse(
              json.decode(readJson('dummy_data/tv_recommendations.json')),
              200));
      // act
      final result = await dataSource.getTvRecommendations(tId);
      // assert
      expect(result, equals(tTvList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockDioClient.get('/tv/$tId/recommendations'))
          .thenAnswer((_) async => _dioResponse('Not Found', 404));
      // act
      final call = dataSource.getTvRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tvs', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv_search.json')))
        .tvList;
    final tQuery = 'Game';

    test('should return list of tvs when response code is 200', () async {
      // arrange
      when(mockDioClient.get('/search/tv?query=$tQuery'))
          .thenAnswer((_) async => _dioResponse(
              json.decode(readJson('dummy_data/tv_search.json')), 200));
      // act
      final result = await dataSource.searchTvs(tQuery);
      // assert
      expect(result, tTvList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockDioClient.get('/search/tv?query=$tQuery'))
          .thenAnswer((_) async => _dioResponse('Not Found', 404));
      // act
      final call = dataSource.searchTvs(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
