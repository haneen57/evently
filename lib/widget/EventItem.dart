import 'package:eventlyy/AppProvider/userProvider.dart';
import 'package:eventlyy/AppTheme/appTheme.dart';
import 'package:eventlyy/FireBaseManager/TaskModel.dart';
import 'package:eventlyy/screens/HoeScreen/event_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../AppProvider/EventListProvider.dart';

class Eventitem extends StatelessWidget {
  TaskModel taskModel;

  Eventitem({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    EvantListProvider eventListProvider = Provider.of<EvantListProvider>(
      context,
    );
    UserProvider userProvider=Provider.of<UserProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, EventDetailsScreen.routeName,arguments: taskModel);
      },
      child: Container(
        height: height * 0.25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(taskModel.image),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: width * 0.02, top: height * 0.01),
              decoration: BoxDecoration(
                color: AppTheme.whiteColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.008,
                  horizontal: width * 0.008,
                ),
                child: Column(
                  children: [
                    Text(
                      taskModel.date.day.toString(),
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Text(
                      DateFormat('MMM').format(taskModel.date),
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.015,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).focusColor,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.015,
                  vertical: height * 0.015,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      taskModel.title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    InkWell(
                      onTap: () {
                        eventListProvider.updateIsFavourite(taskModel,userProvider.currentUser!.id);
                      },
                      child: taskModel.isFav == true
                          ? Image.asset("assets/images/favourite.png")
                          : Icon(Icons.favorite_border),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
