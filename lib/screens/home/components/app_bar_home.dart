import 'package:flutter/material.dart';
import 'package:frases/screens/search/search_delegate_screen.dart';
import 'package:frases/theme/colors.dart';

class AppBarHome extends StatelessWidget with PreferredSizeWidget {
  const AppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: const Text("Frases para compartir"),
      actions: [
        FloatingActionButton(
          heroTag: "searchTag",
          mini: true,
          elevation: 0.0,
          backgroundColor: ColorsApp.greyLight,
          onPressed: () =>
              showSearch(context: context, delegate: PhraseSearchDelegate()),
          child: const Icon(Icons.search, color: Colors.grey),
        ),
        FloatingActionButton(
          mini: true,
          elevation: 0.0,
          backgroundColor: ColorsApp.greyLight,
          onPressed: () {
            //TOOD: Enviar a Favoritos
          },
          child: const Icon(Icons.favorite, color: ColorsApp.red),
        ),
        const SizedBox(width: 10.0)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
