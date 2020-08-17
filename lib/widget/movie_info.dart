import 'package:flutter/material.dart';
import 'package:movies_bloc/bloc/get_movie_details_bloc.dart';
import 'package:movies_bloc/model/movie_details_response.dart';
import 'package:movies_bloc/model/movies_details.dart';
import 'package:movies_bloc/style/theme.dart' as Style;

class MovieInfo extends StatefulWidget {
  final int id;
  MovieInfo({Key key, @required this.id,}) : super(key: key);

  @override
  _MovieInfoState createState() => _MovieInfoState(id);
}

class _MovieInfoState extends State<MovieInfo> {
  final int id;
  _MovieInfoState(this.id);

  @override
  void initState() {
    super.initState();
    moviesDetailsBloc..getMoviesDetails(id);
  }

  @override
  void dispose() {
    super.dispose();
    moviesDetailsBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<MoviesDetailsResponse>(
        stream: moviesDetailsBloc.subject.stream,
        builder: (context, AsyncSnapshot<MoviesDetailsResponse> snapshot){
          if(snapshot.hasData){
            if(snapshot.data.error != null && snapshot.data.error.length > 0){
              return _buildErrorWidget(snapshot.data.error);
            }
            return _buildMovieInfoWidget(snapshot.data);
          } else if(snapshot.hasError){
            return _buildErrorWidget(snapshot.error);
          }else {
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

  Widget _buildMovieInfoWidget(MoviesDetailsResponse data){
    MoviesDetails details = data.movieDetails;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'BUDGET',
                    style: TextStyle(
                      color: Style.Colors.titleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 10,),

                  Text(
                    details.budget.toString() + "\$",
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Style.Colors.secondColor,
                    ),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'DURATION',
                    style: TextStyle(
                      color: Style.Colors.titleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 10,),

                  Text(
                    details.runtime.toString() + "min",
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Style.Colors.secondColor,
                    ),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'RELEASE DATE',
                    style: TextStyle(
                      color: Style.Colors.titleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 10,),

                  Text(
                    details.releaseData,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Style.Colors.secondColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0,),

        Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'GENRES',
                style: TextStyle(
                  color: Style.Colors.titleColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0,
                ),
              ),

              Container(
                height: 30.0,
                padding: EdgeInsets.only( top: 5.0),
                child: ListView.builder(
                  itemCount: details.genre.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return Padding(
                      padding:EdgeInsets.only(right: 10.0),
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          border: Border.all(
                            width: 1.0,
                            color: Colors.white,
                          ),
                        ),
                        child: Text(
                          details.genre[index].name,
                          style: TextStyle(
                            fontSize: 9.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
