import '../models/phrase_model.dart';
import '../services/database_service.dart';
import '../utils/debouncer.dart';
import '../utils/pagination.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite/sqflite.dart';

class PhrasesProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _hasMore = true;
  bool get getHasMore => _hasMore;

  List<Phrase> _phrases = [];
  List<Phrase> get getPhrases => _phrases;

  int _page = 0;

  int? _total;
  List<Map<String, dynamic>>? _queryRes;

  List<Phrase> _phrasesSearched = [];
  List<Phrase> get getPhrasesSerched => _phrasesSearched;

  set setPhrasesSerched(List<Phrase> phraseList) {
    _phrasesSearched = phraseList;
    notifyListeners();
  }

  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));
  final StreamController<List<Phrase>> _suggestionStreamController =
      StreamController.broadcast();

  Stream<List<Phrase>> get suggestionStream =>
      _suggestionStreamController.stream;

  PhrasesProvider() {
    loadPhrases();
  }
  void reset() {
    _hasMore = true;
    _isLoading = false;
    _page = 0;
    _phrases = [];
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

  Future<void> loadPhrases() async {
    try {
      if (!_isLoading) {
        if (_hasMore) {
          setIsLoading = true;

          final database = await DatabaseService.db.getDatabase;
          if (_total == null) {
            final List<List<Map<String, dynamic>>?> futures =
                await Future.wait([
              database!.rawQuery(
                  'SELECT COUNT(*) FROM ${PhraseTable.tableName} WHERE status = ?',
                  [1]),
              _findPhrasesQuery(database)
            ]);
            _total = Sqflite.firstIntValue(futures[0]!);
            _queryRes = futures[1];
          } else {
            _queryRes = await _findPhrasesQuery(database!);
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

  Future<bool> shareImg(Phrase frase) async {
    try {
      final uri = Uri.parse(frase.img);
      final resp = await http.get(uri);
      final bytes = resp.bodyBytes;
      final temp = await getTemporaryDirectory();
      final path = '${temp.path}/${frase.id}.webp';
      File(path).writeAsBytes(bytes);
      await Share.shareXFiles([XFile(path)]);
      return true;
    } catch (e) {
      return false;
    }
  }

  void shareText(String phrase) {
    Share.share(phrase);
  }

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await searchPhrase(value);
      _suggestionStreamController.add(results);
    };
    final timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      debouncer.value = searchTerm;
    });
    Future.delayed(const Duration(milliseconds: 301))
        .then((value) => timer.cancel());
  }

  Future<List<Phrase>> searchPhrase(String query) async {
    try {
      final database = await DatabaseService.db.getDatabase;

      final List<Map<String, dynamic>> res = await database!.query(
          PhraseTable.tableName,
          limit: Pagination.limit,
          where: "status = ? AND phrase LIKE '%'|| '$query'||'%'",
          whereArgs: [1]);

      final phraseList = res.map((json) => Phrase.fromJson(json)).toList();
      return phraseList;
    } catch (e) {
      return [];
    }
  }

  void dipose() {
    _suggestionStreamController.close();
  }
}
