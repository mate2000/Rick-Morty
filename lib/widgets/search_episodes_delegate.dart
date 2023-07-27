import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty/models/episodes.dart';
import 'package:rick_morty/providers/api_provider.dart';

class SearchEpisode extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear_rounded))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);
    Widget circleLoad() {
      return const Center(
        child: CircleAvatar(
          radius: 100,
          backgroundImage:
              AssetImage('assets/images/portal-rick-and-morty.gif'),
        ),
      );
    }

    if (query.isEmpty) {
      return circleLoad();
    }
    return FutureBuilder(
      future: apiProvider.getEpisodebyName(query),
      builder: (context, AsyncSnapshot<List<Episode>> snapshot) {
        if (!snapshot.hasData) {
          return circleLoad();
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final episode = snapshot.data![index];
            return ListTile(
              onTap: () {
                context.go('/episode', extra: episode);
              },
              title: Text(episode.name!),
              leading: Hero(
                  tag: episode.id!,
                  child: const CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/rick_morty_poster.jpg'),
                  )),
            );
          },
        );
      },
    );
  }
}
