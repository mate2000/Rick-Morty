import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty/models/character.dart';
import 'package:rick_morty/models/episodes.dart';
import '../models/locations.dart';

class ApiProvider with ChangeNotifier {
  final url = "https://rickandmortyapi.com";
  List<Character> characters = [];
  List<Episode> episodes = [];
  List<Location> locations = [];

  Future<void> getCharacter(int page) async {
    final result =
        await Dio().get("$url/api/character", queryParameters: {'page': page});
    final response = CharacterResponse.fromMap(result.data);
    characters.addAll(response.results!);
    notifyListeners();
  }

  Future<List<Character>> getCharacterbyName(String name) async {
    final result =
        await Dio().get("$url/api/character", queryParameters: {'name': name});
    final response = CharacterResponse.fromMap(result.data);
    return response.results!;
  }

  Future<void> getLocations(int page) async {
    final result =
        await Dio().get("$url/api/location", queryParameters: {'page': page});
    final response = LocationsResponse.fromMap(result.data);
    locations.addAll(response.results!);
    notifyListeners();
  }

  Future<void> getEpisodes(int page) async {
    final result =
        await Dio().get("$url/api/episode", queryParameters: {'page': page});
    final response = EpisodesResponse.fromMap(result.data);
    episodes.addAll(response.results!);
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

  Future<List<Character>> getCharacterByEpisode(Episode episode) async {
    characters = [];
    for (var i = 0; i < episode.characters!.length; i++) {
      final result = await Dio().get(episode.characters![i]);
      final response = Character.fromMap(result.data);
      characters.add(response);
      notifyListeners();
    }
    return characters;
  }

  Future<List<Character>> getCharacterByLocation(Location location) async {
    characters = [];
    for (var i = 0; i < location.residents!.length; i++) {
      final result = await Dio().get(location.residents![i]);
      final response = Character.fromMap(result.data);
      characters.add(response);
      notifyListeners();
    }
    return characters;
  }
}
