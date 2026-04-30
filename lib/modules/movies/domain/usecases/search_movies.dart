import 'package:dartz/dartz.dart';
import 'package:movie_dicoding_app/common/failure.dart';
import 'package:movie_dicoding_app/modules/movies/domain/entities/movie.dart';
import 'package:movie_dicoding_app/modules/movies/domain/repositories/movie_repository.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchMovies(query);
  }
}
