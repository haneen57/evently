import 'package:eventlyy/AppTheme/appTheme.dart';
import 'package:flutter/material.dart';

class WithoutSuffix extends StatelessWidget {
  String? HintText;
  Color? iconColor;
  Color? colorBorderSide;
  Widget? preIcon;
  IconData? suffIcon;
  TextEditingController? controller;
  TextStyle? textStyle;
  String? Function(String?)?onValidator;
  TextInputType? keyboardtype;
  bool obscure;
  int? lines;
  WithoutSuffix({
    super.key,
    this.lines,
    this.obscure=false,
    this.keyboardtype,
    this.controller,
    this.onValidator,
    this.suffIcon,
    this.iconColor,
    this.textStyle,
    this.colorBorderSide,
     this.HintText,
     this.preIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines:obscure ? 1 : (lines ?? 1),
      controller: controller,
      validator:onValidator,
      decoration: InputDecoration(
        prefixIcon: preIcon,
        hintText: HintText,
        suffixIcon: Icon(suffIcon,color: iconColor,size: 30),
        hintStyle:textStyle,
        enabledBorder: buildDecBorder(colorBorderSide:colorBorderSide),
        focusedBorder: buildDecBorder(colorBorderSide:colorBorderSide),
        errorBorder:buildDecBorder(colorBorderSide:AppTheme.redColor),
        focusedErrorBorder: buildDecBorder(colorBorderSide:AppTheme.redColor),
      ),
      keyboardType: keyboardtype,
      obscureText: obscure,
      obscuringCharacter: "*",
    );
  }
  buildDecBorder({required colorBorderSide}){
  return  OutlineInputBorder(
      borderSide: BorderSide(color: colorBorderSide),
      borderRadius: BorderRadius.circular(16),
    );
  }
}
