import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty/models/character.dart';
import 'package:rick_morty/models/locations.dart';
import 'package:rick_morty/providers/api_provider.dart';
import 'package:rick_morty/screens/character_screen.dart';
import 'package:rick_morty/screens/detail_character.dart';
import 'package:rick_morty/screens/detail_episode.dart';
import 'package:rick_morty/screens/detail_location.dart';

import 'models/episodes.dart';

void main() => runApp(MyApp());

final GoRouter _router = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: (context, state) {
        return const CharacterScreen();
      },
      routes: [
        GoRoute(
          path: 'character',
          builder: (context, state) {
            final character = state.extra as Character;
            return DetailCharacter(
              character: character,
            );
          },
        ),
        GoRoute(
          path: 'location',
          builder: (context, state) {
            final location = state.extra as Location;
            return DetailLocation(
              location: location,
            );
          },
        ),
        GoRoute(
          path: 'episode',
          builder: (context, state) {
            final episode = state.extra as Episode;
            return DetailEpisode(
              episode: episode,
            );
          },
        ),
      ])
]);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApiProvider(),
      child: MaterialApp.router(
        title: 'Rick and Morty',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.dark, useMaterial3: true),
        routerConfig: _router,
      ),
    );
  }
}
