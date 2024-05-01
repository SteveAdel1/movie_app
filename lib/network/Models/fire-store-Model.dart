import 'package:movies/Domain/Entities/fire-store-entitiy.dart';

class FireStoreModel extends FireStoreEntity {
  FireStoreModel({
    required super.id,
    required super.rate,
    required super.name,
    required super.year,
    required super.image,
    required super.backDrop,
    required super.description,
    required super.categories});

  factory FireStoreModel.fromJson(Map<String, dynamic> json) =>
      FireStoreModel(rate: json['rate'],
          id: json['id'],
          name: json['title'],
          year: json['date'],
          image: json['poster'],
          backDrop: json['backDrop'],
          description: json['description'],
          categories: json['category'],);

  toFireStore(){
    return {
      'id': id,
      'rate': rate,
      'title': name,
      'date': year,
      'poster': image,
      'backDrop': backDrop,
      'description': description,
      'category': categories,
    };
  }
}
