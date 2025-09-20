import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventlyy/AppProvider/appProvider.dart';
import 'package:eventlyy/AppProvider/userProvider.dart';
import 'package:eventlyy/AppTheme/DarkTheme.dart';
import 'package:eventlyy/AppTheme/lightTHeme.dart';
import 'package:eventlyy/l10n/app_localizations.dart';
import 'package:eventlyy/register/login/Login.dart';
import 'package:eventlyy/register/signUp/signup.dart';
import 'package:eventlyy/screens/HoeScreen/edit_event.dart';
import 'package:eventlyy/screens/HoeScreen/event_details_screen.dart';
import 'package:eventlyy/screens/HoeScreen/tabs/Fav_Tab.dart';
import 'package:eventlyy/screens/HoeScreen/tabs/Home_Tab.dart';
import 'package:eventlyy/screens/HoeScreen/tabs/ProfileTab.dart';
import 'package:eventlyy/screens/HoeScreen/tabs/mainTab1.dart';
import 'package:eventlyy/screens/introduction/Intro.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'AppProvider/EventListProvider.dart';
import 'create_Event/EvantCreation.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseFirestore.instance.enableNetwork();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AppProvider()),
          ChangeNotifierProvider(create: (_) => EvantListProvider()),
          ChangeNotifierProvider(create: (_)=>UserProvider())
        ],
          child:
  MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(393, 793),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale(appProvider.appLang),
        themeMode: appProvider.appTheme,
        darkTheme: DarkTheme.darkMode,
        theme: LightTheme.lightMode,
        debugShowCheckedModeBanner: false,
        initialRoute: Signup.routeName,
        routes: {
          Introduction.routeName: (_) => Introduction(),
          Login.routeName: (_) => Login(),
          Signup.routeName: (_) => Signup(),
          FavTab.routeName: (_) => FavTab(),
          HomeTab.routeName: (_) => HomeTab(),
          Profiletab.routeName: (_) => Profiletab(),
          EvantCreation.routeName: (_) => EvantCreation(),
          Maintab1.routeName: (_) => Maintab1(),
          EventDetailsScreen.routeName:(_)=>EventDetailsScreen(),
          EditEvent.routeName:(_)=>EditEvent()
        },
      ),
    );
  }
}
