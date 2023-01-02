import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 10,
      child: FloatingActionButton.small(
        elevation: 0.0,
        heroTag: "searchTag",
        backgroundColor: Colors.white,
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.chevron_left, color: Colors.black),
      ),
    );
  }
}
