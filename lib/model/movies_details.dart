import 'package:movies_bloc/model/genre.dart';

class MoviesDetails{
  final int id;
  final bool adult;
  final int budget;
  final List<Genre> genre;
  final String releaseData;
  final int runtime;

  MoviesDetails(
      this.id,
      this.genre,
      this.adult,
      this.budget,
      this.releaseData,
      this.runtime,
      );

  MoviesDetails.fromJson(Map<String, dynamic> json)
  : id = json['id'],
  adult = json['adult'],
  budget = json['budget'],
  genre = (json['genre'] as List).map((i) => new Genre.fromJson(i)).toList(),
  releaseData = json['releaseData'],
  runtime = json['runtime'];
}
