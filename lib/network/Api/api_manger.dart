
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:movies/Domain/Entities/category_entity.dart';
import 'package:movies/Domain/Entities/new_releases_entity.dart';
import 'package:movies/Domain/Entities/popular_entites.dart';
import 'package:movies/Domain/Entities/recomended_entity.dart';
import 'package:movies/core/config/constants.dart';
import 'package:movies/network/Models/category_model.dart';
import 'package:movies/network/Models/new_release_model.dart';
import 'package:movies/network/Models/recomended_model.dart';

import '../Models/popular_model.dart';

class ApiManager {


 static Future<List<PopularEntity>> getPopular() async {
   const String url = 'https://api.themoviedb.org/3/movie/popular?language=en-US&page=1';
   const String token = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzODg1OTBiMTM5NjBlZTk3MDEwYmFmMTY1ODdmNTcxMCIsInN1YiI6IjY2MGMxN2FiMTQ5NTY1MDE3ZGJiM2RjMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.o9bZiJj-Bi7UAOt71PfDSzeP-bMp3XpUBrav2JNrY0E';


   var response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': token,
      'accept': 'application/json',
    },
   );

   List<PopularEntity> popularList =[];
   if(response.statusCode==200){
     var data = json.decode(response.body);
     List sources = data["results"];
     for (var i in sources){
        popularList.add(PopularModel.fromJson(i));
     }
     }

  return popularList;
 }

 static Future<List<NewReleasesEntity>> newRelease() async{
   const String url = 'https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1';
   const String token = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzODg1OTBiMTM5NjBlZTk3MDEwYmFmMTY1ODdmNTcxMCIsInN1YiI6IjY2MGMxN2FiMTQ5NTY1MDE3ZGJiM2RjMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.o9bZiJj-Bi7UAOt71PfDSzeP-bMp3XpUBrav2JNrY0E';
   var response = await http.get(
     Uri.parse(url),
     headers: {
       'Authorization': token,
       'accept': 'application/json',
     },
   );
   List<NewReleasesEntity> NewReleaseList =[];
   if(response.statusCode==200){
     var data = json.decode(response.body);
     List sources = data["results"];
     for (var i in sources){
       NewReleaseList.add(NewReleaseModel.fromJson(i));
     }
   }
  // print(popularList);
   return NewReleaseList;
   }

   static Future<List<PopularEntity>> recomended() async {

   const String url = 'https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1';
   const String token = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzODg1OTBiMTM5NjBlZTk3MDEwYmFmMTY1ODdmNTcxMCIsInN1YiI6IjY2MGMxN2FiMTQ5NTY1MDE3ZGJiM2RjMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.o9bZiJj-Bi7UAOt71PfDSzeP-bMp3XpUBrav2JNrY0E';
   var response = await http.get(
     Uri.parse(url),
     headers: {
       'Authorization': token,
       'accept': 'application/json',
     },

   );
   List<PopularEntity> RecomendedList =[];
   if(response.statusCode==200){
     var data = json.decode(response.body);
     List sources = data["results"];
     for (var i in sources){
       RecomendedList.add(PopularModel.fromJson(i));
     }
   }

   return RecomendedList;

 }

 static Future<List<String>> categoryNames(List<dynamic>? ids) async{
   const String url = 'https://api.themoviedb.org/3/genre/movie/list?language=en';
   const String token = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzODg1OTBiMTM5NjBlZTk3MDEwYmFmMTY1ODdmNTcxMCIsInN1YiI6IjY2MGMxN2FiMTQ5NTY1MDE3ZGJiM2RjMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.o9bZiJj-Bi7UAOt71PfDSzeP-bMp3XpUBrav2JNrY0E';
   var response = await http.get(
     Uri.parse(url),
     headers: {
       'Authorization': token,
       'accept': 'application/json',
     },

   );
   List<String> categories = [];
   if(response.statusCode==200){
     var data = json.decode(response.body);
     List sources = data["genres"];
     for (var i in sources){
       if(ids!.contains(i["id"])){
         categories.add(i["name"]);
       }
     }
   }
   return categories;
 }



 static Future<List<CategoriesEntity>> allCategoryNames() async{
   const String url = 'https://api.themoviedb.org/3/genre/movie/list?language=en';
   const String token = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzODg1OTBiMTM5NjBlZTk3MDEwYmFmMTY1ODdmNTcxMCIsInN1YiI6IjY2MGMxN2FiMTQ5NTY1MDE3ZGJiM2RjMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.o9bZiJj-Bi7UAOt71PfDSzeP-bMp3XpUBrav2JNrY0E';
   var response = await http.get(
     Uri.parse(url),
     headers: {
       'Authorization': token,
       'accept': 'application/json',
     },

   );
   List<CategoriesEntity> categories = [];
   if(response.statusCode==200){
     var data = json.decode(response.body);
     List sources = data["genres"];
     for (var i in sources){
       categories.add(CategoriesModel.fromJson(i));

     }
   }
   return categories;
 }

 Future<List<PopularEntity>> search(String id) async{
   String url = 'https://api.themoviedb.org/3/search/movie?query=$id&include_adult=false&language=en-US&page=1';
   const String token = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzODg1OTBiMTM5NjBlZTk3MDEwYmFmMTY1ODdmNTcxMCIsInN1YiI6IjY2MGMxN2FiMTQ5NTY1MDE3ZGJiM2RjMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.o9bZiJj-Bi7UAOt71PfDSzeP-bMp3XpUBrav2JNrY0E';
   var response = await http.get(
     Uri.parse(url),
     headers: {
       'Authorization': token,
       'accept': 'application/json',
     },
   );
   List<PopularEntity> popularList =[];
   if(response.statusCode==200){
     var data = json.decode(response.body);
     List sources = data["results"];
     for (var i in sources){
         popularList.add(PopularModel.fromJson(i));
       }}
   print(popularList);
   return popularList;



 }


 static Future<List<PopularEntity>> getSpecificCategories(int id) async {
   const String url = 'https://api.themoviedb.org/3/movie/popular?language=en-US&page=1';
   const String token = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzODg1OTBiMTM5NjBlZTk3MDEwYmFmMTY1ODdmNTcxMCIsInN1YiI6IjY2MGMxN2FiMTQ5NTY1MDE3ZGJiM2RjMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.o9bZiJj-Bi7UAOt71PfDSzeP-bMp3XpUBrav2JNrY0E';


   var response = await http.get(
     Uri.parse(url),
     headers: {
       'Authorization': token,
       'accept': 'application/json',
     },
   );

   List<PopularEntity> popularList =[];
   if(response.statusCode==200){
     var data = json.decode(response.body);
     List sources = data["results"];
     for (var i in sources){
       if(i["genre_ids"].contains(id)){
       popularList.add(PopularModel.fromJson(i));
     }
   }
 }
   return popularList;

}}


