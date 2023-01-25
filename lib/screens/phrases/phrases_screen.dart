import 'package:flutter/material.dart';
import 'package:frases/providers/phrases_provider.dart';
import 'package:frases/widgets/phrase_list_widget.dart';
import 'package:frases/widgets/app_bar_widget.dart';
import 'package:provider/provider.dart';

class PhrasesScreen extends StatelessWidget {
  const PhrasesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: AppBarWidget(title: "Frases"), body: _PhraseList());
  }
}

class _PhraseList extends StatefulWidget {
  const _PhraseList();

  @override
  State<_PhraseList> createState() => _PhraseListState();
}

class _PhraseListState extends State<_PhraseList> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() => _loadPhrases());

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        _loadPhrases();
      }
    });
  }

  Future<void> _loadPhrases() async {
    await context.read<PhrasesProvider>().loadPhrases();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final phrases = context.watch<PhrasesProvider>().getPhrases;
    final hasMore = context.watch<PhrasesProvider>().getHasMore;
    return PhraseListWidget(
        scrollController: scrollController, phrases: phrases, hasMore: hasMore);
  }
}
