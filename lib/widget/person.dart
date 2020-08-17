import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies_bloc/bloc/get_person_bloc.dart';
import 'package:movies_bloc/model/person.dart';
import 'package:movies_bloc/model/person_response.dart';
import 'package:movies_bloc/style/theme.dart' as Style;

class PersonList extends StatefulWidget {
  @override
  _PersonListState createState() => _PersonListState();
}

class _PersonListState extends State<PersonList> {

  @override
  void initState() {
    super.initState();
    personBloc.getPerson();

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10, top: 20),
          child: Text("TRENDING PERSONS ON THIS WEEK",
            style: TextStyle(
            color: Style.Colors.titleColor,
            fontWeight: FontWeight.w500,
            fontSize: 12.0,
          ),),
        ),

        SizedBox(height: 5.0,),

        StreamBuilder<PersonResponse>(
          stream: personBloc.subject.stream,
          builder: (context, AsyncSnapshot<PersonResponse> snapshot){
             if(snapshot.hasData){
             if(snapshot.data.error != null && snapshot.data.error.length > 0){
            return _buildErrorWidget(snapshot.data.error);
          }
           return _buildPersonWidget(snapshot.data);
         }else if(snapshot.hasError){
        return _buildErrorWidget(snapshot.error);
       }else{
        return _buildLoadingWidget();
       }
      }
    ),
      ],
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

  Widget _buildPersonWidget(PersonResponse data){
    List<Person> person = data.persons;
    return Container(
      height: 130.0,
      padding: EdgeInsets.only(left: 10),
      child: ListView.builder(
        itemCount: person.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index){
            return Container(
              width: 100,
              child: Padding(
                padding: EdgeInsets.only(top: 10, right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                     person[index].profileImg == null ?
                       Container(
                         width: 70.0,
                         height: 70.0,
                         decoration: BoxDecoration(
                           shape: BoxShape.circle,
                           color: Style.Colors.secondColor,
                         ),
                         child: Icon(FontAwesomeIcons.userAlt, color: Colors.white,),
                       ) :
                       Container(
                         width: 70.0,
                         height: 70.0,
                         decoration: BoxDecoration(
                           shape: BoxShape.circle,
                           image: DecorationImage(image:  NetworkImage("https://image.tmdb.org/t/p/w200" + person[index].profileImg),
                           fit: BoxFit.cover,
                           ),
                         ),
                       ),
                  SizedBox(height: 10,),

                    Text(
                      person[index].name,
                      maxLines: 2,
                      style: TextStyle(
                        height: 1.4,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 9.0,
                      ),
                    ),
                    SizedBox(height: 3.0,),

                    Text(
                      "Trending for ${person[index].known}",
                      style: TextStyle(
                        color: Style.Colors.titleColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 7.0,
                      ),
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
