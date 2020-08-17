import 'package:flutter/material.dart';
import 'package:movies_bloc/model/movie_details_response.dart';
import 'package:movies_bloc/repository/respository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesDetailsBloc{
  final MoviesRepository _repository = MoviesRepository();
  final BehaviorSubject<MoviesDetailsResponse> _subject = BehaviorSubject<MoviesDetailsResponse>();


  getMoviesDetails(int id) async {
    MoviesDetailsResponse response = await _repository.getMoviesDetails(id);
    _subject.sink.add(response);
  }

  void drainStream(){_subject.value = null;}
  @mustCallSuper

  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<MoviesDetailsResponse> get subject => _subject;

}

final moviesDetailsBloc = MoviesDetailsBloc();