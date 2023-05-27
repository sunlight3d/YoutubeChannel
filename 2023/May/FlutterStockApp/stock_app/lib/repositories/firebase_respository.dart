import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'dart:convert' as convert;

final FirebaseFirestore firestore = FirebaseFirestore.instance;
class FirebaseRepository {
  static void createRecord() async {
    try {
      //call in Nodejs,
      await firestore
          .collection("books")
          .doc("1")
          .set({'title': 'Mastering Firebase', 'description': 'Firebase guide'});
      print("haha");
    }catch(e) {
      print(e);
    }
    
  }
  static void readRecord() async {
    DocumentSnapshot documentSnapshot = await firestore.collection("books")
                                            .doc("1").get();
    print(documentSnapshot.data());
  }
  static void updateRecord() async {
    await firestore
        .collection("books")
        .doc("1")
        .update({'description': 'Updated description'});
  }

  static void deleteRecord() async {
    await firestore.collection("books").doc("1").delete();
  }
  static void listen(Function(dynamic) callback) {
    CollectionReference books = FirebaseFirestore.instance.collection('books');
    books.snapshots().listen((snapshot) {
      snapshot.docChanges.forEach((change) {
        print("haha");//call api
        if (change.type == DocumentChangeType.added) {
          print('New book: ${change.doc.data()}');
        } else if (change.type == DocumentChangeType.modified) {
          print('Updated book: ${change.doc.data()}');
        } else if (change.type == DocumentChangeType.removed) {
          print('Deleted book: ${change.doc.data()}');
        }
        callback(change.doc.data());
      });
    });
  }
}