import 'package:flutter/material.dart';
import 'package:movies/Domain/Entities/new_releases_entity.dart';
import 'package:movies/core/config/constants.dart';
import 'package:movies/network/Api/api_manger.dart';

//New RElases Container
class Customcontainer extends StatelessWidget {
  final String text;

  final String image;

  Customcontainer({super.key, required this.text, required this.image});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
        future:ApiManager.newRelease(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error.toString());
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          List<NewReleasesEntity> data = snapshot.data ?? [];
          return Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            color: Color(0XFF282A28),
            width: size.width,
            height: size.height * 0.23,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "New Releases",
                  style: constants.theme.textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),

                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                     return Container(
                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.black,
                          image: DecorationImage(
                            //api images
                              image: NetworkImage(data[index].poster),
                              fit: BoxFit.cover),
                        ),
                        margin:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        width: size.width * 0.24,
                        height: size.height * 0.15,
                        child: Icon(Icons.add),
                      )
                      ;
                    } ),
                ),
              ],
            ),
          );
        },

    );

  }
}
