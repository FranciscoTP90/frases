import 'package:flutter/foundation.dart';
import 'package:frases/models/phrase_model.dart';
import 'package:frases/services/database_favorites.dart';
import 'package:frases/utils/pagination.dart';
import 'package:sqflite/sqflite.dart';

class FavoritePhrasesProvider extends ChangeNotifier {
  bool _isLoading = false;
  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _hasMore = true;
  bool get getHasMore => _hasMore;

  int _page = 0;
  List<Phrase> _favoritePhrases = [];
  List<Phrase> get getFavoritePhrases => _favoritePhrases;

  int? _total;
  List<Map<String, dynamic>>? _queryRes;

  void reset() {
    _hasMore = true;
    _isLoading = false;
    _page = 0;
    _favoritePhrases = [];
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>?> _findPhrasesQuery(Database database) {
    final res = database.query(PhraseTable.tableName,
        offset: (_page * Pagination.limit),
        limit: Pagination.limit,
        where: 'status = ?',
        whereArgs: [1]);

    return res;
  }

  Future<void> loadFavoritePhrases() async {
    try {
      if (!_isLoading) {
        if (_hasMore) {
          setIsLoading = true;

          final database = await FavoritesDatabase.instance.database;

          if (_total == null) {
            final List<List<Map<String, dynamic>>?> futures =
                await Future.wait([
              database.rawQuery(
                  'SELECT COUNT(*) FROM ${PhraseTable.tableName} WHERE status = ?',
                  [1]),
              _findPhrasesQuery(database)
            ]);
            _total = Sqflite.firstIntValue(futures[0]!);
            _queryRes = futures[1];
          } else {
            _queryRes = await _findPhrasesQuery(database);
          }

          final List<Phrase> phraseList =
              _queryRes!.map((json) => Phrase.fromJson(json)).toList();

          _favoritePhrases = [..._favoritePhrases, ...phraseList];
          _isLoading = false;
          _page = _page + 1;
          _hasMore = _page < Pagination.totalPages(_total!);

          notifyListeners();
        }
      }
    } catch (e) {
      reset();
    }
  }

  Future<void> addToFavorites(Phrase phrase) async {
    try {
      final database = await FavoritesDatabase.instance.database;
      await database.insert(PhraseTable.tableName, phrase.toMap());
      _favoritePhrases.add(phrase);
      notifyListeners();
    } catch (e) {
      throw Exception('Error addFavorites $e');
    }
  }

  Future<void> deleteFromFavorites(String id) async {
    try {
      final database = await FavoritesDatabase.instance.database;
      await database.delete(PhraseTable.tableName,
          where: '${PhraseTable.id} = ?', whereArgs: [id]);
      _favoritePhrases.removeWhere((phrase) => phrase.id == id);
      notifyListeners();
    } catch (e) {
      throw Exception('Error deleteFromFavorites $e');
    }
  }

  Future<bool> checkIsFavorite(String id) async {
    final database = await FavoritesDatabase.instance.database;
    List<Map> maps = await database.query(PhraseTable.tableName,
        columns: PhraseTable.values,
        where: '${PhraseTable.id} = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
