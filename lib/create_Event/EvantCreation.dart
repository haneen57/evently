import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventlyy/AppProvider/appProvider.dart';
import 'package:eventlyy/AppProvider/userProvider.dart';
import 'package:eventlyy/AppTheme/appTheme.dart';
import 'package:eventlyy/FireBaseManager/TaskModel.dart';
import 'package:eventlyy/FireBaseManager/fireManager.dart';
import 'package:eventlyy/l10n/app_localizations.dart';
import 'package:eventlyy/widget/withoutSuffix.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../AppProvider/EventListProvider.dart';

class EvantCreation extends StatefulWidget {
  static const String routeName = 'Create Event';

  EvantCreation({super.key});

  @override
  State<EvantCreation> createState() => _EvantCreationState();
}

class _EvantCreationState extends State<EvantCreation> {
  int currInddex = 0;
  var formKey = GlobalKey<FormState>();
  String selectedImage = '';
  String selectedImageW = '';
  String selectedCategory = '';
  String formattedTime = '';
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController decriptionController = TextEditingController();
  List<String> images = [
    "assets/images/BookClub.png",
    "assets/images/Sport.png",
    "assets/images/Birthday.png",
    "assets/images/Meeting.png",
    "assets/images/Eating.png",
    "assets/images/WorkShop.png",
    "assets/images/Exihibition.png",
    "assets/images/Gaming.png",
    "assets/images/Holiday.png",
  ];
  List<String> imagesW = [
    "assets/images/bookclubw.png",
    "assets/images/sportw.png",
    "assets/images/birthdayw.png",
    "assets/images/meetingw.png",
    "assets/images/eatingw.png",
    "assets/images/workshopw.png",
    "assets/images/exhibition.png",
    "assets/images/gamingw.png",
    "assets/images/holidayw.png",
  ];
  TimeOfDay selectTime = TimeOfDay.now();
  late EvantListProvider eventListProvider;

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      AppLocalizations.of(context)!.bookclub,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.eating,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.holiday,
    ];
    selectedImageW = imagesW[currInddex];
    selectedImage = images[currInddex];
    selectedCategory = categories[currInddex];
    AppProvider appProvider = Provider.of<AppProvider>(context);
    eventListProvider=Provider.of<EvantListProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Theme.of(context).highlightColor),
        backgroundColor: Colors.transparent,
        title: Text(
          AppLocalizations.of(context)!.creating,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),

          child: SingleChildScrollView(
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 220,
                  width: 220,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      appProvider.appTheme == ThemeMode.light
                          ? selectedImage
                          : selectedImageW,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  height: height * 0.05,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          currInddex = index;
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: currInddex == index
                                ? Color(0xFF5669FF)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Color(0xFF5669FF)),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              categories[index],
                              style: TextStyle(
                                color: currInddex == index
                                    ? Colors.white
                                    : Color(0xFF5669FF),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(width: 12),
                    itemCount: categories.length,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.title,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                WithoutSuffix(
                  HintText: AppLocalizations.of(context)!.enter_title,
                  textStyle: TextStyle(color: Theme.of(context).cardColor),
                  controller: titleController,
                  colorBorderSide: Theme.of(context).hintColor,
                  onValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return "title is required";
                    }
                    return null;
                  },
                  preIcon: Icon(
                    Icons.edit,
                    size: 30,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                Text(AppLocalizations.of(context)!.description),
                WithoutSuffix(
                  onValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return "description is required";
                    }
                    return null;
                  },
                  lines: 4,
                  textStyle: TextStyle(color: Theme.of(context).cardColor),
                  HintText: AppLocalizations.of(context)!.enter_des,
                  controller: decriptionController,
                  colorBorderSide: Theme.of(context).hintColor,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      color: Theme.of(context).hintColor,
                      size: 35,
                    ),
                    SizedBox(width: width * 0.03),
                    Text(
                      AppLocalizations.of(context)!.date,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        chooseDate();
                      },
                      child: Text(
                        selectedDate.toString().substring(0, 10),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.blueColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Theme.of(context).hintColor,
                      size: 30,
                    ),
                    SizedBox(width: width * 0.03),
                    Text(
                      AppLocalizations.of(context)!.time,

                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        chooseTime();
                      },
                      child: Text(
                        formattedTime.isNotEmpty
                            ? formattedTime
                            : selectTime.format(context),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.blueColor,
                        ),
                      ),
                    ),
                  ],
                ),

                Text(
                  AppLocalizations.of(context)!.location,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Theme.of(context).focusColor),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    foregroundColor: AppTheme.blueColor,
                  ),
                  onPressed: () {
                    addEvent();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.015),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppTheme.blueColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: height * 0.01,
                              horizontal: width * 0.02,
                            ),
                            child: Icon(
                              Icons.my_location,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          AppLocalizations.of(context)!.choosing,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppTheme.blueColor),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: height * 0.015),
                    backgroundColor: AppTheme.blueColor,
                    foregroundColor: AppTheme.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    addEvent();
                  },
                  child: Text(
                    AppLocalizations.of(context)!.editing,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: AppTheme.whiteColor,
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

  chooseDate() async {
    DateTime? choosingDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (choosingDate != null) {
      setState(() {
        selectedDate = choosingDate;
      });
    }
  }

  chooseTime() async {
    TimeOfDay? chosenTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    formattedTime = chosenTime!.format(context);
    setState(() {});
  }

  addEvent() {
    if (formKey.currentState!.validate()) {
      TaskModel task = TaskModel(
        image: selectedImage,
        title: titleController.text,
        category: selectedCategory,
        description: decriptionController.text,
        time: formattedTime,
        date: selectedDate,
      );
      UserProvider userProvider=Provider.of<UserProvider>(context,listen: false);
      FireManager.CreateEvent(task,userProvider.currentUser!.id).then((value) {
        Fluttertoast.showToast(msg: "Created Event",);
      },).timeout(
        Duration(milliseconds: 500),
        onTimeout: (){},
      ).onError((error, stackTrace) =>
      showDialog(
      context: context,
      builder: (context) => AlertDialog(
      title: Text("Something went Wrong"),
      actions: [Text("Ok")],
      ),
      ));
      eventListProvider.gertEventCollection(userProvider.currentUser!.id);
      Navigator.pop(context);
    }
  }


}
