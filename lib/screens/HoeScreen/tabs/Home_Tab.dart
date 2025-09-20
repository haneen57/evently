import 'package:eventlyy/l10n/app_localizations.dart';
import 'package:eventlyy/screens/HoeScreen/tabs/Fav_Tab.dart';
import 'package:eventlyy/screens/HoeScreen/tabs/MapTab.dart';
import 'package:eventlyy/screens/HoeScreen/tabs/ProfileTab.dart';
import 'package:eventlyy/screens/HoeScreen/tabs/mainTab1.dart';
import 'package:flutter/material.dart';

import '../../../create_Event/EvantCreation.dart';

class HomeTab extends StatefulWidget {
  static const String routeName = 'home';

  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

int index = 0;
int currIndex = 0;

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.bookclub,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.gaming,
    ];
    return Scaffold(
      extendBody: true,

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, EvantCreation.routeName);
        },
        child: Icon(Icons.add, size: 35),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        height: 95,
        child: BottomNavigationBar(
          onTap: (value) {
            index = value;
            setState(() {});
          },
          currentIndex: index,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 35, color: Colors.white),
              label: AppLocalizations.of(context)!.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.location_on_outlined,
                size: 30,
                color: Colors.white,
              ),
              label: AppLocalizations.of(context)!.map,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border, size: 30, color: Colors.white),
              label: AppLocalizations.of(context)!.fav,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 30, color: Colors.white),
              label: AppLocalizations.of(context)!.profile,
            ),
          ],
        ),
      ),
      body: tabs[index],
    );
  }

  List<Widget> tabs = [Maintab1(), MapTab(), FavTab(), Profiletab()];
}
