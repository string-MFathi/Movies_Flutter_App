import 'package:dio/dio.dart';
import 'package:movies_bloc/model/cast_response.dart';
import 'package:movies_bloc/model/genre_response.dart';
import 'package:movies_bloc/model/movie_details_response.dart';
import 'package:movies_bloc/model/movie_response.dart';
import 'package:movies_bloc/model/person_response.dart';
import 'package:movies_bloc/model/video_response.dart';

class MoviesRepository{
  final String apiKey = "1fc21e13b471c1ae393ebbb2bd22ffc0";
  static String mainUrl = "https://api.themoviedb.org/3";
  final Dio _dio = Dio();
  var getTopRatedUrl = '$mainUrl/movie/top_rated';
  var getDiscoverUrl = '$mainUrl/discover/movie';
  var getPlayingUrl = '$mainUrl/movie/now_playing';
  var getGenresUrl = '$mainUrl/genre/movie/list';
  var getPersonsUrl = '$mainUrl/trending/person/week';
  var moviesUrl = '$mainUrl/movie';

  Future <MoviesResponse> getMovies() async {
    var params = {
      "api_key" : apiKey,
      "language" : "en-US",
      "page: " : 1,
    };
    try{
      Response response = await _dio.get(getTopRatedUrl, queryParameters: params);
      return MoviesResponse.fromJson(response.data);
    } catch(error, stackTrace){
      print("Exception $error stackTrace: $stackTrace");
      return MoviesResponse.withError("$error");
    }
  }

  Future <MoviesResponse> getPlayingMovie() async {
    var params = {
      "api_key" : apiKey,
      "language" : "en-US",
      "page: " : 1,
    };
    try{
      Response response = await _dio.get(getPlayingUrl, queryParameters: params);
      return MoviesResponse.fromJson(response.data);
    } catch(error, stackTrace){
      print("Exception $error stackTrace: $stackTrace");
      return MoviesResponse.withError("$error");
    }
  }

  Future <GenreResponse> getGenre() async {
    var params = {
      "api_key" : apiKey,
      "language" : "en-US",
      "page: " : 1,
    };
    try{
      Response response = await _dio.get(getGenresUrl, queryParameters: params);
      return GenreResponse.fromJson(response.data);
    } catch(error, stackTrace){
      print("Exception $error stackTrace: $stackTrace");
      return GenreResponse.withError("$error");
    }
  }

  Future <PersonResponse> getPerson() async {
    var params = {
      "api_key" : apiKey,
    };
    try{
      Response response = await _dio.get(getPersonsUrl, queryParameters: params);
      return PersonResponse.fromJson(response.data);
    } catch(error, stackTrace){
      print("Exception $error stackTrace: $stackTrace");
      return PersonResponse.withError("$error");
    }
  }

  Future <MoviesResponse> getMovieByGenre(int id) async {
    var params = {
      "api_key" : apiKey,
      "language" : "en-US",
      "page: " : 1,
      "with_genres" : id,
    };
    try{
      Response response = await _dio.get(getDiscoverUrl, queryParameters: params);
      return MoviesResponse.fromJson(response.data);
    } catch(error, stackTrace){
      print("Exception $error stackTrace: $stackTrace");
      return MoviesResponse.withError("$error");
    }
  }

  Future<MoviesDetailsResponse> getMoviesDetails(int id) async {
    var params = {
      "api_key" : apiKey,
      "language" : "en-US",
    };
    try {
      Response response = await _dio.get(mainUrl + "/$id" , queryParameters: params);
      return MoviesDetailsResponse.fromJson(response.data);
    }catch(error, stackTrack){
      print("Exception $error stackTrace: $stackTrack");
      return MoviesDetailsResponse.withError("$error");
    }
  }

  Future<CastResponse> getCasts(int id) async {
    var params = {
      "api_key" : apiKey,
      "language" : "en-US",
    };
    try {
      Response response = await _dio.get(mainUrl + "/$id" + "/credits", queryParameters: params);
      return CastResponse.fromJson(response.data);
    }catch(error, stackTrack){
      print("Exception $error stackTrace: $stackTrack");
      return CastResponse.withError("$error");
    }
  }

  Future<MoviesResponse> getSimilarMovies(int id) async {
    var params = {
      "api_key" : apiKey,
      "language" : "en-US",
    };
    try {
      Response response = await _dio.get(mainUrl + "/$id" + "/similar", queryParameters: params);
      return MoviesResponse.fromJson(response.data);
    }catch(error, stackTrack){
      print("Exception $error stackTrace: $stackTrack");
      return MoviesResponse.withError("$error");
    }
  }

  Future<VideoResponse> getMoviesVideo(int id) async {
    var params = {
      "api_key" : apiKey,
      "language" : "en-US",
    };
    try {
      Response response = await _dio.get(mainUrl + "/$id" + "/similar", queryParameters: params);
      return VideoResponse.fromJson(response.data);
    }catch(error, stackTrack){
      print("Exception $error stackTrace: $stackTrack");
      return VideoResponse.withError("$error");
    }
  }
}

