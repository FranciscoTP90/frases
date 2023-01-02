import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frases/models/category_model.dart';
import 'package:frases/theme/colors.dart';
import 'package:frases/utils/assets_location.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

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
    return ListView.builder(
      itemCount: categories.length,
      // controller: scrollController,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        // if (index == categories.length) {
        //   return const CircularProgressWidget();
        // }

        return GestureDetector(
          onTap: () {
            // Navigator.push(context, PageRouteBuilder(
            //   pageBuilder: (context, animation, secondaryAnimation) {
            //     return FrasesByCategoryScreen(category: categories[index]);
            //   },
            // ));
          },
          child: Container(
            height: 100,
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: ColorsApp.greyLight),
            child: Row(
              children: [
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: categories[index].icon,
                    fit: BoxFit.cover,
                    // width: double.infinity,
                    placeholder: (context, url) => ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        AssetsLocation.placeholder,
                        fit: BoxFit.cover,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                const SizedBox(width: 15.0),
                Text(categories[index].name),
                const Spacer(),
                const Expanded(child: Icon(Icons.chevron_right))
              ],
            ),
          ),
        );
      },
    );
  }
}
