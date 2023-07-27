// To parse this JSON data, do
//
//     final locations = locationsFromMap(jsonString);

import 'dart:convert';

class LocationsResponse {
  Info? info;
  List<Location>? results;

  LocationsResponse({
    this.info,
    this.results,
  });

  factory LocationsResponse.fromJson(String str) =>
      LocationsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LocationsResponse.fromMap(Map<String, dynamic> json) =>
      LocationsResponse(
        info: json["info"] == null ? null : Info.fromMap(json["info"]),
        results: json["results"] == null
            ? []
            : List<Location>.from(
                json["results"]!.map((x) => Location.fromMap(x))),
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

class Location {
  int? id;
  String? name;
  String? type;
  String? dimension;
  List<String>? residents;
  String? url;
  DateTime? created;

  Location({
    this.id,
    this.name,
    this.type,
    this.dimension,
    this.residents,
    this.url,
    this.created,
  });

  factory Location.fromJson(String str) => Location.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        dimension: json["dimension"],
        residents: json["residents"] == null
            ? []
            : List<String>.from(json["residents"]!.map((x) => x)),
        url: json["url"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "type": type,
        "dimension": dimension,
        "residents": residents == null
            ? []
            : List<dynamic>.from(residents!.map((x) => x)),
        "url": url,
        "created": created?.toIso8601String(),
      };
}
