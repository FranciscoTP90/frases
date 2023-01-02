import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frases/models/phrase_model.dart';
import 'package:frases/routes/routes.dart';
import 'package:frases/theme/colors.dart';

class PhrasesHome extends StatelessWidget {
  const PhrasesHome({Key? key}) : super(key: key);

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
    final sizeScreen = MediaQuery.of(context).size;
    return Expanded(
      flex: 3,
      child: ListView.builder(
        itemCount: phrases.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RoutesApp.detail,
                  arguments: phrases[index]);
            },
            child: Container(
              width: sizeScreen.width * 0.75,
              decoration: BoxDecoration(
                color: ColorsApp.pink,
                borderRadius: BorderRadius.circular(12.0),
              ),
              margin: const EdgeInsets.only(right: 10.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: CachedNetworkImage(
                    width: sizeScreen.width * 0.75,
                    imageUrl: phrases[index].img,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => SizedBox(
                        width: sizeScreen.width * 0.75,
                        child: const Icon(Icons.error)),
                  )),
            ),
          );
        },
      ),
    );
  }
}
