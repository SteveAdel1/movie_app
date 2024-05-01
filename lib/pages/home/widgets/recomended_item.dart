
import 'package:flutter/material.dart';
import 'package:movies/core/config/constants.dart';

import '../../../Domain/Entities/popular_entites.dart';
import '../../../core/config/pages_Route_Name.dart';
import '../../../main.dart';
import '../../../network/Fire-base/fire-base-manger.dart';
import '../../../network/Models/fire-store-Model.dart';

class RecomendedItem extends StatefulWidget {
  final int id;
  final image;
  final String backDrop;
  final String overview;
  final categories;
  final name;
  final date;
  final double reviews;

  RecomendedItem(
      {super.key,
        required this.id,
        required this.backDrop,
        required this.overview,
        required this.categories,
        required this.name,
        required this.image,
        required this.date,
        required this.reviews});

  @override
  State<RecomendedItem> createState() => _RecomendedItemState();
}

class _RecomendedItemState extends State<RecomendedItem> {
  List<int> ids=[];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if(ids.isEmpty) getState();
    return InkWell(
      onTap: (){
        navigatorkey.currentState!.pushNamed(
            PageRouteName.movieView,
            arguments: PopularEntity(
                state: false,
                id: widget.id ,
                backDrop: widget.backDrop,
                poster: widget.image,
                title: widget.name,
                overview: widget.overview,
                categories: widget.categories,
                date: widget.date,
                voteAverage:
                widget.reviews));
      },
      child: Container(
        width: size.width*0.24,
        height: size.height*0.21,
        margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                  height: size.height*0.14,
                  width: size.width*0.24,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(4),
                          topLeft: Radius.circular(4)),
                      child: Image.network(
                        widget.image,
                        fit: BoxFit.fill,
                      )),
                ),
                InkWell(
                    onTap: () {
                      getState();
                      // Call the changeState method
                      var movie = FireStoreModel(
                          id: widget.id,
                          rate: widget.reviews,
                          name: widget.name,
                          year: widget.date,
                          image: widget.image,
                          backDrop: widget.backDrop,
                          description: widget.overview,
                          categories: widget.categories);
                      FireBaseManager().addMovie(movie);


                    },
                    child:ids.contains(widget.id)? Image.asset(
                        "assets/images/bookmarkSelected.png")
                        :
                    Image.asset(
                        "assets/images/bookmark.png")
                )

              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Color(0XFF343534),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(4),
                          bottomRight: Radius.circular(4)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Color(0xFFF4B400),
                              size: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.reviews.toString(),
                              style: constants.theme.textTheme.bodySmall!.copyWith(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          widget.name,
                          overflow: TextOverflow.ellipsis,
                         style: constants.theme.textTheme.bodySmall!.copyWith(
                           overflow: TextOverflow.ellipsis,
                           fontWeight: FontWeight.normal,
                         )
                        ),
                        Row(
                          children: [
                            Text(
                              widget.date,
                              overflow: TextOverflow.ellipsis,
                                style: constants.theme.textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFFB5B4B4),
                                  fontSize: 12
                                )
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
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