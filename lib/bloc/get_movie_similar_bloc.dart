import 'package:flutter/material.dart';
import 'package:movies_bloc/model/movie_response.dart';
import 'package:movies_bloc/repository/respository.dart';
import 'package:rxdart/rxdart.dart';

class SimilarMoviesBloc{
  final MoviesRepository _repository = MoviesRepository();
  final BehaviorSubject<MoviesResponse> _subject = BehaviorSubject<MoviesResponse>();


  getSimilarMovies(int id) async {
    MoviesResponse response = await _repository.getSimilarMovies(id);
    _subject.sink.add(response);
  }

  void drainStream(){_subject.value = null;}
  @mustCallSuper

  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<MoviesResponse> get subject => _subject;

}

final similarMoviesBloc = SimilarMoviesBloc();