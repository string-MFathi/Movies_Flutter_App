import 'package:flutter/material.dart';
import 'package:movies_bloc/bloc/get_playing_now_bloc.dart';
import 'package:movies_bloc/model/movie.dart';
import 'package:movies_bloc/model/movie_response.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:movies_bloc/style/theme.dart' as Style;

class PlayingNow extends StatefulWidget {
  @override
  _PlayingNowState createState() => _PlayingNowState();
}

class _PlayingNowState extends State<PlayingNow> {

  @override
  void initState() {
    super.initState();
    moviesPlayingNowBloc..getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MoviesResponse>(
        stream: moviesPlayingNowBloc.subject.stream,
        builder: (context, AsyncSnapshot<MoviesResponse> snapshot){
        if(snapshot.hasData){
          if(snapshot.data.error != null && snapshot.data.error.length > 0){
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildPlayingNowWidget(snapshot.data);
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

 Widget _buildPlayingNowWidget(MoviesResponse data){
    List<Movies> movies = data.movies;
    if(movies.length == 0){
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("No Movies"),
          ],
        ),
      );
    }else{
      return Container(
        height: 220,
        child: PageIndicatorContainer(
            align: IndicatorAlign.bottom,
            indicatorSpace: 8.0,
            padding: EdgeInsets.all(5),
            indicatorColor: Style.Colors.titleColor,
            indicatorSelectorColor: Style.Colors.secondColor,
            child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.take(5).length,
                itemBuilder: (context, index){
                  return Stack(
                    children: <Widget>[
                      Container(
                        height: 220.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(image: NetworkImage("https://image.tmdb.org/t/p/original/" + movies[index].backPoster),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  );
                }),
            length: movies.take(5).length,
        ),
      );
    }
 }
  }
