import 'package:flutter/material.dart';
import 'package:frases/models/phrase_model.dart';
import 'package:frases/screens/detail/components/glassmorphism.dart';

class ShareButtons extends StatelessWidget {
  final Phrase phrase;
  const ShareButtons({super.key, required this.phrase});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      child: SizedBox(
        height: 80,
        child: Glassmorphism(
          blur: 10,
          opacity: 0.2,
          radius: 12,
          child: Row(
            children: [
              _ShareButton(
                  texto: "Compartir Texto",
                  icon: Icons.text_fields,
                  onPressed: () {
                    // try {
                    //   Share.share(phrase.phrase);
                    // } catch (e) {}
                  }),
              _ShareButton(
                texto: "Compartir Imagen",
                icon: Icons.image,
                onPressed: () async {
                  // final resp =
                  //     await Provider.of<FrasesProvider>(context, listen: false)
                  //         .shareImg(phrase);
                  // if (!resp) {
                  //   final snackBar = SnackBar(
                  //       backgroundColor: ColorsApp.red,
                  //       content: Row(
                  //         children: const [
                  //           Icon(Icons.info_outline, color: Colors.white),
                  //           SizedBox(width: 5.0),
                  //           Text(
                  //             "Conéctate a Internet",
                  //             style: TextStyle(
                  //                 color: Colors.white, fontSize: 20.0),
                  //           )
                  //         ],
                  //       ));
                  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  // }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShareButton extends StatelessWidget {
  final Function()? onPressed;
  final String texto;
  final IconData icon;
  const _ShareButton({this.onPressed, required this.texto, required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.black,
        ),
        label: Text(texto, style: const TextStyle(color: Colors.black)));
  }
}
