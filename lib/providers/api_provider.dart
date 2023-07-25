import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty/models/character.dart';

class ApiProvider with ChangeNotifier {
  final url = "https://rickandmortyapi.com";
  List<Character> characters = [];
  Future<void> getCharacter() async {
    final result = await Dio().get("$url/api/character");
    final response = CharacterResponse.fromMap(result.data);
    characters.addAll(response.results!);
    notifyListeners();
  }
}
