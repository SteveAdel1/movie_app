import 'package:flutter/material.dart';
import 'package:movies/core/config/constants.dart';
import 'package:movies/main.dart';
import 'package:movies/network/Api/api_manger.dart';

import '../../../Domain/Entities/category_entity.dart';
import '../../../core/config/pages_Route_Name.dart';
import '../../home/widgets/Second-Container.dart';

class browsesscreen extends StatelessWidget {
  const browsesscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Browse"),
      ),
      body: FutureBuilder(
        future: ApiManager.allCategoryNames(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error.toString());
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          List<CategoriesEntity> data = snapshot.data ?? [];
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                childAspectRatio: 4 / 5),
            itemCount: data.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                navigatorkey.currentState!.
                pushNamed(PageRouteName.categoryView,arguments:CategoriesEntity(name: data[index].name, id: data[index].id) );
              },
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: data[index].name=="Action"?AssetImage("assets/categories/action.jpg")
                          : data[index].name == "Adventure" ? AssetImage(
                          "assets/categories/adventure.jpg")
                          : data[index].name == "Animation" ? AssetImage(
                          "assets/categories/animations.jpg")
                          : data[index].name == "Comedy" ? AssetImage(
                          "assets/categories/comedy.jpg")
                          : data[index].name == "Crime" ? AssetImage(
                          "assets/categories/crime.jpg")
                          : data[index].name == "Documentary" ? AssetImage(
                          "assets/categories/doc.jpg")
                          : data[index].name == "Drama" ? AssetImage(
                          "assets/categories/Drama.jpg")
                          : data[index].name == "Family" ? AssetImage(
                          "assets/categories/Family.jpg")
                          : data[index].name == "Fantasy" ? AssetImage(
                          "assets/categories/Fantasy.jpg")
                          : data[index].name == "History" ? AssetImage(
                          "assets/categories/history.jpg")
                          : data[index].name == "Horror" ? AssetImage(
                          "assets/categories/Horror.jpg")
                          : data[index].name == "Music" ? AssetImage(
                          "assets/categories/Music.jpg")
                          : data[index].name == "Musical" ? AssetImage(
                          "assets/categories/Music.jpg")
                          : data[index] .name== "Romance" ? AssetImage(
                          "assets/categories/Romance.jpg")
                          : data[index].name == "Science Fiction" ? AssetImage(
                          "assets/categories/ScienceFiction.jpg")
                          : data[index].name == "TV Movie" ? AssetImage(
                          "assets/categories/TV Movie.jpg")
                          : data[index].name == "Thriller" ? AssetImage(
                          "assets/categories/Thriller.jpg")
                          : data[index] .name== "War" ? AssetImage(
                          "assets/categories/War.jpg")
                          : data[index].name == "Western" ? AssetImage(
                          "assets/categories/Western.jpg"):
                      AssetImage(
                          "assets/images/TestBrowse.png")
                      ,
                      fit: BoxFit.fill,
                    )
                ),
                margin: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Text(data[index].name,style: constants.theme.textTheme.titleLarge!.copyWith(
                  fontSize: 20, // Adjust font size as needed
                  color: Colors.white, // Set text color to white
                  shadows: [
                    Shadow(
                      color: Colors.black, // Set outline color to black
                      blurRadius: 20, // Adjust the blur radius as needed for the outline thickness
                    ),
                  ],
                  decoration: TextDecoration.none,
                ),),
              ),
            ),
          );
        },
      ),



    );
  }
}
