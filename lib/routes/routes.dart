import 'package:frases/screens/categories/categories_screen.dart';
import 'package:frases/screens/detail/detail_screen.dart';
import 'package:frases/screens/home/home_screen.dart';
import 'package:frases/screens/phrases/phrases_screen.dart';

class RoutesApp {
  static const String home = '/home';
  static const String categories = '/categories';
  static const String phrases = '/phrases';
  static const String detail = '/detail';

  static final routes = {
    home: (_) => const HomeScreen(),
    categories: (_) => const CategoriesScreen(),
    phrases: (_) => const PhrasesScreen(),
    detail: (_) => const DetailScreen(),
  };
}
