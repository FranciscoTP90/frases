import 'package:flutter/cupertino.dart';
import 'package:frases/models/category_model.dart';
import 'package:frases/services/database_service.dart';
import 'package:frases/utils/pagination.dart';

import 'package:sqflite/sqflite.dart';

class CategoriesProvider extends ChangeNotifier {
  bool _hasMore = true;
  bool get getHasMore => _hasMore;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  int _page = 0;

  List<Category> _categories = [];
  List<Category> get getCategories => _categories;

  int? _total;
  List<Map<String, dynamic>>? _queryRes;

  // Category? _selectedCategory;
  // Category? get selectedCategory => _selectedCategory;

  // set setSelectedcategory(Category category) {
  //   _selectedCategory = category;
  //   notifyListeners();
  // }

  CategoriesProvider() {
    loadCategories();
  }

  void reset() {
    _hasMore = true;
    _isLoading = false;
    _page = 0;
    _categories = [];
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>?> _findCategoriesQuery(Database database) {
    const orderBy = '${CategoryTable.name} ASC';

    final res = database.query(CategoryTable.tableName,
        orderBy: orderBy,
        offset: (_page * Pagination.limit),
        limit: Pagination.limit,
        where: 'status = ?',
        whereArgs: [1]);
    return res;
  }

  Future<void> loadCategories() async {
    try {
      if (!_isLoading) {
        if (_hasMore) {
          setIsLoading = true;

          final database = await DatabaseService.db.getDatabase;

          if (_total == null) {
            final List<List<Map<String, dynamic>>?> futures =
                await Future.wait([
              database!.rawQuery(
                  'SELECT COUNT(*) FROM ${CategoryTable.tableName} WHERE status = ?',
                  [1]),
              _findCategoriesQuery(database)
            ]);
            _total = Sqflite.firstIntValue(futures[0]!);
            _queryRes = futures[1];
          } else {
            _queryRes = await _findCategoriesQuery(database!);
          }

          final List<Category> categoryList =
              _queryRes!.map((json) => Category.fromJson(json)).toList();

          // _selectedCategory ??= categoryList.first;

          _categories = [..._categories, ...categoryList];
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
