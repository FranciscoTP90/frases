import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frases/models/category_model.dart';
import 'package:frases/theme/colors.dart';

class CategoriesHome extends StatelessWidget {
  const CategoriesHome({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = List.generate(
      20,
      (index) {
        return Category(
            id: "$index",
            status: 1,
            name: "Category:$index",
            icon:
                "https://res.cloudinary.com/franciscotp90/image/upload/v1672355764/FrasesParaCompartir/ICONOS/ni9gdoosfs84rqjudivd.webp");
      },
    );
    return Expanded(
      flex: 1,
      child: ListView.builder(
        itemCount: 4,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        itemBuilder: (BuildContext context, int index) {
          final sizeScreen = MediaQuery.of(context).size;
          final Category category = categories[index];
          return GestureDetector(
            onTap: () {
              // Navigator.push(context, PageRouteBuilder(
              //   pageBuilder: (context, animation, secondaryAnimation) {
              //     return FrasesByCategoryScreen(category: category);
              //   },
              // ));
            },
            child: Container(
              margin: const EdgeInsets.only(right: 5.0),
              width: sizeScreen.width * 0.232,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: ColorsApp.yellow),
                        child: CachedNetworkImage(
                          width: double.infinity,
                          fit: BoxFit.contain,
                          imageUrl: category.icon,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        )),
                  ),
                  const SizedBox(height: 10.0),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      category.name,
                      style: const TextStyle(fontSize: 11.0),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
