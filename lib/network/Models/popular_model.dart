import '../../Domain/Entities/popular_entites.dart';

class PopularModel extends PopularEntity{
  PopularModel({super.context,required super.state,required super.id,super.categories,required super.date,required super.backDrop, required super.poster, required super.title, required super.overview, required super.voteAverage});



  factory PopularModel.fromJson(Map<String, dynamic> json) {
    return PopularModel(
      state: false,
      id: json['id'],
      categories: json['genre_ids'],
      date: json['release_date']??"",
      backDrop: "https://image.tmdb.org/t/p/original${json['backdrop_path']}",
      poster: "https://image.tmdb.org/t/p/original${json['poster_path']}",
      title: json['title'],
      overview: json['overview'],
      voteAverage: json['vote_average'],
    );
  }


}