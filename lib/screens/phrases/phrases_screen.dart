import 'package:flutter/material.dart';
import 'package:frases/widgets/phrase_list.dart';
import 'package:frases/widgets/app_bar_widget.dart';

class PhrasesScreen extends StatelessWidget {
  const PhrasesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: AppBarWidget(title: "Frases"), body: PhraseList());
  }
}
