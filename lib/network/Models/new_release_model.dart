import 'package:movies/Domain/Entities/new_releases_entity.dart';

class NewReleaseModel extends NewReleasesEntity {
  NewReleaseModel({required super.poster});

  factory NewReleaseModel.fromJson(Map<String, dynamic> json) =>
      NewReleaseModel(poster: "https://image.tmdb.org/t/p/original${json['poster_path']}");
}
