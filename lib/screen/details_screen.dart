import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_bloc/bloc/get_movies_videos_bloc.dart';
import 'package:movies_bloc/model/movie.dart';
import 'package:movies_bloc/model/video_response.dart';
import 'package:movies_bloc/model/videos.dart';
import 'package:movies_bloc/screen/video_player.dart';
import 'package:movies_bloc/style/theme.dart' as Style;
import 'package:movies_bloc/widget/casts.dart';
import 'package:movies_bloc/widget/movie_info.dart';
import 'package:movies_bloc/widget/similar_movies.dart';
import 'package:sliver_fab/sliver_fab.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailsScreen extends StatefulWidget {

  final Movies movie;
  DetailsScreen({Key key, @required this.movie,}) : super (key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState(movie);
}

class _DetailsScreenState extends State<DetailsScreen> {
  final Movies movie;
  _DetailsScreenState(this.movie);
@override
  void initState() {
  super.initState();

  moviesVideosBloc..getMoviesVideos(movie.id);
  }

  @override
  void dispose() {
    super.dispose();
    moviesVideosBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      body: Builder(
          builder: (context){
            return SliverFab(
              floatingPosition: FloatingPosition(right: 20.0),
                floatingWidget: StreamBuilder<VideoResponse>(
                  stream: moviesVideosBloc.subject.stream,
                    builder: (context, AsyncSnapshot<VideoResponse> snapshot){
                    if(snapshot.hasData){
                      if(snapshot.data.error != null && snapshot.data.error.length > 0){
                        return _buildErrorWidget(snapshot.data.error);
                      }
                      return _buildVideoWidget(snapshot.data);
                    } else if(snapshot.hasError){
                      return _buildErrorWidget(snapshot.error);
                    }else {
                      return _buildLoadingWidget();
                    }
                    }
                ),

              expandedHeight: 200.0,
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Style.Colors.mainColor,
                  expandedHeight: 200.0,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      movie.title.length> 40 ?
                          movie.title.substring(0, 37) + "..."
                          : movie.title,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    background: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(image: NetworkImage(
                              "https://image.tmdb.org/t/p/original/" + movie.backPoster,
                            ),),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.9),
                                Colors.black.withOpacity(0.0),
                              ]
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SliverPadding(
                    padding: EdgeInsets.all(0.0),
                  sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Padding(
                              padding: EdgeInsets.only(left: 10, top: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  movie.rating.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 5.0,),

                                RatingBar(
                                  itemSize: 10.0,
                                  initialRating: movie.rating /2,
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
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left: 10, top: 20),
                            child: Text(
                              'OVERVIEW',
                              style: TextStyle(
                                color: Style.Colors.titleColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                          SizedBox(height: 5.0,),

                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              movie.overview,
                              style: TextStyle(
                                height: 1.5,
                                fontSize: 12.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0,),
                          MovieInfo(id: movie.id,),
                          Casts(id: movie.id,),
                          SimilarMovies(id: movie.id,),
                        ]
                      ),
                  ),
                ),
              ],
            );
          }
      ),
    );
  }

  Widget _buildLoadingWidget(){
  return Container();
  }

  Widget _buildErrorWidget(String error){
  return Center(
    child: Column(
      children: <Widget>[
        Text('$error'),
      ],
    ),
  );
  }

  Widget _buildVideoWidget(VideoResponse data){
   List<Videos> videos = data.videos;
   return FloatingActionButton(
       backgroundColor: Style.Colors.secondColor,
       child: Icon(Icons.play_arrow),
       onPressed: (){
         Navigator.push(context, MaterialPageRoute(
             builder: (context) => VideoPlayer(controller: YoutubePlayerController(
               initialVideoId: videos[0].key,
               flags: YoutubePlayerFlags(
                 forceHD: true,
                 autoPlay: true,
               ),
             ),),
         ),);
       },
   );
  }
}
