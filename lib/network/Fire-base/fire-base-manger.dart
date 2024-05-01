import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies/Domain/Entities/fire-store-entitiy.dart';
import 'package:movies/network/Models/fire-store-Model.dart';

class FireBaseManager {

  collectionRefrence(){
    return
      FirebaseFirestore.instance.collection("Movies").withConverter<FireStoreModel>(
        fromFirestore: (snapshot, options) => FireStoreModel.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toFireStore(),);

  }

   addMovie(FireStoreModel movie) async {
    var collection = collectionRefrence();
    var doc = collection.doc(movie.id.toString());
    doc.set(movie);
  }

  Stream<QuerySnapshot<FireStoreEntity>> getFromFireStore()  {
    var collection = collectionRefrence().snapshots();

    return collection;
  }

  Future<List<dynamic>> getFromFireStoreTwo() async {
    var collection = await collectionRefrence().get();
    return collection.docs.map((element) => element.data()).toList();
  }
  deleteFromFireStore(String? id){
    var collection = collectionRefrence();
    var doc = collection.doc(id);
    return doc.delete();
  }
}