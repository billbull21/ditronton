import '../../../../../common/db/db_instance.dart';
import '../../models/tv_table.dart';

class TvDatabaseHelper {
  final DBInstance dbInstance;

  TvDatabaseHelper({required this.dbInstance});


  Future<int> insertWatchlist(TvTable tv) async {
    final db = await dbInstance.database;
    return await db!.insert(DBInstance.tvTblWatchlist, tv.toJson());
  }

  Future<int> removeWatchlist(TvTable tv) async {
    final db = await dbInstance.database;
    return await db!.delete(
      DBInstance.tvTblWatchlist,
      where: 'id = ?',
      whereArgs: [tv.id],
    );
  }

  Future<Map<String, dynamic>?> getTvById(int id) async {
    final db = await dbInstance.database;
    final results = await db!.query(
      DBInstance.tvTblWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTvs() async {
    final db = await dbInstance.database;
    final List<Map<String, dynamic>> results = await db!.query(DBInstance.tvTblWatchlist);

    return results;
  }

}