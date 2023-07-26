// To parse this JSON data, do
//
//     final episodes = episodesFromMap(jsonString);

import 'dart:convert';

class EpisodesResponse {
  Info? info;
  List<Episode>? results;

  EpisodesResponse({
    this.info,
    this.results,
  });

  factory EpisodesResponse.fromJson(String str) =>
      EpisodesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EpisodesResponse.fromMap(Map<String, dynamic> json) =>
      EpisodesResponse(
        info: json["info"] == null ? null : Info.fromMap(json["info"]),
        results: json["results"] == null
            ? []
            : List<Episode>.from(
                json["results"]!.map((x) => Episode.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "info": info?.toMap(),
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toMap())),
      };
}

class Info {
  int? count;
  int? pages;
  String? next;
  dynamic prev;

  Info({
    this.count,
    this.pages,
    this.next,
    this.prev,
  });

  factory Info.fromJson(String str) => Info.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Info.fromMap(Map<String, dynamic> json) => Info(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
      );

  Map<String, dynamic> toMap() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
      };
}

class Episode {
  int? id;
  String? name;
  String? airDate;
  String? episode;
  List<String>? characters;
  String? url;
  DateTime? created;

  Episode({
    this.id,
    this.name,
    this.airDate,
    this.episode,
    this.characters,
    this.url,
    this.created,
  });

  factory Episode.fromJson(String str) => Episode.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Episode.fromMap(Map<String, dynamic> json) => Episode(
        id: json["id"],
        name: json["name"],
        airDate: json["air_date"],
        episode: json["episode"],
        characters: json["characters"] == null
            ? []
            : List<String>.from(json["characters"]!.map((x) => x)),
        url: json["url"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "air_date": airDate,
        "episode": episode,
        "characters": characters == null
            ? []
            : List<dynamic>.from(characters!.map((x) => x)),
        "url": url,
        "created": created?.toIso8601String(),
      };
}
