import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/Domain/Entities/category_entity.dart';
import 'package:movies/core/config/constants.dart';
import 'package:movies/network/Api/api_manger.dart';

import '../../../Domain/Entities/popular_entites.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({Key? key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var args = ModalRoute.of(context)!.settings.arguments as CategoriesEntity;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(args.name),
      ),
      body: FutureBuilder(
        future: ApiManager.getSpecificCategories(args.id),
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
            itemCount: data.length,
            itemBuilder: (context, index) => Column(
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
                      Container(
                          color: Color(0XFF282A28),
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: constants.mediaquery.height * 0.22,
                          child: Image.network(data[index].poster,fit: BoxFit.fill,)),
                      Container(
                        width: size.width*0.5,
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: size.width*0.6,
                                child: Text(data[index].title,style: constants.theme.textTheme.titleLarge!.copyWith(overflow: TextOverflow.ellipsis),)),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.yellow),
                                SizedBox(width: 10,),
                                Text(data[index].voteAverage.toString())
                              ],
                            ),
                            Text("${data[index].date}",style: constants.theme.textTheme.bodySmall!.copyWith(
                              overflow: TextOverflow.ellipsis,

                            )),
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
      ),
    );
  }
}

