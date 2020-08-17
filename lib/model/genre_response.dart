import 'package:movies_bloc/model/genre.dart';

class GenreResponse {
  final List<Genre> genre;
  final String error;

  GenreResponse({this.error, this.genre});

  GenreResponse.fromJson(Map<String, dynamic> json)
      : genre =
  json["result"] != null
      ? new List<Genre>.from(
    (json["result"] as List).map((i) => new Genre.fromJson(i).toString()),)
      : List<Genre>(),

        error = "";


  GenreResponse.withError(String errorValue)
      : genre = List(),
        error = errorValue;
}
