import 'package:movies/Domain/Entities/category_entity.dart';

class CategoriesModel extends CategoriesEntity{
  CategoriesModel({required super.name, required super.id});
  factory CategoriesModel.fromJson(Map<String ,dynamic>json)=> CategoriesModel(
      name: json["name"],
      id: json["id"],);
}