import 'package:flutter/cupertino.dart';

class PopularEntity{
  int id;
  bool state;
  String backDrop;
  String poster;
  String title;
  String overview;
  double voteAverage;
  String date;
  var categories;
  String? context;


  PopularEntity(
      {
        this.context,
        required this.id,
        required this.state,
        this.categories,
        required this.backDrop,
        required this.poster,
        required this.title,
        required this.overview,
        required this.voteAverage,
        required this.date
      });
}