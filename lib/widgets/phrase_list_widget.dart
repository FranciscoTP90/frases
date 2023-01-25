import '../models/phrase_model.dart';
import '../routes/routes.dart';
import '../utils/assets_location.dart';
import 'circular_progress_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PhraseListWidget extends StatelessWidget {
  final ScrollController? scrollController;
  final List<Phrase> phrases;
  final bool hasMore;

  const PhraseListWidget(
      {super.key,
      this.scrollController,
      required this.phrases,
      required this.hasMore});

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return GridView.builder(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 9 / 16,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: isPortrait ? 2 : 3),
        itemCount: phrases.length + (hasMore ? 1 : 0),
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
        itemBuilder: (BuildContext context, int index) {
          if (index == phrases.length) {
            return const CircularProgressWidget();
          }
          return GestureDetector(
              onTap: () => Navigator.pushNamed(context, RoutesApp.detail,
                  arguments: phrases[index]),
              child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                          imageUrl: phrases[index].img,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Image.asset(
                                AssetsLocation.placeholder,
                                fit: BoxFit.cover,
                              ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error)))));
        });
  }
}
