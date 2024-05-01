import 'package:movies/Domain/Entities/recomended_entity.dart';

class RecomendedModel extends RecommendedEntities {
  RecomendedModel(
      {required super.image, required super.title, required super.publishAt,required super.reviews});

  factory RecomendedModel.fromJson(Map<String, dynamic> json) =>
      RecomendedModel(
          image: "https://image.tmdb.org/t/p/original${json['poster_path']}",
          title: json['title'],
          publishAt: json['release_date'],
          reviews: json['vote_average'],
      );
}