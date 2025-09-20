import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventlyy/AppProvider/appProvider.dart';
import 'package:eventlyy/AppProvider/userProvider.dart';
import 'package:eventlyy/AppTheme/appTheme.dart';
import 'package:eventlyy/FireBaseManager/TaskModel.dart';
import 'package:eventlyy/FireBaseManager/fireManager.dart';
import 'package:eventlyy/l10n/app_localizations.dart';
import 'package:eventlyy/widget/showDialog.dart';
import 'package:eventlyy/widget/withoutSuffix.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../AppProvider/EventListProvider.dart';

class EditEvent extends StatefulWidget {
  static const String routeName = 'edit Event';

  EditEvent({super.key});

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  var formKey = GlobalKey<FormState>();
  String selectedImage = '';
  String selectedImageW = '';
  String selectedCategory = '';
  late String formattedTime ;
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
  late var args;
  late int currInddex;
  List<String> categories = [];
  bool isFirstTime = true;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isFirstTime) {

      args = ModalRoute.of(context)!.settings.arguments as TaskModel;

      selectedCategory = args.category;
      selectedImage = args.image;
      titleController.text = args.title;
      decriptionController.text = args.description;
      formattedTime = args.time;
      selectedDate = args.date;
      categories = [
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

      currInddex = categories.indexOf(args.category);
      isFirstTime = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    eventListProvider=Provider.of<EvantListProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Theme.of(context).highlightColor),
        backgroundColor: Colors.transparent,
        title: Text(
          "Edit Event",
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
                      selectedImage,
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

                          setState(() {
                            currInddex = index;
                            selectedCategory = categories[currInddex];
                            selectedImage = images[currInddex];
                          });
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
                  args.title,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                WithoutSuffix(
                  controller: titleController,
                  HintText: titleController.text,
                  textStyle: TextStyle(color: Theme.of(context).cardColor),
                  colorBorderSide: Theme.of(context).hintColor,
                  preIcon: Icon(
                    Icons.edit,
                    size: 30,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                Text(AppLocalizations.of(context)!.description),
                WithoutSuffix(
                  controller: decriptionController,
                  HintText:decriptionController.text,
                  lines: 4,
                  textStyle: TextStyle(color: Theme.of(context).cardColor),
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
                        formattedTime,
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
                    editEvent();
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

  editEvent()async {

    if (formKey.currentState!.validate()) {

      UserProvider userProvider=Provider.of<UserProvider>(context,listen: false);
      TaskModel task = TaskModel(
        id: args.id,
        image: selectedImage,
        title: titleController.text.isNotEmpty ? titleController.text : args.title,
        category: selectedCategory,
        description: decriptionController.text.isNotEmpty ? decriptionController.text : args.description,
        time: formattedTime.isNotEmpty ? formattedTime : args.time,
        date: selectedDate,
      );

      try
      {
        await eventListProvider.editEvent(userProvider.currentUser!.id, task).then((
            value) {
          Fluttertoast.showToast(msg: "Updated Event",
          gravity: ToastGravity.CENTER);
        },).timeout(
          Duration(milliseconds: 800),
        );
        eventListProvider.gertEventCollection(userProvider.currentUser!.id);
        Navigator.pop(context,task);
      }
      catch(e){
        ShowDialog.showMsg(context: context, msg: "Something went wrong $e");
        print(e);
      }
    }
  }


}
