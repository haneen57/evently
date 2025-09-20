import 'package:eventlyy/AppProvider/EventListProvider.dart';
import 'package:eventlyy/AppProvider/userProvider.dart';
import 'package:eventlyy/AppTheme/appTheme.dart';
import 'package:eventlyy/FireBaseManager/UserData.dart';
import 'package:eventlyy/FireBaseManager/fireManager.dart';
import 'package:eventlyy/l10n/app_localizations.dart';
import 'package:eventlyy/register/login/LoginViewModel.dart';
import 'package:eventlyy/register/login/oginNavigator.dart';
import 'package:eventlyy/register/signUp/RegisterNavigator.dart';
import 'package:eventlyy/register/signUp/signup.dart';
import 'package:eventlyy/screens/HoeScreen/tabs/Home_Tab.dart';
import 'package:eventlyy/widget/showDialog.dart';
import 'package:eventlyy/widget/withoutSuffix.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../signUp/RegisterViewModel.dart';

class Login extends StatefulWidget {
  static const String routeName = 'Login';

  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

var formKey = GlobalKey<FormState>();
TextEditingController emailController = TextEditingController(text:"haneen1@gmail.com");
TextEditingController passwordController = TextEditingController(text: "123456");

class _LoginState extends State<Login> {
  // LoginViewModel loginViewModel=LoginViewModel();
  // @override
  // void initState(){
  //  super.initState();
  //  loginViewModel.loginNavigator=this;
  // }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 66, horizontal: 16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset("assets/images/Logo.png", height: height * 0.3),
              SizedBox(height: height * 0.03),
              WithoutSuffix(
                onValidator: (text) {
                  if (text == null || text.isEmpty) {
                    return AppLocalizations.of(context)!.required_email;
                  }
                  final bool emailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                  ).hasMatch(text);
                  if (!emailValid) {
                    return AppLocalizations.of(context)!.error_email;
                  }
                  return null;
                },
                iconColor: Theme.of(context).hintColor,

                colorBorderSide: Theme.of(context).cardColor,
                textStyle: Theme.of(context).textTheme.displaySmall,
                controller: emailController,
                HintText: AppLocalizations.of(context)!.email,
                preIcon: Icon(Icons.email, size: 30),
              ),

              SizedBox(height: height * 0.02),
              WithoutSuffix(
                keyboardtype: TextInputType.emailAddress,
                onValidator: (text) {
                  if (text == null || text.isEmpty) {
                    return AppLocalizations.of(context)!.required_password;
                  }
                  if (text.length < 6) {
                    return AppLocalizations.of(context)!.error_pass;
                  }
                  return null;
                },
                suffIcon: Icons.remove_red_eye,
                iconColor: Theme.of(context).hintColor,
                colorBorderSide: Theme.of(context).cardColor,
                textStyle: Theme.of(context).textTheme.displaySmall,
                controller: passwordController,
                HintText: AppLocalizations.of(context)!.password,
                preIcon: Icon(Icons.lock, size: 30),
                obscure: true,
              ),
              SizedBox(height: height * 0.01),
              Container(
                alignment: Alignment.topRight,
                child: Text(
                  AppLocalizations.of(context)!.forgot,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.blueColor,
                    decoration: TextDecoration.underline,
                    decorationColor: AppTheme.blueColor,
                  ),
                ),
              ),
              SizedBox(height: height * 0.01),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: height * 0.02),
                  backgroundColor: AppTheme.blueColor,
                  foregroundColor: AppTheme.whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  login();
                },
                child: Text(
                  AppLocalizations.of(context)!.login,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: AppTheme.whiteColor,
                  ),
                ),
              ),
              SizedBox(height: height * 0.015),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Signup.routeName);
                },
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.dont_have_acc,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context)!.create_acc,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: AppTheme.blueColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Color(0xFF5669FF),
                      endIndent: 20,
                    ),
                  ),
                  Text(
                    "OR",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Color(0xFF5669FF)),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Color(0xFF5669FF),
                      indent: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: height * 0.02),
                  backgroundColor: Theme.of(context).focusColor,
                  foregroundColor: AppTheme.whiteColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: AppTheme.blueColor, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  loginWithGoogle();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/google.png"),
                    SizedBox(width: width * 0.02),
                    Text(
                      AppLocalizations.of(context)!.acc_with_google,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: AppTheme.blueColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      ShowDialog.showLoading(context: context);

      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        var user = await FireManager.getUserFromFirestore(
          credential.user?.uid ?? '',
        );
        if (user == null) {
          ShowDialog.hideLoading(context);
          ShowDialog.showMsg(
            context: context,
            msg: "No user found for that email.",
          );
          return;
        }
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        var evantListProvider = Provider.of<EvantListProvider>(
          context,
          listen: false,
        );
        userProvider.updateUser(user);
        evantListProvider.changeIndex(0, userProvider.currentUser!.id);
        evantListProvider.getFavFromFireStore(userProvider.currentUser!.id);
        ShowDialog.hideLoading(context);
        ShowDialog.showMsg(
          context: context,
          msg: 'Login Successfully',
          posMsg: 'ok',
          posAction: () {
            Navigator.pushReplacementNamed(context, HomeTab.routeName);
          },
        );
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
      } catch (e) {
        ShowDialog.hideLoading(context);
        ShowDialog.showMsg(context: context, msg: e.toString());
      }
    }
  }

  Future<UserCredential?> loginWithGoogle() async {
    try{
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      UserData userData = UserData(
        id: userCredential.user!.uid,
        name: userCredential.user?.displayName ?? "",
        email: userCredential.user?.email ?? "",
      );
      await FireManager.addUser(userData);
      UserProvider userProvider = Provider.of<UserProvider>(context);
      userProvider.updateUser(userData);
      EvantListProvider evantListProvider = Provider.of<EvantListProvider>(
        context,
        listen: false,
      );
      evantListProvider.changeIndex(0, userCredential.user!.uid);
      ShowDialog.showMsg(
          context: context,
          msg: 'success',
          posAction: () {
            Navigator.pushReplacementNamed(context, HomeTab.routeName);
          },
          posMsg: "Ok"
      );

      return userCredential;
    }
    catch(e){
      ShowDialog.showMsg(context: context, msg: e.toString());
      return null;
    }
  }
}
//}
// }
//}
//  @override
// void hideLoad() {
//   ShowDialog.hideLoading(context);
// }

//  @override
//  void showLading(String msg) {
//  ShowDialog.showLoading(context: context);
// }

// @override
// void showMsg(String msg) {
//   ShowDialog.showMsg(context: context, msg: msg, posMsg: "OK");
// }
