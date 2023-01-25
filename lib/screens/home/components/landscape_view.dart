import '../../../providers/providers.dart';
import '../../../routes/routes.dart';
import '../../../theme/colors.dart';
import '../../../widgets/widgets.dart';
import '../../screens.dart';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'phrases_home.dart';

class LandscapeView extends StatelessWidget {
  final double widthSize;
  const LandscapeView({super.key, required this.widthSize});

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final bool isTablet = MediaQuery.of(context).size.shortestSide > 600;
    return Row(
      children: [
        Expanded(
          flex: isTablet ? 1 : 2,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Categorias",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RoutesApp.categories);
                        },
                        child: const Text("Ver más",
                            style: TextStyle(color: ColorsApp.blue)))
                  ],
                ),
              ),
              Expanded(child: Consumer<CategoriesProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const CircularProgressWidget();
                  }

                  return Builder(builder: (context) {
                    return GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: isPortrait ? 40 : 20,
                        crossAxisCount: isPortrait ? 1 : 2,
                      ),
                      itemCount: isTablet ? 6 : 4,
                      itemBuilder: (BuildContext context, int index) {
                        final category = provider.getCategories[index];
                        return GestureDetector(
                          onTap: () async {
                            log(category.name);
                            Navigator.push(context, PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return PhrasesByCategoryScreen(
                                    category: category);
                              },
                            ));
                          },
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: ColorsApp.yellow),
                                    child: CachedNetworkImage(
                                      width: double.infinity,
                                      // height: double.infinity,
                                      fit: BoxFit.contain,
                                      imageUrl: category.icon,
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    )),
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                provider.getCategories[index].name,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  });
                },
              )),
            ],
          ),
        ),
        Expanded(
          // width: widthSize * .7,
          flex: 3,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Frases Recientes",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RoutesApp.phrases);
                        },
                        child: const Text("Ver más",
                            style: TextStyle(color: ColorsApp.blue)))
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              const PhrasesHome(),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ],
    );
  }
}
