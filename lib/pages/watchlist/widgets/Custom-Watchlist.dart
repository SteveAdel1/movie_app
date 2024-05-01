import 'package:flutter/material.dart';

class CustomWatchList extends StatelessWidget {
  const CustomWatchList({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.black,
        title: Text("Watchlist"),
      ),
      body: Column(
        children: [
          Container(
            height: 102,
            width: 385,
            child: Row(
              children: [
                Image.asset("assets/images/testimage.png",fit: BoxFit.cover,),
                SizedBox(width: 13,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("tirle of  movie",style: theme.textTheme.bodyLarge,),
                      Text("date ",style: theme.textTheme.bodySmall,),
                      Text("discription",style: theme.textTheme.bodySmall),
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
            thickness: 2,
          ),
          SizedBox(height: 10,)
        ],
      ),
    );
  }
}
