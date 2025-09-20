import 'package:eventlyy/FireBaseManager/UserData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../FireBaseManager/fireManager.dart';

class UserProvider extends ChangeNotifier{
  UserData? currentUser;

  void updateUser(UserData newUser) {
    currentUser = newUser;
    notifyListeners();

  }
}
