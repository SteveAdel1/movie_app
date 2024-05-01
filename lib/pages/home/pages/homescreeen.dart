import 'package:flutter/material.dart';
import 'package:movies/pages/search/pages/searchscreen.dart';
import 'package:movies/pages/watchlist/pages/watchlist.dart';

import '../../browse/pages/browse.dart';
import '../widgets/custom_container.dart';
import 'home_navbar.dart';
class homescreen extends StatefulWidget {

   const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  int currentindex=0;

  List<Widget>navigatedpages=[home(),SearchScreen() as Widget,browsesscreen(),watchlistsscreen()];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:navigatedpages[currentindex],
      bottomNavigationBar: BottomNavigationBar(currentIndex: currentindex,
        onTap: (index){
          currentindex=index;
          setState(() {
          });
        },
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home),
            label: "Home"),
        BottomNavigationBarItem(icon: InkWell(
            child: Icon(Icons.search)),
            label: "Search"),
        BottomNavigationBarItem(icon: ImageIcon(AssetImage("assets/images/browseicon.png")),
            label: "BROWSE"),
        BottomNavigationBarItem(icon: ImageIcon(AssetImage("assets/images/watchlist_icon.png")),
            label: "WATCHLIST"),
      ],
      ),
    );
  }
}
