import 'package:eventlyy/AppProvider/EventListProvider.dart';
import 'package:eventlyy/AppProvider/userProvider.dart';
import 'package:eventlyy/AppTheme/appTheme.dart';
import 'package:eventlyy/l10n/app_localizations.dart';
import 'package:eventlyy/widget/EventItem.dart';
import 'package:eventlyy/widget/withoutSuffix.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavTab extends StatefulWidget {
  static const String routeName = 'fav';

  FavTab({super.key});

  @override
  State<FavTab> createState() => _FavTabState();
}

class _FavTabState extends State<FavTab> {
  late EvantListProvider evantListProvider;
  late UserProvider userProvider;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      evantListProvider.getFavFromFireStore(userProvider.currentUser!.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    userProvider=Provider.of<UserProvider>(context);
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    evantListProvider = Provider.of<EvantListProvider>(context);
    return SafeArea(
      child:
      Padding(
        padding: EdgeInsets.only(
          top: height * 0.07,
          left: width * 0.03,
          right: width * 0.03,
        ),
        child: Column(
          children: [
            WithoutSuffix(
              iconColor: AppTheme.blueColor,
              textStyle: Theme
                  .of(context)
                  .textTheme
                  .headlineSmall,
              colorBorderSide: AppTheme.blueColor,
              HintText: AppLocalizations.of(context)!.search,
              preIcon: Icon(Icons.search, size: 30,),),
            Expanded(
              child:
              evantListProvider.favList.isEmpty ? Center(
                child: Text("No Favourite Events",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
              ):Padding(
                padding: EdgeInsets.only(top: height * 0.02),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Eventitem(
                        taskModel: evantListProvider.favList[index]);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: height * 0.02);
                  },
                  itemCount: evantListProvider.favList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
