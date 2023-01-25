import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frases/models/phrase_model.dart';
import 'package:frases/providers/phrases_provider.dart';
import 'package:frases/routes/routes.dart';
import 'package:frases/theme/colors.dart';
import 'package:frases/widgets/circular_progress_widget.dart';
import 'package:provider/provider.dart';

class PhrasesHome extends StatelessWidget {
  const PhrasesHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 3,
        child: Consumer<PhrasesProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const CircularProgressWidget();
            }

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: provider.getPhrases.length,
              itemBuilder: (context, index) {
                return PhraseItem(phrase: provider.getPhrases[index]);
              },
            );
          },
        ));
  }
}

class PhraseItem extends StatelessWidget {
  final Phrase phrase;
  const PhraseItem({super.key, required this.phrase});

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;

    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutesApp.detail, arguments: phrase);
      },
      child: Container(
        width: isPortrait ? sizeScreen.width * 0.65 : sizeScreen.width * 0.3,
        height: sizeScreen.height * 0.3,
        decoration: BoxDecoration(
          color: ColorsApp.pink,
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.only(right: 10.0, left: 10),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: CachedNetworkImage(
              imageUrl: phrase.img,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => SizedBox(
                  width: isPortrait ? sizeScreen.width * 0.65 : null,
                  height: sizeScreen.height * 0.3,
                  child: const Icon(Icons.error)),
            )),
      ),
    );
  }
}
