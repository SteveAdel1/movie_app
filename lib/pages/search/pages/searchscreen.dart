import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movies/Domain/Entities/popular_entites.dart';
import 'package:movies/core/config/constants.dart';
import 'package:movies/network/Api/api_manger.dart';

import '../../../core/config/pages_Route_Name.dart';
import '../../../main.dart';
import '../../../network/Models/popular_model.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  Widget searchInfo = Container();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(25),
      child: Container(
        child: Column(
          children: [
            SearchBar(
              hintText: "Search",
              leading: Icon(Icons.search,color: Colors.white,) ,
              backgroundColor:  MaterialStateProperty.all(Color(0XFF514F4F)),
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchInfo = FutureBuilder(
                    future: ApiManager().search(value),
                    builder: (context, AsyncSnapshot<List<PopularEntity>> snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error.toString());
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      List<PopularEntity> data = snapshot.data ?? [];
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) => Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Color(0XFF282A28),
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    height: MediaQuery.of(context).size.height * 0.22,
                                    child: InkWell(
                                        onTap:(){
                                          FocusScope.of(context).unfocus();
                                                    navigatorkey.currentState!.pushNamed(
                                                        PageRouteName.movieView,
                                                        arguments: PopularEntity(
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
                                        child: Image.network(data[index].poster, fit: BoxFit.fill)),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Flexible( // Wrap the Text widget with Flexible
                                          child: SizedBox(
                                            width: double.infinity, // Ensure the text takes available width
                                            child: Text(
                                              data[index].title,
                                              style: constants.theme.textTheme.titleLarge!.copyWith(overflow: TextOverflow.ellipsis),
                                              maxLines: 2, // Set maximum number of lines
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.star, color: Colors.yellow),
                                            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                                            Text(data[index].voteAverage.toString()),
                                          ],
                                        ),
                                        Flexible( // Wrap the Text widget with Flexible
                                          child: SizedBox(
                                            width: double.infinity, // Ensure the text takes available width
                                            child: Text(
                                              "${data[index].date}",
                                              style: constants.theme.textTheme.bodySmall!.copyWith(
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              maxLines: 1, // Set maximum number of lines
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 2,
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      );
                    },
                  );
                });
              },

            ),
            SizedBox(height: 20),
            Expanded(
              child: searchInfo,
            ),
          ],
        ),
      ),
    );
  }
}
