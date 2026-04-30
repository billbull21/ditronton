import 'package:movie_dicoding_app/common/db/db_instance.dart';
import 'package:movie_dicoding_app/common/network/dio_client.dart';
import 'package:movie_dicoding_app/modules/movies/data/datasources/db/movie_database_helper.dart';
import 'package:movie_dicoding_app/modules/movies/data/datasources/movie_local_data_source.dart';
import 'package:movie_dicoding_app/modules/movies/data/datasources/movie_remote_data_source.dart';
import 'package:movie_dicoding_app/modules/movies/domain/repositories/movie_repository.dart';
import 'package:movie_dicoding_app/modules/tvs/data/datasources/db/tv_database_helper.dart';
import 'package:movie_dicoding_app/modules/tvs/data/datasources/tv_local_data_source.dart';
import 'package:movie_dicoding_app/modules/tvs/data/datasources/tv_remote_data_source.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/repositories/tv_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  MovieRepository,
  TvRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  MovieDatabaseHelper,
  TvRemoteDataSource,
  TvLocalDataSource,
  TvDatabaseHelper,
  DBInstance,
], customMocks: [
  MockSpec<DioClient>(as: #MockDioClient)
])
void main() {}
