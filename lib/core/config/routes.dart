import 'package:flutter/material.dart';
import 'package:movies/core/config/pages_Route_Name.dart';
import 'package:movies/pages/browse/pages/browse.dart';
import 'package:movies/pages/home/pages/homescreeen.dart';
import 'package:movies/pages/search/pages/searchscreen.dart';
import 'package:movies/pages/splash/pages/splashscreen.dart';

import '../../pages/browse/pages/category_Movies.dart';
import '../../pages/home/pages/Movie_View.dart';
import '../../pages/home/pages/home_navbar.dart';
import '../../pages/home/widgets/Cutom_Movie_View.dart';
import '../../pages/watchlist/pages/watchlist.dart';

class Routes{
  static Route <dynamic> ?onGenrateRoutes(RouteSettings settings){
    switch (settings.name){
      case PageRouteName.initial:
        return MaterialPageRoute(builder: (Context)=>const splashscreen(),
          settings: settings,
        );
      case PageRouteName.homescreen:
        return MaterialPageRoute(builder: (Context)=>const homescreen(),
          settings: settings,
        );
      case PageRouteName.homescreen:
        return MaterialPageRoute(builder: (Context)=>const home(),
          settings: settings,
        );
      case PageRouteName.browse:
        return MaterialPageRoute(builder: (Context)=>const browsesscreen(),
          settings: settings,
        );
      case PageRouteName.watchlist:
        return MaterialPageRoute(builder: (Context)=>const watchlistsscreen(),
          settings: settings,
        );
      case PageRouteName.movieView:
        return MaterialPageRoute(builder: (Context)=>CustomMovieView(),
          settings: settings,
        );
      case PageRouteName.categoryView:
        return MaterialPageRoute(builder: (Context)=>const CategoriesView(),
          settings: settings,
        );
    }
  }
}