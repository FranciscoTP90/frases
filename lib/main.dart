import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frases/routes/routes.dart';
import 'package:frases/theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
