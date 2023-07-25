import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CharacterScren extends StatelessWidget {
  const CharacterScren({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rick and Morty',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
          child: ElevatedButton(
              onPressed: () => {context.go('/character')},
              child: const Text('Go'))),
    );
  }
}
