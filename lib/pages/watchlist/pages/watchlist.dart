import 'package:flutter/material.dart';
import 'package:movies/core/config/constants.dart';
import 'package:movies/network/Api/api_manger.dart';
import 'package:movies/network/Fire-base/fire-base-manger.dart';

import '../../../Domain/Entities/popular_entites.dart';
import '../../../core/config/pages_Route_Name.dart';
import '../../../main.dart';

class watchlistsscreen extends StatelessWidget {
  const watchlistsscreen({Key? key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 50,horizontal: 5),
      child: StreamBuilder(
        stream: FireBaseManager().getFromFireStore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Replace with your loading widget
          } else if (snapshot.hasError) {
            print("Error: ${snapshot.error}");
            return Text("Error fetching data: ${snapshot.error}");
          } else {
            if (snapshot.data == null) {
              print("Data is null");
              return Text("Data is null");
            }
            var data = snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
            print(data);
            return ListView.builder(
              padding: EdgeInsets.all(0),
              itemCount: data.length,
              itemBuilder: (context, index) =>  Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                      width: constants.mediaquery.width,
                      height: constants.mediaquery.height * 0.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                color: Color(0XFF282A28),
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: constants.mediaquery.height * 0.22,
                                child: InkWell(
                                    onTap: () {
                                      navigatorkey.currentState!.pushNamed(
                                          PageRouteName.movieView,
                                          arguments: PopularEntity(
                                              state: false,
                                              id: data[index].id ,
                                              backDrop: data[index].backDrop,
                                              poster: data[index].image,
                                              title: data[index].name,
                                              overview: data[index].description,
                                              categories: data[index].categories,
                                              date: data[index].year,
                                              voteAverage:
                                              data[index].rate));
                                    },
                                    child: Image.network(data[index].image, fit: BoxFit.fill)),
                              ),
                              InkWell(
                                  onTap: (){
                                    FireBaseManager().deleteFromFireStore(data[index].id.toString());
                                  },
                                  child: Image.asset("assets/images/bookmarkSelected.png"))
                            ],
                          ),
                          Container(
                            width: constants.mediaquery.width * 0.5,
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: constants.mediaquery.width * 0.6,
                                  child: Text(
                                    data[index].name,
                                    style: constants.theme.textTheme.titleLarge!.copyWith(overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.yellow),
                                    SizedBox(width: 10),
                                    Text(data[index].rate.toString()),
                                  ],
                                ),
                                Text(
                                  "${data[index].description}",
                                  style: constants.theme.textTheme.bodySmall!.copyWith(overflow: TextOverflow.ellipsis),
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
          }
        },
      ),
    );
  }
}
