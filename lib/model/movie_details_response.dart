import 'package:movies_bloc/model/movies_details.dart';

class MoviesDetailsResponse{
  final MoviesDetails movieDetails;
  final String error;

  MoviesDetailsResponse(this.movieDetails, this.error);

  MoviesDetailsResponse.fromJson(Map<String, dynamic> json)
  : movieDetails = MoviesDetails.fromJson(json),

  error = "";

  MoviesDetailsResponse.withError(String errorValue)
  : movieDetails = MoviesDetails(null, null, null, null, '', null),
  error = errorValue;
}