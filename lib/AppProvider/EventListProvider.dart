import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventlyy/AppProvider/userProvider.dart';
import 'package:eventlyy/AppTheme/appTheme.dart';
import 'package:eventlyy/widget/showDialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../FireBaseManager/TaskModel.dart';
import '../FireBaseManager/fireManager.dart';
import '../l10n/app_localizations.dart';

class EvantListProvider extends ChangeNotifier {
  List<TaskModel> eventList = [];
  List<TaskModel> filteredList = [];
  int currIndex = 0;
  List<String> eventNameList = [];
  List<TaskModel> favList = [];

  getEventList(BuildContext context) {
    return eventNameList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.bookclub,
      AppLocalizations.of(context)!.eating,
      AppLocalizations.of(context)!.exhibition,
    ];
  }

  void getFilteredList(String uId) async {
    QuerySnapshot<TaskModel> querySnapshot =
    await FireManager.addEventCollection(uId)
        .orderBy("date")
        .where("category", isEqualTo: eventNameList[currIndex])
        .get();
    filteredList = querySnapshot.docs.map((e) {
      return e.data();
    }).toList();
    notifyListeners();
  }

  getFavFromFireStore(String uId) async {
    QuerySnapshot<TaskModel> querySnapshot =
    await FireManager.addEventCollection(uId)
        .orderBy("date")
        .where(("isFav"), isEqualTo: true)
        .get();
    favList = querySnapshot.docs.map((docs) {
      return docs.data();
    }).toList();
  }

  void getFavList(String uId) async {
    QuerySnapshot<TaskModel> querySnapshot =
    await FireManager.addEventCollection(uId).get();
    eventList = querySnapshot.docs.map((e) {
      return e.data();
    }).toList();
    favList = eventList.where((event) {
      return event.isFav == true;
    }).toList();

    notifyListeners();
  }

  void changeIndex(int newIndex, String uId) {
    currIndex = newIndex;
    currIndex == 0 ? gertEventCollection(uId) : getFilteredList(uId);
  }

  updateIsFavourite(TaskModel taskModel, String uId) {
    FireManager.addEventCollection(uId)
        .doc(taskModel.id)
        .update({"isFav": !taskModel.isFav}).then((value) {
      Fluttertoast.showToast(
        msg: "Updated Successfully",
        gravity: ToastGravity.CENTER,
        textColor: AppTheme.whiteColor,
        backgroundColor: AppTheme.blueColor,
      );
      currIndex == 0 ? gertEventCollection(uId) : getFilteredList(uId);
      getFavFromFireStore(uId);
    },);
    notifyListeners();
  }

  Future<QuerySnapshot?> gertEventCollection(String uId) async {
    QuerySnapshot<TaskModel> querySnapshot =
    await FireManager.addEventCollection(uId).orderBy("date").get();
    filteredList = querySnapshot.docs.map((e) {
      return e.data();
    }).toList();
    notifyListeners();
    return null;
  }
  editEvent(String uId,TaskModel taskModel)async{
    try
    {
      await FireManager.addEventCollection(uId).doc(taskModel.id).update(
          taskModel.toJson());

      notifyListeners();
    }
    catch(e){
        print(e);
    }
  }
  deleteEvent(TaskModel taskModel, String uId) async {
    try {
      await FireManager.addEventCollection(uId)
          .doc(taskModel.id)
          .delete();

      Fluttertoast.showToast(
        msg: "Deleted Successfully",
        gravity: ToastGravity.CENTER,
        textColor: AppTheme.whiteColor,
        backgroundColor: AppTheme.blueColor,
      );

      currIndex == 0 ? gertEventCollection(uId) : getFilteredList(uId);
      getFavFromFireStore(uId);

      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error deleting event: $e",
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }
}
