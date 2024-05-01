import 'package:flutter/material.dart';
import 'package:movies/Domain/Entities/popular_entites.dart';
import 'package:movies/core/config/constants.dart';
import 'package:movies/core/config/pages_Route_Name.dart';
import 'package:movies/main.dart';
import 'package:movies/network/Api/api_manger.dart';
import 'package:movies/pages/home/widgets/Second-Container.dart';
import 'package:movies/pages/home/widgets/category_item.dart';
import 'package:movies/pages/home/widgets/custom_container.dart';

import 'package:flutter/material.dart';
import 'package:movies/Domain/Entities/popular_entites.dart';
import 'package:movies/core/config/constants.dart';
import 'package:movies/network/Api/api_manger.dart';
import 'package:movies/pages/home/widgets/Second-Container.dart';
import 'package:movies/pages/home/widgets/category_item.dart';
import 'package:movies/pages/home/widgets/custom_container.dart';

import '../../../network/Fire-base/fire-base-manger.dart';
import '../../../network/Models/fire-store-Model.dart';

class CustomMovieView extends StatefulWidget {
   CustomMovieView({Key? key});

  @override
  State<CustomMovieView> createState() => _CustomMovieViewState();
}

class _CustomMovieViewState extends State<CustomMovieView> {
  List<int> ids=[];

  @override
  Widget build(BuildContext context) {
    if(ids.isEmpty) getState();
    var args = ModalRoute.of(context)!.settings.arguments as PopularEntity;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          args.title,
          style: constants.theme.textTheme.bodyLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: constants.mediaquery.width,
              height: constants.mediaquery.height * 0.55,
              child: Column(
                children: [
                  Container(
                    color: Color(0xFF282A28),
                    width: constants.mediaquery.width,
                    height: constants.mediaquery.height * 0.24,
                    child: Image.network(
                      args.backDrop,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          args.title,
                          style: constants.theme.textTheme.bodyLarge,
                        ),
                        Text(
                          "Release date:  ${args.date}",
                          style: constants.theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    height: constants.mediaquery.height * 0.2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0XFF282A28),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                  image: NetworkImage(args.poster),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: constants.mediaquery.height * 0.22,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: InkWell(
                                onTap: () {
                                  getState();
                                  if (!ids.contains(args.id)) {
                                    var movie = FireStoreModel(
                                      id: args.id,
                                      rate: args.voteAverage,
                                      name: args.title,
                                      year: args.date,
                                      image: args.poster,
                                      backDrop: args.backDrop,
                                      description: args.overview,
                                      categories: args.categories,
                                    );
                                    FireBaseManager().addMovie(movie);
                                  } else {
                                    FireBaseManager().deleteFromFireStore(args.id.toString());
                                    ids.remove(args.id);
                                    setState(() {});
                                  }
                                },
                                child: ids.contains(args.id)
                                    ? Image.asset("assets/images/bookmarkSelected.png")
                                    : Image.asset("assets/images/bookmark.png"),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FutureBuilder(
                                future: ApiManager.categoryNames(args.categories),
                                builder: (context, AsyncSnapshot<List<String>> snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    List<String> categories = snapshot.data ?? [];
                                    return SizedBox(
                                      height: constants.mediaquery.height * 0.15,
                                      width: constants.mediaquery.width * 0.6,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: SingleChildScrollView(
                                                  scrollDirection: Axis.horizontal,
                                                  child: Row(
                                                    children: categories.map((category) {
                                                      return CategoryItem(category: category);
                                                    }).toList(),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "Overview:",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                            SizedBox(
                                            height: constants.mediaquery.height*0.08,
                                          child:SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Text(
                                              args.overview,
                                              style: constants.theme.textTheme.bodyMedium!.copyWith(),
                                            ),
                                          )),
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                              SizedBox(
                                height: constants.mediaquery.height * 0.02,
                                child: Row(
                                  children: [
                                    Expanded( // Wrap the Row with Expanded
                                      child: Row(
                                        children: [
                                          Icon(Icons.star, color: Colors.yellow, size: 20),
                                          Flexible(
                                            child: Text(
                                              "Rating (${args.voteAverage})",
                                              style: constants.theme.textTheme.bodySmall,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),


                ],
              ),
            ),

            const SecondContainer(
              text: 'More like this',
              image: "assets/images/TestBrowse.png",
            ),
          ],
        ),
      ),
    );
  }

  getState () async{
    var response = await FireBaseManager().getFromFireStoreTwo();
    for(var i in response){
      if(!ids.contains(i)){
      ids.add(i.id);}
      setState(() {
      });
    }
    print("gggggggggggggggggggggggggggggggggggggggggggggg$ids");


  }
}


