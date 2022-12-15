// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';
import 'package:anda_chill/models/models.dart';

Map<String, Post> postFromJson(String str) => Map.from(json.decode(str))
    .map((k, v) => MapEntry<String, Post>(k, Post.fromJson(v)));

String postToJson(Map<String, Post> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Post {
  Post(
      {required this.disponible,
      required this.nombre,
      this.picture,
      required this.precio,
      this.id});

  bool disponible;
  String nombre;
  String? picture;
  double precio;
  String? id;

  factory Post.fromJson(String str) => Post.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Post.fromMap(Map<String, dynamic> json) => Post(
        disponible: json["Disponible"],
        nombre: json["Nombre"],
        picture: json["Picture"],
        precio: json["Precio"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "Disponible": disponible,
        "Nombre": nombre,
        "Picture": picture,
        "Precio": precio,
      };

  Post copy() => Post(
        disponible: this.disponible,
        nombre: this.nombre,
        picture: this.picture,
        precio: this.precio,
        id: id,
      );
}
