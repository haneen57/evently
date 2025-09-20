import 'package:eventlyy/AppProvider/appProvider.dart';
import 'package:eventlyy/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../register/login/Login.dart';

class Introduction extends StatefulWidget {
  static const String routeName = 'Introduction';

  Introduction({super.key});

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  bool isArabic = false;
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              appProvider.appTheme == ThemeMode.light
                  ? "assets/images/Group 3.png"
                  : "assets/images/designer-desk.png",
            ),
            SizedBox(width: 12.w),
            Text(
              "Evently",
              style: GoogleFonts.jockeyOne(
                fontWeight: FontWeight.w400,
                fontSize: 36.sp,
                color: Color(0xFF5669FF),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 24, top: 42),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('assets/images/being-creative.png'),
            SizedBox(height: 28.h),
            Text(
              AppLocalizations.of(context)?.title ?? "",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color:Color(0xFF5669FF)),
            ),
            SizedBox(width: 12.w),
            Text(
              AppLocalizations.of(context)?.sub_title ?? '',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)?.language ?? '',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color:Color(0xFF5669FF))
                ),
                Spacer(),
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.r),
                        border: Border.all(
                          color: Color(0xFF5669FF),
                          width: 3.r,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            decoration: isArabic
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    border: Border.all(
                                      color: Color(0xFF5669FF),
                                      width: 5.r,
                                    ),
                                    color: Color(0xFF5669FF),
                                  )
                                : null,
                            child: InkWell(
                              onTap: () {
                                isArabic = true;
                                appProvider.changeLang("ar");
                              },
                              child: Image.asset(
                                "assets/images/EG.png",
                                height: 25.h,
                                width: 25.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          InkWell(
                            onTap: () {
                              isArabic = false;
                              appProvider.changeLang("en");
                            },
                            child: Container(
                              decoration: !isArabic
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      border: Border.all(
                                        color: Color(0xFF5669FF),
                                        width: 5.r,
                                      ),
                                      color: Color(0xFF5669FF),
                                    )
                                  : null,
                              child: Image.asset(
                                "assets/images/LR.png",
                                height: 25.h,
                                width: 25.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)?.theme ?? '',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color:Color(0xFF5669FF))
                ),
                Spacer(),
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.r),
                        border: Border.all(
                          color: Color(0xFF5669FF),
                          width: 3.r,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            decoration: !isDark
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
                                    border: Border.all(
                                      color: Color(0xFF5669FF),
                                      width: 5.r,
                                    ),
                                    color: Color(0xFF5669FF),
                                  )
                                : null,
                            child: InkWell(
                              onTap: () {
                                isDark = false;
                                appProvider.changeTheme(appProvider.appTheme);
                              },
                              child: Container(
                                decoration: !isDark
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          16.r,
                                        ),
                                        border: Border.all(
                                          color: Color(0xFF5669FF),
                                          width: 5.r,
                                        ),
                                        color: Color(0xFF5669FF),
                                      )
                                    : null,
                                child: Icon(
                                  Icons.sunny,
                                  color: !isDark
                                      ? Colors.white
                                      : Color(0xFF5669FF),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 14.w),
                          InkWell(
                            onTap: () {
                              isDark = true;
                              appProvider.changeTheme(appProvider.appTheme);
                            },
                            child: Container(
                              decoration: isDark
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(24.r),
                                      border: Border.all(
                                        color: Color(0xFF5669FF),
                                        width: 5.r,
                                      ),
                                      color: Color(0xFF5669FF),
                                    )
                                  : null,
                              child: Icon(
                                Icons.dark_mode,
                                color: isDark
                                    ? Colors.white
                                    : Color(0xFF5669FF),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 16.h),

            SizedBox(height: 32.h),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ElevatedButton(
                style:Theme.of(context).elevatedButtonTheme.style,
                onPressed: () {
                  Navigator.pushNamed(context, Login.routeName);
                },
                child: Text(
                  AppLocalizations.of(context)?.start ?? '',
                  style: TextStyle(fontSize: 20),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
