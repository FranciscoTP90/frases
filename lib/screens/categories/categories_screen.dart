import 'package:flutter/material.dart';
import 'package:frases/screens/categories/category_list.dart';
import 'package:frases/widgets/app_bar_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: AppBarWidget(title: "Categorias"), body: CategoryList());
  }
}
