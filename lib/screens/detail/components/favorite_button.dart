import 'package:flutter/material.dart';
import 'package:frases/models/phrase_model.dart';
import 'package:frases/theme/colors.dart';
import 'package:like_button/like_button.dart';

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

  check() async {
    // final res =
    //     await Provider.of<FrasesFavoritasProvider>(context, listen: false)
    //         .checkIsFavorite(widget.phrase.id);

    if (mounted) {
      setState(() {
        // _isLiked = res;
        _isLiked = true;
      });
    }
  }

  addToFavorite() async {
    // await Provider.of<FrasesFavoritasProvider>(context, listen: false)
    //     .addToFavorites(widget.phrase);
  }

  deleteFavorite() async {
    // await Provider.of<FrasesFavoritasProvider>(context, listen: false)
    //     .deleteFromFavorites(widget.phrase.id);
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
