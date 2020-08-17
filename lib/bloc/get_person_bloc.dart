import 'package:movies_bloc/model/movie_response.dart';
import 'package:movies_bloc/model/person_response.dart';
import 'package:movies_bloc/repository/respository.dart';
import 'package:rxdart/rxdart.dart';

class PersonListBloc{
  final MoviesRepository _repository = MoviesRepository();
  final BehaviorSubject<PersonResponse> _subject = BehaviorSubject<PersonResponse>();

  getPerson() async {
    PersonResponse response = await _repository.getPerson();
    _subject.sink.add(response);
  }

  dispose(){
    _subject.close();
  }

  BehaviorSubject<PersonResponse> get subject => _subject;
}

final personBloc = PersonListBloc();