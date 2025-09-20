import 'package:eventlyy/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../AppProvider/appProvider.dart';
import '../../AppTheme/appTheme.dart';

class Themesheet extends StatefulWidget {
  const Themesheet({super.key});

  @override
  State<Themesheet> createState() => _ThemesheetState();
}

class _ThemesheetState extends State<Themesheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.02,
        horizontal: width * 0.04,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              appProvider.changeTheme(ThemeMode.dark);
            },
            child: appProvider.appTheme==ThemeMode.dark
                ? selctedTheme(AppLocalizations.of(context)!.dark)
                : unSelctedTheme(AppLocalizations.of(context)!.dark),
          ),
          SizedBox(height: height * 0.02),
          InkWell(
            onTap: () {
              appProvider.changeTheme(ThemeMode.light);
            },
            child: appProvider.appTheme==ThemeMode.light
                ? selctedTheme(AppLocalizations.of(context)!.light)
                : unSelctedTheme(AppLocalizations.of(context)!.light),
          ),
        ],
      ),
    );
  }

  selctedTheme(String theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(theme, style: Theme.of(context).textTheme.headlineLarge),
        Icon(Icons.check, color: AppTheme.blueColor, size: 40),
      ],
    );
  }

  unSelctedTheme(String theme) {
    return Text(theme, style: Theme.of(context).textTheme.headlineMedium);
  }

}
