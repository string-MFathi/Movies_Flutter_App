import 'package:flutter/material.dart';
import 'package:movies_bloc/model/cast_response.dart';
import 'package:movies_bloc/model/video_response.dart';
import 'package:movies_bloc/repository/respository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesVideosBloc{
  final MoviesRepository _repository = MoviesRepository();
  final BehaviorSubject<VideoResponse> _subject = BehaviorSubject<VideoResponse>();


  getMoviesVideos(int id) async {
    VideoResponse response = await _repository.getMoviesVideo(id);
    _subject.sink.add(response);
  }

  void drainStream(){_subject.value = null;}
  @mustCallSuper

  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<VideoResponse> get subject => _subject;

}

final moviesVideosBloc = MoviesVideosBloc();