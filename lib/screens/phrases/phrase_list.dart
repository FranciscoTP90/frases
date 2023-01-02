import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frases/models/phrase_model.dart';
import 'package:frases/routes/routes.dart';
import 'package:frases/utils/assets_location.dart';

class PhraseList extends StatelessWidget {
  const PhraseList({super.key});

  @override
  Widget build(BuildContext context) {
    final phrases = List.generate(
        20,
        (index) => Phrase(
            id: "$index",
            category: "category",
            status: 1,
            img:
                "https://res.cloudinary.com/franciscotp90/image/upload/v1639084843/FrasesParaCompartir/NAVIDE%C3%91AS/qyi7ceps1799ztis0ys7.webp",
            phrase: "El mejor regalo en esta Navidad es tu sonrisa."));

    return GridView.builder(
        // controller: scrollController,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 9 / 16,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        // itemCount: frases.length + (hayMas ? 1 : 0),
        itemCount: phrases.length,
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
        itemBuilder: (BuildContext context, int index) {
          // if (index == phrases.length) {
          //   return const CircularProgressWidget();
          // }
          return GestureDetector(
              onTap: () => Navigator.pushNamed(context, RoutesApp.detail,
                  arguments: phrases[index]),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                          imageUrl: phrases[index].img,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Image.asset(
                                AssetsLocation.placeholder,
                                fit: BoxFit.cover,
                              ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error)))));
        });
  }
}
