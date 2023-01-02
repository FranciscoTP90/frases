import 'package:flutter/material.dart';
import 'package:frases/models/phrase_model.dart';
import 'package:frases/screens/detail/components/back_button.dart';
import 'package:frases/screens/detail/components/favorite_button.dart';
import 'package:frases/screens/detail/components/phrase_img.dart';
import 'package:frases/screens/detail/components/share_buttons.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Phrase phrase = ModalRoute.of(context)!.settings.arguments as Phrase;
    final sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        width: sizeScreen.width,
        height: sizeScreen.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            PhraseImg(imgUrl: phrase.img),
            const BackButtonWidget(),
            FavoriteButton(phrase: phrase),
            ShareButtons(phrase: phrase)
          ],
        ),
      ),
      // bottomNavigationBar:
    );
  }
}
