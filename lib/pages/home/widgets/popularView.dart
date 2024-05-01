import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movies/core/config/constants.dart';
import 'package:movies/network/Api/api_manger.dart';
import 'package:movies/network/Fire-base/fire-base-manger.dart';
import 'package:movies/network/Models/fire-store-Model.dart';
import 'package:movies/network/Models/popular_model.dart';
import 'package:movies/pages/home/pages/Movie_View.dart';

import '../../../Domain/Entities/popular_entites.dart';
import '../../../core/config/pages_Route_Name.dart';
import '../../../main.dart';

class PopularView extends StatefulWidget {
  bool x =false;
  PopularView({Key? key});

  @override
  State<PopularView> createState() => _PopularViewState();
}

class _PopularViewState extends State<PopularView> {
  List<int> ids=[];
  @override
  Widget build(BuildContext context) {
   if(ids.isEmpty) getState();
    return FutureBuilder(
      future: ApiManager.getPopular(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error.toString());
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        List<PopularEntity> data = snapshot.data ?? [];

        return Container(
          height: constants.mediaquery.height * 0.32,
          child: PageView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {

              return Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Positioned(
                      top: 0,
                      child: Container(
                        color: Color(0XFF282A28),
                        height: constants.mediaquery.height * 0.24,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: Image.network(
                          data[index].backDrop,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              InkWell(
                                onTap: () async{

                                  navigatorkey.currentState!.pushNamed(
                                      PageRouteName.movieView,
                                      arguments: PopularEntity(
                                         context: PageRouteName.home,
                                          state: false,
                                          id: data[index].id ,
                                          backDrop: data[index].backDrop,
                                          poster: data[index].poster,
                                          title: data[index].title,
                                          overview: data[index].overview,
                                          categories: data[index].categories,
                                          date: data[index].date,
                                          voteAverage:
                                          data[index].voteAverage));

                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0XFF282A28),
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                    image: DecorationImage(
                                      image: NetworkImage(data[index].poster),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.3,
                                  height: constants.mediaquery.height * 0.22,
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child:
                                  InkWell(
                                      onTap: () {
                                        getState();
                                        // Call the changeState method
                                           var movie = FireStoreModel(
                                              id: data[index].id,
                                              rate: data[index].voteAverage,
                                              name: data[index].title,
                                              year: data[index].date,
                                              image: data[index].poster,
                                              backDrop: data[index].backDrop,
                                              description: data[index].overview,
                                              categories:
                                                  data[index].categories);
                                          FireBaseManager().addMovie(movie);


                                      },
                                      child:ids.contains(data[index].id)? Image.asset(
                                          "assets/images/bookmarkSelected.png")
                                  :
                                      Image.asset(
                                          "assets/images/bookmark.png")
                                  ))
                            ],
                          ),
                          Container(
                            height: constants.mediaquery.height * 0.1,
                            width: constants.mediaquery.width * 0.6,
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  data[index].title,
                                  style: constants.theme.textTheme.bodyMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Spacer(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      data[index].voteAverage.toString(),
                                      style:
                                      constants.theme.textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
  getState () async{
    var response = await FireBaseManager().getFromFireStoreTwo();
    for(var i in response){
      ids.add(i.id);
      setState(() {
      });
    }
    print("gggggggggggggggggggggggggggggggggggggggggggggg$ids");


  }
}
