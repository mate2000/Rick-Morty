import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty/models/character.dart';
import 'package:rick_morty/models/episodes.dart';

class ApiProvider with ChangeNotifier {
  final url = "https://rickandmortyapi.com";
  List<Character> characters = [];
  List<Episode> episodes = [];
  Future<void> getCharacter(int page) async {
    final result =
        await Dio().get("$url/api/character", queryParameters: {'page': page});
    final response = CharacterResponse.fromMap(result.data);
    characters.addAll(response.results!);
    notifyListeners();
  }

  Future<List<Episode>> getEpisodesByCharacter(Character character) async {
    episodes = [];
    for (var i = 0; i < character.episode!.length; i++) {
      final result = await Dio().get(character.episode![i]);
      final response = Episode.fromMap(result.data);
      episodes.add(response);
      notifyListeners();
    }

    return episodes;
  }
}
