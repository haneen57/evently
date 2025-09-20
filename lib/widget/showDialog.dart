import 'package:eventlyy/AppTheme/appTheme.dart';
import 'package:flutter/material.dart';

class ShowDialog {
  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMsg({
    required BuildContext context,
    required String msg,
    String? posMsg,
    String? preMsg,
    Function? posAction,
    Function? preAction,
  })
  {
    List<Widget> actions = [];
    if (posMsg != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(
            posMsg,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      );
    }
    if (preMsg != null) {
      actions.add(
        TextButton(
          onPressed: (){
            preAction?.call();
            Navigator.pop(context);
          },
          child: Text(
            preMsg,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
      );
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: actions,
        content: Text(
          msg,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
    );

  }
  static void showLoading({required BuildContext context}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 4),
            Text(
              "Loading...",
              style: TextStyle(
                color: AppTheme.blackColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}