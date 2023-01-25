import '../../../models/phrase_model.dart';
import '../../../providers/providers.dart';
import '../../../theme/colors.dart';
import 'glassmorphism.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShareButtons extends StatefulWidget {
  final Phrase phrase;
  const ShareButtons({super.key, required this.phrase});

  @override
  State<ShareButtons> createState() => _ShareButtonsState();
}

class _ShareButtonsState extends State<ShareButtons> {
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
                    try {
                      Provider.of<PhrasesProvider>(context, listen: false)
                          .shareText(widget.phrase.phrase);
                    } catch (e) {
                      throw Exception('Error Share Text $e');
                    }
                  }),
              _ShareButton(
                texto: "Compartir Imagen",
                icon: Icons.image,
                onPressed: () async {
                  final resp =
                      await Provider.of<PhrasesProvider>(context, listen: false)
                          .shareImg(widget.phrase);
                  if (!resp) {
                    final snackBar = SnackBar(
                        backgroundColor: ColorsApp.red,
                        content: Row(
                          children: const [
                            Icon(Icons.info_outline, color: Colors.white),
                            SizedBox(width: 5.0),
                            Text(
                              "Conéctate a Internet",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            )
                          ],
                        ));
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }
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
