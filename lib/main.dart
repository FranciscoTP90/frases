import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'providers/providers.dart';
import 'routes/routes.dart';
import 'theme/theme.dart';

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
