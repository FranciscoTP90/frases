import 'package:flutter/material.dart';
import 'package:frases/models/category_model.dart';
import 'package:frases/providers/phrases_by_category_provider.dart';
import 'package:frases/widgets/app_bar_widget.dart';
import 'package:frases/widgets/phrase_list_widget.dart';
import 'package:provider/provider.dart';

class PhrasesByCategoryScreen extends StatefulWidget {
  final Category? category;
  const PhrasesByCategoryScreen({Key? key, this.category}) : super(key: key);

  @override
  State<PhrasesByCategoryScreen> createState() =>
      _PhrasesByCategoryScreenState();
}

class _PhrasesByCategoryScreenState extends State<PhrasesByCategoryScreen> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PhrasesByCategoryProvider>().reset();
      _loadPhrasesByCategory();
    });

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        _loadPhrasesByCategory();
      }
    });
  }

  Future<void> _loadPhrasesByCategory() async {
    await context
        .read<PhrasesByCategoryProvider>()
        .loadPhrasesByCategory(widget.category!.id);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(title: "Frases: ${widget.category!.name}"),
        body: Consumer<PhrasesByCategoryProvider>(
          builder: (context, provider, child) {
            if (provider.getPhrases.isEmpty) {
              return const Center(child: Text("Próximamente..."));
            } else {
              return PhraseListWidget(
                scrollController: scrollController,
                phrases: provider.getPhrases,
                hasMore: provider.hasMore,
              );
            }
          },
        ));
  }
}
