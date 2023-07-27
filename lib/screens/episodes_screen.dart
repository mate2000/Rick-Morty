import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../providers/api_provider.dart';

class EpisodeList extends StatelessWidget {
  const EpisodeList(
      {super.key,
      required this.apiProvider,
      required this.scrollController,
      required this.isLoading});

  final ApiProvider apiProvider;
  final ScrollController scrollController;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5),
      itemCount: isLoading
          ? apiProvider.episodes.length + 2
          : apiProvider.episodes.length,
      controller: scrollController,
      itemBuilder: (context, index) {
        if (index < apiProvider.episodes.length) {
          final episode = apiProvider.episodes[index];
          return GestureDetector(
            onTap: () {
              context.go('/episode', extra: episode);
            },
            child: Card(
                child: Column(
              children: [
                Expanded(
                  child: Hero(
                    tag: episode.id!,
                    child: const Image(
                      image: AssetImage('assets/images/rick_morty_poster.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  "${episode.name!} - ${episode.episode}",
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
