import 'package:movies_bloc/model/movie_response.dart';
import 'package:movies_bloc/repository/respository.dart';
import 'package:rxdart/rxdart.dart';

class PlayingNowListBloc{
  final MoviesRepository _repository = MoviesRepository();
  final BehaviorSubject<MoviesResponse> _subject = BehaviorSubject<MoviesResponse>();

  getMovies() async {
    MoviesResponse response = await _repository.getPlayingMovie();
    _subject.sink.add(response);
  }

  dispose(){
    _subject.close();
  }

  BehaviorSubject<MoviesResponse> get subject => _subject;
}

final moviesPlayingNowBloc = PlayingNowListBloc();