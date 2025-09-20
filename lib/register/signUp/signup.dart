import 'package:eventlyy/AppProvider/EventListProvider.dart';
import 'package:eventlyy/AppProvider/userProvider.dart';
import 'package:eventlyy/FireBaseManager/UserData.dart';
import 'package:eventlyy/FireBaseManager/fireManager.dart';
import 'package:eventlyy/l10n/app_localizations.dart';
import 'package:eventlyy/register/login/Login.dart';
import 'package:eventlyy/register/signUp/RegisterNavigator.dart';
import 'package:eventlyy/register/signUp/RegisterViewModel.dart';
import 'package:eventlyy/screens/HoeScreen/tabs/Home_Tab.dart';
import 'package:eventlyy/widget/showDialog.dart';
import 'package:eventlyy/widget/withoutSuffix.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../AppTheme/appTheme.dart';

class Signup extends StatefulWidget {
  static const String routeName = 'signup';

  Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> implements RegisterNavigator {


  bool isArabic = false;

  var formKey = GlobalKey<FormState>();
  RegisterViewModel registerViewModel = RegisterViewModel();

  @override
  void initState() {
    super.initState();
    registerViewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        registerViewModel;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.register,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16),
                Image.asset("assets/images/Logo.png", height: 156, width: 156),
                SizedBox(height: 16),
                WithoutSuffix(
                  controller: view,
                  HintText: AppLocalizations.of(context)!.name,
                  iconColor: Theme.of(context).hintColor,
                  textStyle: Theme.of(context).textTheme.displaySmall,
                  preIcon: Icon(Icons.person, size: 30),
                  colorBorderSide: Theme.of(context).hintColor,
                  lines: 1,
                  onValidator: (text) {
                    if (text == null || text.isEmpty) {
                      return AppLocalizations.of(context)!.required_name;
                    }
                    return null;
                  },
                ),
                SizedBox(height: height * 0.02),
                WithoutSuffix(
                  lines: 1,
                  keyboardtype: TextInputType.emailAddress,
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
                  lines: 1,
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
                SizedBox(height: height * 0.02),
                WithoutSuffix(
                  lines: 1,
                  onValidator: (text) {
                    if (text == null || text.isEmpty) {
                      return AppLocalizations.of(context)!.required_password;
                    }
                    if (passwordController.text != rePasswordController.text) {
                      return "Not matching password";
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
                  controller: rePasswordController,
                  HintText: AppLocalizations.of(context)!.re_password,
                  preIcon: Icon(Icons.lock, size: 30),
                  obscure: true,
                ),
                SizedBox(height: height * 0.02),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.blueColor,
                    foregroundColor: AppTheme.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    registerViewModel.viewModel(context,
                      nameController.text,
                      emailController.text,
                      passwordController.text,
                      rePasswordController.text,
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.02),
                    child: Text(
                      AppLocalizations.of(context)!.create_acc,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(Login.routeName);
                  },
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: AppLocalizations.of(context)!.already,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        TextSpan(
                          text: AppLocalizations.of(context)!.login,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(color: AppTheme.blueColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void hideLoad() {
    ShowDialog.hideLoading(context);
  }

  @override
  void showLading(String msg) {
    ShowDialog.showLoading(context: context);
  }

  @override
  void showMsg(String msg) async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      final userData = await FireManager.getUserFromFirestore(firebaseUser.uid);
      if (userData != null) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(userData);
      }
    }


  }
}
