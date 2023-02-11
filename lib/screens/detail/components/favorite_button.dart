import '../../../models/phrase_model.dart';
import '../../../providers/providers.dart';
import '../../../theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatefulWidget {
  final Phrase phrase;

  const FavoriteButton({Key? key, required this.phrase}) : super(key: key);

  @override
  State<FavoriteButton> createState() => _LikeButtonWidgetState();
}

class _LikeButtonWidgetState extends State<FavoriteButton> {
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => check());
  }

  Future<void> check() async {
    final isFavorite = await context
        .read<FavoritePhrasesProvider>()
        .checkIsFavorite(widget.phrase.id);

    if (mounted) {
      setState(() {
        _isLiked = isFavorite;
      });
    }
  }

  Future<void> addToFavorite() async {
    await context.read<FavoritePhrasesProvider>().addToFavorites(widget.phrase);
  }

  Future<void> deleteFavorite() async {
    await context
        .read<FavoritePhrasesProvider>()
        .deleteFromFavorites(widget.phrase.id);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      right: 10,
      child: FloatingActionButton(
        mini: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        onPressed: () {},
        child: LikeButton(
          isLiked: _isLiked,
          onTap: (isLiked) async {
            //si esta favorito
            if (isLiked) {
              //Quiero borrar
              await deleteFavorite();
              return !isLiked;
            } else {
              await addToFavorite();
              return !isLiked;
            }
          },
          likeBuilder: (isLiked) {
            return Icon(Icons.favorite,
                color: isLiked ? ColorsApp.red : Colors.grey);
          },
        ),
      ),
    );
  }
}
