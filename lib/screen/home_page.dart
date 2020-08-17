import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movies_bloc/style/theme.dart' as Style;
import 'package:movies_bloc/widget/genres_screen.dart';
import 'package:movies_bloc/widget/person.dart';
import 'package:movies_bloc/widget/playing_now.dart';
import 'package:movies_bloc/widget/top_movies.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        centerTitle: true,
        leading: Icon(Icons.menu, color: Colors.white,),
        title: Text('Movies'),
        actions: <Widget>[
          IconButton(
            onPressed: null,
            icon: Icon(EvaIcons.searchOutline, color: Colors.white),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          PlayingNow(),
          Genres(),
          PersonList(),
          TopMovies(),
        ],
      ),
    );
  }
}
