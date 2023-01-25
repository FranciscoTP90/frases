import 'package:flutter/material.dart';
import 'package:frases/models/phrase_model.dart';
import 'package:frases/providers/phrases_provider.dart';
import 'package:frases/widgets/circular_progress_widget.dart';
import 'package:frases/widgets/phrase_list_widget.dart';
import 'package:provider/provider.dart';

class PhraseSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Provider.of<PhrasesProvider>(context, listen: false).dipose();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Phrase> searchResult = context.select(
        (PhrasesProvider phrasesProvider) => phrasesProvider.getPhrasesSerched);

    return searchResult.isEmpty
        ? _emptySearch()
        : PhraseListWidget(phrases: searchResult, hasMore: false);
  }

  Widget _emptySearch() {
    return const Center(
      child: Text("No se encontraron resultados"),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const SizedBox();
    }
    final frasesProvider = Provider.of<PhrasesProvider>(context, listen: false);
    frasesProvider.getSuggestionsByQuery(query);
    return StreamBuilder<List<Phrase>>(
      stream: frasesProvider.suggestionStream,
      builder: (BuildContext context, AsyncSnapshot<List<Phrase>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done ||
            snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return _emptySearch();
          } else {
            final List<Phrase> phraseList = snapshot.data!;
            Future.microtask(() {
              context.read<PhrasesProvider>().setPhrasesSerched = phraseList;
            });

            return PhraseListWidget(phrases: phraseList, hasMore: false);
          }
        } else {
          return const CircularProgressWidget();
        }
      },
    );
  }
}
