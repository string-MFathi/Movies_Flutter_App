import 'package:movies_bloc/model/cast.dart';

class CastResponse{
  final List<Cast> Casts;
  final String error;

  CastResponse(this.Casts, this.error);

  CastResponse.fromJson(Map<String, dynamic> json)
   : Casts = (json["casts"] as List).map((i) => new Cast.fromJson(i)).toList(),
  error = "";


  CastResponse.withError(String errorValue)
  : Casts = List(),
  error = errorValue;
}