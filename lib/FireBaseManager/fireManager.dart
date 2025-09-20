import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventlyy/FireBaseManager/TaskModel.dart';

import 'UserData.dart';

class FireManager {
  static CollectionReference<TaskModel> addEventCollection(String uId) {
    return getUsersCollections().doc(uId)
        .collection(TaskModel.collectionName)
        .withConverter<TaskModel>(
        fromFirestore: (snepShot, options) {
          return TaskModel.fromJson(snepShot.data()!);
        },
        toFirestore: (value, _) {
          return value.toJson();
        });
  }

  static Future<void> CreateEvent(TaskModel task,String uId) async {
    var taskCollection = addEventCollection(uId);
    DocumentReference<TaskModel> doc = taskCollection.doc();
    task.id = doc.id;
    await doc.set(task);
  }

  static CollectionReference<UserData> getUsersCollections() {
    return FirebaseFirestore.instance.collection("Users").withConverter<UserData>(
        fromFirestore: (snapshot, options) => UserData.fromJson(snapshot.data()!),
        toFirestore: (snapshot,options)=>snapshot.toJson());
  }
  static Future<void> addUser(UserData userData)async {
      await getUsersCollections().doc(userData.id).set(userData);
  }
  static Future<UserData?> getUserFromFirestore(String id)async{
    var querysnapshot=await getUsersCollections().doc(id).get();
    return querysnapshot.data();
  }
  static Future<List<TaskModel>> getEventFromFirestore(String id)async{
    var eventCollection=await addEventCollection(id);
    var querySnapshot=await eventCollection.get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }
}


