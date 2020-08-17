import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_bloc/bloc/get_movies_byGenres_bloc.dart';
import 'package:movies_bloc/model/movie.dart';
import 'package:movies_bloc/model/movie_response.dart';
import 'package:movies_bloc/model/movies_details.dart';
import 'package:movies_bloc/screen/details_screen.dart';
import 'package:movies_bloc/style/theme.dart' as Style;

class GenreMovie extends StatefulWidget {
  final int genreId;
  GenreMovie({Key key, @required this.genreId})
  : super (key: key);

  @override
  _GenreMovieState createState() => _GenreMovieState(genreId);
}

class _GenreMovieState extends State<GenreMovie> {
  final int genreId;
  _GenreMovieState(this.genreId);
  @override
  void initState() {
    super.initState();
    moviesByGenresBloc..getMoviesByGenres(genreId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MoviesResponse>(
        stream: moviesByGenresBloc.subject.stream,
        builder: (context, AsyncSnapshot<MoviesResponse> snapshot){
          if(snapshot.hasData){
            if(snapshot.data.error != null && snapshot.data.error.length > 0){
              return _buildErrorWidget(snapshot.data.error);
            }
            return _buildMoviesByGenreWidget(snapshot.data);
          }else if(snapshot.hasError){
            return _buildErrorWidget(snapshot.error);
          }else{
            return _buildLoadingWidget();
          }
        }
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String error){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Error: $error"),
        ],
      ),
    );
  }

  Widget _buildMoviesByGenreWidget(MoviesResponse data){
    List<Movies> movie = data.movies;
    if(movie.length == 0){
      return Container(
        child: Text('No Movies'),
      );
    }else
      return Container(
        height: 270,
        padding: EdgeInsets.only(left: 10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
            itemCount: movie.length,

            itemBuilder:(context, index){
            return Padding(
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
                right: 10,
              ),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => DetailsScreen(movie: movie[index]),
                  ),);
                },
                child: Column(
                  children: <Widget>[
                   movie[index].poster == null ?
                       Container(
                         height: 180,
                         width: 120,
                         decoration: BoxDecoration(
                          color: Style.Colors.secondColor,
                           borderRadius: BorderRadius.all(Radius.circular(2.0)),
                           shape: BoxShape.rectangle,
                         ),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: <Widget>[
                             Icon(EvaIcons.filmOutline, color: Colors.white, size: 50,),
                           ],
                         ),
                       ) :
                       Container(
                         width: 120,
                         height: 180,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.all(Radius.circular(2.0)),
                           shape: BoxShape.rectangle,
                           image: DecorationImage(
                               image: NetworkImage("https://image.tmdb.org/t/p/w200/" + movie[index].poster),
                               fit: BoxFit.cover,
                           ),
                         ),
                       ),
                    SizedBox(height: 10,),
                    Container(
                      width: 100,
                      child: Text(
                        movie[index].title,
                        maxLines: 2,
                        style: TextStyle(
                          height: 1.4,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ),

                    SizedBox(height: 5.0,),
                    Row(
                      children: <Widget>[
                        Text(
                          movie[index].rating.toString(),
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: 10.0,
                           fontWeight: FontWeight.bold,
                         ),
                        ),
                        SizedBox(width: 5.0,),
                        RatingBar(
                          itemSize: 8.0,
                            initialRating: movie[index].rating /2,
                            minRating: 1.0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                          itemBuilder: (context, _) => Icon(
                            EvaIcons.star,
                            color: Style.Colors.secondColor,
                          ),
                            onRatingUpdate: (rating){
                              print(rating);
                            },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
            }
        ),
      );
  }
}
