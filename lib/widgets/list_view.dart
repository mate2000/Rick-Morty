import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../providers/api_provider.dart';

class CharacterList extends StatelessWidget {
  const CharacterList(
      {super.key,
      required this.apiProvider,
      required this.scrollController,
      required this.isLoading,
      required this.destination});

  final ApiProvider apiProvider;
  final ScrollController scrollController;
  final bool isLoading;
  final String destination;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.87,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10),
      itemCount: isLoading
          ? apiProvider.characters.length + 2
          : apiProvider.characters.length,
      controller: scrollController,
      itemBuilder: (context, index) {
        if (index < apiProvider.characters.length) {
          final character = apiProvider.characters[index];
          return GestureDetector(
            onTap: () {
              context.go('/$destination', extra: character);
            },
            child: Card(
                child: Column(
              children: [
                Hero(
                  tag: character.id!,
                  child: FadeInImage(
                      placeholder: const AssetImage(
                          'assets/images/portal-rick-and-morty.gif'),
                      image: NetworkImage(character.image!)),
                ),
                Text(
                  "${character.name!} - ${character.status}",
                  style: const TextStyle(
                      fontSize: 16, overflow: TextOverflow.ellipsis),
                )
              ],
            )),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
