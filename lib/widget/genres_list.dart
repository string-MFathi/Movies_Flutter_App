import 'package:flutter/material.dart';
import 'package:movies_bloc/bloc/get_movies_byGenres_bloc.dart';
import 'package:movies_bloc/model/genre.dart';
import 'package:movies_bloc/style/theme.dart' as Style;
import 'package:movies_bloc/widget/genre_movie.dart';


class GenresList extends StatefulWidget {

  final List<Genre> genres;
  GenresList({Key key, @required this.genres})
  : super (key: key);

  @override
  _GenresListState createState() => _GenresListState(genres);
}

class _GenresListState extends State<GenresList> with SingleTickerProviderStateMixin {
  final List<Genre> genres;
  TabController _tabController;
  _GenresListState(this.genres);
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: genres.length, vsync: this);
    _tabController.addListener(() {
     if(_tabController.indexIsChanging){
       moviesByGenresBloc.drainStream();
       
     }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 307.0,
      child: DefaultTabController(
          length: genres.length,
          child: Scaffold(
            backgroundColor: Style.Colors.mainColor,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: AppBar(
                backgroundColor: Style.Colors.mainColor,
                bottom: TabBar(
                  controller: _tabController,
                    indicatorColor: Style.Colors.secondColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 3.0,
                    unselectedLabelColor: Style.Colors.titleColor,
                    labelColor: Colors.white,
                    isScrollable: true,
                    tabs:genres.map((Genre genre) {
                      return Container(
                        padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                        child: Text(genre.name.toUpperCase(), style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),),

                      );
                    }).toList(),
                ),
              ),
            ),
            body: TabBarView(
              controller: _tabController,
                physics: NeverScrollableScrollPhysics(),
                children: genres.map((Genre genre ){
                   return GenreMovie(genreId: genre.id );
                }).toList(),
            ),
          ),
      ),
    );
  }
}
