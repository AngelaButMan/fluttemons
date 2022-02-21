import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttemons/models/user.dart';

class PokemonFireStore {
  static final user = FirebaseAuth.instance.currentUser!;
  static final collection = FirebaseFirestore.instance.collection('users');

  Stream<QuerySnapshot> getStream() => collection.snapshots();

  static Future addUserData() {
    return collection.doc(user.uid.toString()).set({"favoritePokemons": ""});
  }

  static void updateUserData(UserData userData) async {
    await collection.doc(user.uid.toString()).update(userData.toJson());
  }

  static void deleteUserData(UserData userData) async {
    await collection.doc(user.uid.toString()).delete();
  }

  static Future<UserData> getUserData() async {
    return await collection
        .doc(user.uid.toString())
        .get()
        .then((snapshot) => UserData.fromJson(snapshot.data()!));
  }

  static userExists() async {
    return (await collection.doc(user.uid.toString()).get()).exists;
  }
}
