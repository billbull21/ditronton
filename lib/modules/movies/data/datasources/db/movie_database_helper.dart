import '../../../../../common/db/db_instance.dart';
import '../../models/movie_table.dart';

class MovieDatabaseHelper {
  final DBInstance dbInstance;

  MovieDatabaseHelper({required this.dbInstance});


  Future<int> insertWatchlist(MovieTable movie) async {
    final db = await dbInstance.database;
    return await db!.insert(DBInstance.movieTblWatchlist, movie.toJson());
  }

  Future<int> removeWatchlist(MovieTable movie) async {
    final db = await dbInstance.database;
    return await db!.delete(
      DBInstance.movieTblWatchlist,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await dbInstance.database;
    final results = await db!.query(
      DBInstance.movieTblWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await dbInstance.database;
    final List<Map<String, dynamic>> results = await db!.query(DBInstance.movieTblWatchlist);

    return results;
  }

}