import 'package:eventlyy/AppProvider/appProvider.dart';
import 'package:eventlyy/AppTheme/appTheme.dart';
import 'package:eventlyy/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Langsheet extends StatefulWidget {
  const Langsheet({super.key});

  @override
  State<Langsheet> createState() => _LangsheetState();
}

class _LangsheetState extends State<Langsheet> {
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
              appProvider.changeLang("en");
            },
            child: appProvider.appLang == 'en'
                ? selctedLang(AppLocalizations.of(context)!.english)
                : unSelctedLang(AppLocalizations.of(context)!.english),
          ),
          SizedBox(height: height * 0.02),
          InkWell(
            onTap: () {
              appProvider.changeLang("ar");
            },
            child: appProvider.appLang == 'ar'
                ? selctedLang(AppLocalizations.of(context)!.arabic)
                : unSelctedLang(AppLocalizations.of(context)!.arabic),
          ),
        ],
      ),
    );
  }

  selctedLang(String lang) {
   return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(lang, style: Theme.of(context).textTheme.headlineLarge),
        Icon(Icons.check, color: AppTheme.blueColor, size: 40),
      ],
    );
  }

  unSelctedLang(String lang) {
    return Text(lang, style: Theme.of(context).textTheme.headlineMedium);
  }
}
