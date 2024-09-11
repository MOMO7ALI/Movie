import 'package:cloud_firestore/cloud_firestore.dart';
import 'Movie.dart';

class FirebaseUtils {


  static CollectionReference<Movie> getMovieCollection() {
    return FirebaseFirestore.instance
        .collection(Movie.collectionName)
        .withConverter<Movie>(
      fromFirestore: (snapshot, options) => Movie.fromFireStore(snapshot.data()!),
      toFirestore: (value, options) => value.toFireStore(),
    );
  }


  static Future<void> addMovieToFirebase(String id) {
    var collection = getMovieCollection();
    var docRef = collection.doc(id);
    return docRef.set(Movie(id: id));
  }


  static Future<List<Movie>> getMovieFromFireBase() async {
    List<Movie> movies = [];
    QuerySnapshot<Movie> snapshot = await getMovieCollection().get();
    movies = snapshot.docs.map((doc) => doc.data()).toList();
    return movies;
  }


  static Future<bool> isMovieBookmarked(String id) async {
    var docSnapshot = await getMovieCollection().doc(id).get();
    return docSnapshot.exists;
  }


  static Future<void> removeMovieFromFirebase(String id) {
    var collection = getMovieCollection();
    return collection.doc(id).delete();
  }
}
