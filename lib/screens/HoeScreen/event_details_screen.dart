import 'package:eventlyy/AppProvider/EventListProvider.dart';
import 'package:eventlyy/AppProvider/userProvider.dart';
import 'package:eventlyy/AppTheme/appTheme.dart';
import 'package:eventlyy/FireBaseManager/TaskModel.dart';
import 'package:eventlyy/screens/HoeScreen/edit_event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatefulWidget {
  static const String routeName = 'details';

  EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  late var args;

  bool isInitialized=false;
@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if(isInitialized==false) {
      args = ModalRoute.of(context)!.settings.arguments as TaskModel;
      isInitialized=true;
    }
  }


  @override
  Widget build(BuildContext context) {
    EvantListProvider evantListProvider = Provider.of<EvantListProvider>(
      context,
    );
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.whiteColor,
        title: Text(
          "Event Details",
          style: TextStyle(color: AppTheme.blueColor, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              evantListProvider.deleteEvent(args, userProvider.currentUser!.id);
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.delete_forever,
              color: AppTheme.blueColor,
              size: 28,
            ),
          ),
          SizedBox(width: 6),
          IconButton(
            onPressed: () async {
              var result = await Navigator.pushNamed(
                context,
                EditEvent.routeName,
                arguments: args,
              );

              if (result is TaskModel) {
                await evantListProvider.gertEventCollection(
                  userProvider.currentUser!.id,
                );

                TaskModel updatedTask = evantListProvider
                    .filteredList
                    .firstWhere(
                      (task) => task.id == result.id,
                      orElse: () => result, // fallback لو مش لاقيه
                    );

                setState(() {
                  args = updatedTask;
                });
              }
            },
            icon: Icon(Icons.edit, color: AppTheme.blueColor, size: 28),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8,
                ),
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage(args.image),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Text(
                args.title,
                style: TextStyle(color: AppTheme.blueColor, fontSize: 24),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.blueColor, width: 2),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.calendar_month_outlined,
                        size: 45,
                        color: AppTheme.blueColor,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              args.date.day.toString(),
                              style: TextStyle(color: AppTheme.blueColor),
                            ),
                            SizedBox(width: 4),
                            Text(
                              DateFormat.MMMM().format(args.date),
                              style: TextStyle(color: AppTheme.blueColor),
                            ),
                            SizedBox(width: 4),
                            Text(
                              args.date.toString().substring(0, 4),
                              style: TextStyle(color: AppTheme.blueColor),
                            ),
                          ],
                        ),
                        Text(
                          args.time,
                          style: TextStyle(color: AppTheme.blackColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.blueColor, width: 2),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.my_location,
                        size: 45,
                        color: AppTheme.blueColor,
                      ),
                    ),
                    Text(
                      "Cairo,Egypt",
                      style: TextStyle(color: AppTheme.blueColor, fontSize: 20),
                    ),
                  ],
                ),
              ),
              Text("Description", style: TextStyle(fontSize: 24)),

              Text(args.description, style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
