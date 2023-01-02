import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frases/utils/assets_location.dart';

class PhraseImg extends StatelessWidget {
  final String imgUrl;
  const PhraseImg({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      placeholder: (context, url) => Image.asset(
        AssetsLocation.placeholder,
        width: double.infinity,
        fit: BoxFit.fill,
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
