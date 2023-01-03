import 'package:flutter/material.dart';
import 'package:frases/widgets/phrase_list.dart';

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
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const PhraseList();
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

    return const PhraseList();
  }
}
