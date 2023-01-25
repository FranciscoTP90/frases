import '../../providers/providers.dart';
import '../../theme/colors.dart';
import '../../widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePhrasesScreen extends StatelessWidget {
  const FavoritePhrasesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: AppBarWidget(title: "Frases Favoritas"), body: _PhraseList());
  }
}

class _PhraseList extends StatefulWidget {
  const _PhraseList();

  @override
  State<_PhraseList> createState() => __PhraseListState();
}

class __PhraseListState extends State<_PhraseList> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _loadFavoritePhrases());

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        _loadFavoritePhrases();
      }
    });
  }

  Future<void> _loadFavoritePhrases() async {
    await context.read<FavoritePhrasesProvider>().loadFavoritePhrases();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritePhrasesProvider>(
      builder: (context, provider, child) {
        if (provider.getFavoritePhrases.isEmpty) {
          return const _Empty();
        }
        return PhraseListWidget(
            scrollController: scrollController,
            phrases: provider.getFavoritePhrases,
            hasMore: provider.getHasMore);
      },
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.favorite, color: ColorsApp.red, size: 60),
          Text("No tienes Favoritos",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
