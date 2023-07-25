import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty/providers/api_provider.dart';

class CharacterScren extends StatefulWidget {
  const CharacterScren({Key? key}) : super(key: key);

  @override
  State<CharacterScren> createState() => _CharacterScrenState();
}

class _CharacterScrenState extends State<CharacterScren> {
  @override
  void initState() {
    super.initState();
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    apiProvider.getCharacter();
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rick and Morty',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: apiProvider.characters.isNotEmpty
            ? CharacterList(
                apiProvider: apiProvider,
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}

class CharacterList extends StatelessWidget {
  const CharacterList({super.key, required this.apiProvider});

  final ApiProvider apiProvider;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.8),
      itemCount: apiProvider.characters.length,
      itemBuilder: (context, index) {
        final character = apiProvider.characters[index];
        return GestureDetector(
          onTap: () {
            context.go('/character');
          },
          child: Card(
              child: Column(
            children: [
              FadeInImage(
                  placeholder: const AssetImage(
                      'assets/images/portal-rick-and-morty.gif'),
                  image: NetworkImage(character.image!)),
              Text(
                character.name!,
                style: TextStyle(fontSize: 16, overflow: TextOverflow.ellipsis),
              )
            ],
          )),
        );
      },
    );
  }
}
