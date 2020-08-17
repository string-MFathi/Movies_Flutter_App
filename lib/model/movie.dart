class Movies{
  final int id;
  final double popularity;
  final String title;
  final String backPoster;
  final String poster;
  final String overview;
  final double rating;

  Movies({this.id, this.title, this.backPoster, this.overview, this.popularity, this.poster, this.rating});

  Movies.fromJson(Map<String, dynamic> json)
  : id = json["id"],
  popularity = json["popularity"],
  title = json["title"],
  backPoster = json["backPoster"],
  poster = json["poster"],
  overview = json["overview"],
  rating = json["rating"].toDouble();
}