class Person{
  final int id;
  final double popularity;
  final String name;
  final String profileImg;
  final String known;


  Person({this.id, this.name, this.profileImg, this.known, this.popularity});

  Person.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        popularity = json["popularity"],
        name = json["name"],
        profileImg = json["profileImage"],
        known = json["known"];
}