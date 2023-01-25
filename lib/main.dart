import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frases/providers/categories_provider.dart';
import 'package:frases/providers/favorite_phrases_provider.dart';
import 'package:frases/providers/phrases_by_category_provider.dart';
import 'package:frases/providers/phrases_provider.dart';
import 'package:frases/routes/routes.dart';
import 'package:frases/theme/theme.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const MyAppState());
}

class MyAppState extends StatelessWidget {
  const MyAppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => CategoriesProvider(), lazy: false),
        ChangeNotifierProvider(
            create: (context) => PhrasesProvider(), lazy: false),
        ChangeNotifierProvider(
            create: (context) => PhrasesByCategoryProvider()),
        ChangeNotifierProvider(create: (context) => FavoritePhrasesProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frases',
      theme: ThemeApp.themeDataLight,
      initialRoute: RoutesApp.home,
      routes: RoutesApp.routes,
    );
  }
}
