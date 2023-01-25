import '../../models/phrase_model.dart';
import 'components/back_button.dart';
import 'components/favorite_button.dart';
import 'components/phrase_img.dart';
import 'components/share_buttons.dart';
import 'package:flutter/material.dart';

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
