import 'package:eventlyy/register/signUp/RegisterNavigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../../AppProvider/EventListProvider.dart';
import '../../AppProvider/userProvider.dart';
import '../../FireBaseManager/UserData.dart';
import '../../FireBaseManager/fireManager.dart';
import '../../widget/showDialog.dart';

class RegisterViewModel extends ChangeNotifier {
  late RegisterNavigator navigator;
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController rePasswordController = TextEditingController();
  void viewModel(BuildContext contexts,String name,String email, String passWord,String rePassword) async {
    navigator.showLading('Loading...');
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: passWord,
      );
      UserData userData = UserData(id: credential.user!.uid,
         name: nameController.text,
          email: emailController.text);
      await FireManager.addUser(userData);
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      var evantListProvider = Provider.of<EvantListProvider>(
         context, listen: false);
      userProvider.updateUser(userData);
      evantListProvider.changeIndex(0, userProvider.currentUser!.id);
       evantListProvider.getFavFromFireStore(userProvider.currentUser!.id);
      navigator.hideLoad();
      navigator.showMsg("Registration Successfully");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        navigator.hideLoad();
        navigator.showMsg("weak-password ");
      } else if (e.code == 'network-request-failed') {
        navigator.hideLoad();
        navigator.showMsg("Connection failed");
      } else if (e.code == 'email-already-in-use') {
        navigator.hideLoad();
        navigator.showMsg("The account already exists for that email");

      }
    } catch (e) {
      navigator.hideLoad();
      navigator.showMsg(e.toString());
    }
}}