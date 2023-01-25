import '../../../utils/assets_location.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PhraseImg extends StatelessWidget {
  final String imgUrl;
  const PhraseImg({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return CachedNetworkImage(
      imageUrl: imgUrl,
      width: double.infinity,
      height: double.infinity,
      fit: isPortrait ? BoxFit.cover : BoxFit.fitHeight,
      placeholder: (context, url) => Image.asset(
        AssetsLocation.placeholder,
        width: double.infinity,
        fit: BoxFit.fill,
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
