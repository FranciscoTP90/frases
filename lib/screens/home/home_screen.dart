import 'package:flutter/material.dart';
import 'package:frases/routes/routes.dart';
import 'package:frases/screens/home/components/app_bar_home.dart';
import 'package:frases/screens/home/components/categories_home.dart';
import 'package:frases/screens/home/components/phrases_home.dart';
import 'package:frases/theme/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarHome(),
        body: Column(
          children: [
            _TitleAndMore(
                title: "Categorias",
                onPressed: () {
                  Navigator.pushNamed(context, RoutesApp.categories);
                }),
            const CategoriesHome(),
            const SizedBox(height: 10.0),
            _TitleAndMore(
                title: "Frases Recientes",
                onPressed: () {
                  Navigator.pushNamed(context, RoutesApp.phrases);
                }),
            const PhrasesHome(),
            const SizedBox(height: 10.0),
          ],
        ));
  }
}

class _TitleAndMore extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  const _TitleAndMore({Key? key, required this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18.0),
          ),
          TextButton(
              onPressed: onPressed,
              child: const Text("Ver más",
                  style: TextStyle(color: ColorsApp.blue)))
        ]));
  }
}
