import 'package:eventlyy/register/login/oginNavigator.dart';
import 'package:eventlyy/register/signUp/RegisterNavigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../FireBaseManager/fireManager.dart';

class LoginViewModel extends ChangeNotifier{
 // late LoginNavigator loginNavigator;
 // var formKey = GlobalKey<FormState>();
 // TextEditingController emailController=TextEditingController();
 // TextEditingController passwordController=TextEditingController();
//  void loginviewModel()async{
 //   if (formKey.currentState!.validate()) {
  //    loginNavigator.showLading("Loading...");

   //   try {
   //     final credential = await FirebaseAuth.instance
    //        .signInWithEmailAndPassword(
    //        email: emailController.text,
    //        password: passwordController.text
    //    );
    //    var user = await FireManager.getUserFromFirestore(
    //        credential.user?.uid ?? '');
        // if(user==null){
        // ShowDialog.hideLoading(context);
        //ShowDialog.showMsg(context: context, msg: "No user found for that email.");
        //return;
        // }
        // var userProvider=Provider.of<UserProvider>(context,listen: false);
        //var evantListProvider=Provider.of<EvantListProvider>(context,listen: false);
        //userProvider.updateUser(user);
        //evantListProvider.changeIndex(0, userProvider.currentUser!.id);
        //evantListProvider.getFavFromFireStore(userProvider.currentUser!.id);
       // loginNavigator.hideLoad();
      //  loginNavigator.showMsg("Login Successfully");
     // } on FirebaseAuthException catch (e) {
    //    if (e.code == 'user-not-found') {
   //       loginNavigator.hideLoad();
   //       loginNavigator.showMsg("user-not-found");
   //     } else if (e.code == 'wrong-password') {
  //        loginNavigator.hideLoad();
    //      loginNavigator.showMsg("wrong-password");
   //     }
   //     else if (e.code == 'invalid-credential') {
    //      loginNavigator.hideLoad();
    //      loginNavigator.showMsg("invalid-credential");
     //   }
      }
     // catch (e) {
     //   loginNavigator.hideLoad();
    //    loginNavigator.showMsg(e.toString());
  //    }
  //  }
 // }
//}