import 'package:eventlyy/AppProvider/EventListProvider.dart';
import 'package:eventlyy/AppProvider/appProvider.dart';
import 'package:eventlyy/AppProvider/userProvider.dart';
import 'package:eventlyy/AppTheme/appTheme.dart';
import 'package:eventlyy/l10n/app_localizations.dart';
import 'package:eventlyy/register/login/Login.dart';
import 'package:eventlyy/widget/bbottomSheets/langSheet.dart';
import 'package:eventlyy/widget/bbottomSheets/themeSheet.dart';
import 'package:eventlyy/widget/showDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profiletab extends StatefulWidget {
  static const String routeName = "Profiletab";

  const Profiletab({super.key});

  @override
  State<Profiletab> createState() => _SettingsState();
}

class _SettingsState extends State<Profiletab> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider=Provider.of<UserProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    AppProvider appProvider = Provider.of<AppProvider>(context);
    EvantListProvider evantListProvider=Provider.of<EvantListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.18,
        title: Row(
          children: [
            Image.asset("assets/images/route.png"),
            SizedBox(width: width*0.02,),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userProvider.currentUser!.name,style: Theme.of(context).textTheme.titleLarge,),
                SizedBox(height: height*0.01,),
                Text(userProvider.currentUser!.email,style: Theme.of(context).textTheme.titleMedium,)
              ],
            )
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft:Radius.circular(50),
          ),
        ),
        backgroundColor: Color(0xFF5669FF),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context)!.language,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: height * 0.02),
            InkWell(
              onTap: () {
                showBottomLangSheet();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.blueColor, width: 2),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height * 0.01,
                    horizontal: width * 0.03,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        appProvider.appLang == 'ar'
                            ? AppLocalizations.of(context)!.arabic
                            : AppLocalizations.of(context)!.english,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Icon(
                        Icons.arrow_drop_down_sharp,
                        size: 35,
                        color: AppTheme.blueColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            Text(
              AppLocalizations.of(context)!.theme,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: height * 0.02),
            InkWell(
              onTap: () {
                showBottomThemeSheet();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.blueColor, width: 2),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height * 0.01,
                    horizontal: width * 0.03,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        appProvider.appTheme == ThemeMode.light
                            ? AppLocalizations.of(context)!.light
                            : AppLocalizations.of(context)!.dark,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Icon(
                        Icons.arrow_drop_down_sharp,
                        size: 35,
                        color: AppTheme.blueColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 120),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.redColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  ShowDialog.showMsg(context: context,
                  msg: "Do you want to LogOut",
                  posAction: (){
                  },
                  posMsg: "cancel",
                  preAction: (){
                    Navigator.pushReplacementNamed(context, Login.routeName);
                    setState(() {

                    });

                  },preMsg: "yes");
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.02),
                  child: Row(
                    children: [
                      Icon(Icons.login, color: AppTheme.whiteColor, size: 35),
                      SizedBox(width: width * 0.02),
                      Text(
                        AppLocalizations.of(context)!.logout,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showBottomThemeSheet() {
    showModalBottomSheet(context: context, builder: (builder) => Themesheet());
  }

  showBottomLangSheet() {
    showModalBottomSheet(context: context, builder: (builder) => Langsheet());
  }
}

