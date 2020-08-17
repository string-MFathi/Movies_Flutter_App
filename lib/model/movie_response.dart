import 'package:movies_bloc/model/movie.dart';

class MoviesResponse{
 final List<Movies> movies;
 final String error;

 MoviesResponse(this.error, this.movies);

 MoviesResponse.fromJson(Map<String, dynamic> json)
  : movies =
             json["result"] != null? new List<Movies>.from((json["result"] as List).map((i) => new Movies.fromJson(i)).toList(),) : List<Movies>(),

    error = "";

 MoviesResponse.withError(String errorValue)
     :  movies = List(),
      error = errorValue;
}
