import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection = 
  FirebaseFirestore.instance.collection("user");
  final CollectionReference groupCollection = 
  FirebaseFirestore.instance.collection("user");


  Future savingUserData(String name, String email)async{
  return await userCollection.doc(uid).set({
    "Name":name,
    "email":email,
    "groups":[],
    "profilepic":uid,
  });
  }

  Future gettingUserData(String email)async{
   QuerySnapshot snapshot = 
   await userCollection.where("email",isEqualTo: email).get();
   return snapshot;
  }
}