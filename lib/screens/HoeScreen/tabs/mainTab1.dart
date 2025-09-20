import 'package:eventlyy/AppProvider/userProvider.dart';
import 'package:eventlyy/AppTheme/appTheme.dart';
import 'package:eventlyy/l10n/app_localizations.dart';
import 'package:eventlyy/widget/EventItem.dart';
import 'package:eventlyy/widget/defaultTabController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../AppProvider/EventListProvider.dart';

class Maintab1 extends StatefulWidget {
  static const String routeName = 'main';

  Maintab1({super.key});

  @override
  State<Maintab1> createState() => _Maintab1State();
}

class _Maintab1State extends State<Maintab1> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider=Provider.of<UserProvider>(context);
    EvantListProvider eventListProvider = Provider.of<EvantListProvider>(
      context,
    );
    eventListProvider.getEventList(context);
    if (eventListProvider.eventList.isEmpty) {
      eventListProvider.currIndex==0?
      eventListProvider.gertEventCollection(userProvider.currentUser!.id):
          eventListProvider.getFilteredList(userProvider.currentUser!.id);
    }
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.12,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.welcomeback,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: 8),
                Text(
                  userProvider.currentUser!.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, color: AppTheme.whiteColor),
                    SizedBox(width: width * 0.01),
                    Text(
                      "Cairo , Egypt",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
                SizedBox(height: height * 0.01),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.light_mode_outlined,
                  color: AppTheme.whiteColor,
                  size: 30,
                ),
                SizedBox(width: width * 0.03),
                Container(
                  alignment: Alignment.center,
                  width: width * 0.07,
                  height: height * 0.035,
                  decoration: BoxDecoration(
                    color: AppTheme.whiteColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "EN",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: height * 0.08,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              color: Theme.of(context).canvasColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      eventListProvider.changeIndex(index,userProvider.currentUser!.id);
                    },
                    child: categoryWidget(
                      eventName: eventListProvider.eventNameList[index],
                      isSelected: eventListProvider.currIndex == index,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(width: width * 0.02);
                },
                itemCount: eventListProvider.eventNameList.length,
              ),
            ),
          ),
          SizedBox(height: height * 0.02),
          Expanded(
            child: eventListProvider.filteredList.isEmpty
                ? Center(
                    child: Text(
                      "No Events Found",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.01,
                      vertical: height * 0.01,
                    ),
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Eventitem(
                          taskModel: eventListProvider.filteredList[index],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: height * 0.02);
                      },
                      itemCount: eventListProvider.filteredList.length,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
