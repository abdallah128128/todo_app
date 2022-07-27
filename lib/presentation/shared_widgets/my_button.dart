import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? textColor;
  final Color? buttonColor;
  final double textFontSize;
  final double height;
  final double width;
  final double buttonBorder;
  final double paddingAll;


  const MyButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.textColor = Colors.white,
    this.buttonColor = Colors.teal,
    this.textFontSize = 17,
    this.height =50,
    this.width =double.infinity,
    this.buttonBorder=10,
    this.paddingAll=20,



  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(paddingAll),
      child: MaterialButton(
        elevation: 0.0,
        minWidth: width,
        height: height,
        color: buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(buttonBorder))),
        onPressed: onPressed,
        child: Text(
          text,

          style: TextStyle(
            color: textColor,
            fontSize:textFontSize,
            letterSpacing: 2,
            fontFamily: 'Jannah',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}