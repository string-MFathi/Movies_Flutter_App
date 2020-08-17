import 'package:movies_bloc/model/videos.dart';

class VideoResponse{
  final List<Videos> videos;
  final String error;

  VideoResponse(this.videos, this.error);

  VideoResponse.fromJson(Map<String, dynamic> json)
  : videos = (json['result'] as List).map((i) => Videos.fromJson(i)).toList(),
  error = "";

  VideoResponse.withError(String errorValue)
  : videos = List(),
  error = errorValue;
}