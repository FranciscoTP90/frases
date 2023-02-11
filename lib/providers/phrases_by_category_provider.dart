import '../models/phrase_model.dart';
import '../services/database_service.dart';
import '../utils/pagination.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class PhrasesByCategoryProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  int _page = 0;

  int? _total;
  List<Map<String, dynamic>>? _queryRes;

  List<Phrase> _phrases = [];
  List<Phrase> get getPhrases => _phrases;

  void reset() {
    _hasMore = true;
    _isLoading = false;
    _page = 0;
    _phrases = [];
    notifyListeners();
  }

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>?> _findPhrasesQuery(
      Database database, String categoryId) {
    final res = database.query(PhraseTable.tableName,
        offset: (_page * Pagination.limit),
        limit: Pagination.limit,
        where: 'status = ? AND category = ?',
        whereArgs: [1, categoryId]);
    return res;
  }

  Future<void> loadPhrasesByCategory(String categoryId) async {
    try {
      if (!_isLoading) {
        if (_hasMore) {
          setIsLoading = true;

          final database = await DatabaseService.db.getDatabase;
          if (_total == null) {
            final List<List<Map<String, dynamic>>?> futures =
                await Future.wait([
              database!.rawQuery(
                  'SELECT COUNT(*) FROM ${PhraseTable.tableName} WHERE status = ? AND category = ?',
                  [1, categoryId]),
              _findPhrasesQuery(database, categoryId)
            ]);
            _total = Sqflite.firstIntValue(futures[0]!);
            _queryRes = futures[1];
          } else {
            _queryRes = await _findPhrasesQuery(database!, categoryId);
          }

          final List<Phrase> phraseList =
              _queryRes!.map((json) => Phrase.fromJson(json)).toList();

          _phrases = [..._phrases, ...phraseList];
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
}
