import '../../../models/category_model.dart';
import '../../../providers/providers.dart';
import '../../../theme/colors.dart';
import '../../../widgets/widgets.dart';
import '../../screens.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesHome extends StatelessWidget {
  const CategoriesHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Consumer<CategoriesProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const CircularProgressWidget();
            }

            return ListView.builder(
              itemCount: 4,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              itemBuilder: (BuildContext context, int index) {
                return _CategoryItem(category: provider.getCategories[index]);
              },
            );
          },
        ));
  }
}

class _CategoryItem extends StatelessWidget {
  final Category category;
  const _CategoryItem({required this.category});

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return PhrasesByCategoryScreen(category: category);
          },
        ));
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
  }
}
