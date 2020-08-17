import 'package:flutter/cupertino.dart';
import 'package:movies_bloc/model/movie_response.dart';
import 'package:movies_bloc/repository/respository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesByGenresListBloc{
  final MoviesRepository _repository = MoviesRepository();
  final BehaviorSubject<MoviesResponse> _subject = BehaviorSubject<MoviesResponse>();

  getMoviesByGenres(int id) async {
    MoviesResponse response = await _repository.getMovieByGenre(id);
    _subject.sink.add(response);
  }

  void drainStream() {_subject.value = null;}
  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<MoviesResponse> get subject => _subject;
}

final moviesByGenresBloc = MoviesByGenresListBloc();