import 'package:flutter/cupertino.dart';
import 'package:movies/core/config/constants.dart';

class CategoryItem extends StatelessWidget {
  String category;
  CategoryItem({required this.category ,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all( color: const Color(0xFF514F4F), width: 1),
      ),
   child: Text(category ,style: constants.theme.textTheme.bodySmall,),
    );
  }
}
