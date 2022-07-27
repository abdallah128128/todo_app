import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/bloc/cubit.dart';

class MyTextFormField extends StatelessWidget {
  String? labelText;
  String? emptyText;
  IconData? preFix;
  IconData? suffixIcon;
  Widget? suffixWidget;
  void Function()? suffixPressed;
  String? Function(String?)? validate;
  String? hintText;
  TextEditingController? controller;
  bool isPassword;
  TextInputType type;
  Color? cursorColor;
  double endPadding;

  MyTextFormField({
    Key? key,
    this.labelText,
    this.emptyText,
    this.hintText,
    this.preFix,
    required this.controller,
    required this.type,
    this.validate,
    this.suffixIcon,
    this.suffixWidget,
    this.suffixPressed,
    this.isPassword = false,
    this.cursorColor,
    this.endPadding=0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: double.infinity,
      padding: EdgeInsetsDirectional.only(
        start: 15.w,
        top: 15.h,
        end: endPadding.w,
        bottom: 3.h
      ),
      margin: EdgeInsetsDirectional.only(
        top: 5.h,
        bottom: 22.h
      ),
      decoration: BoxDecoration(
          color: AppCubit.get(context).isDark ? Colors.grey : Color(0xffebf3f9),
          borderRadius: BorderRadius.circular(12)),
      child: TextFormField(
        cursorColor: cursorColor,
        keyboardType: type,
        controller: controller,
        obscureText: isPassword,
        style: TextStyle(
          color: AppCubit.get(context).isDark ? Colors.white :Colors.grey.shade400,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: suffixPressed,
                  icon: Icon(
                    suffixIcon,
                    size: 20,
                    color: Colors.grey.shade400,
                  ),
                )
              : null,
          suffix: suffixWidget,
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppCubit.get(context).isDark ? Colors.white :Colors.grey.shade400,
            fontSize: 15.sp,),
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.sp,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
        validator: validate,
      ),
    );
  }
}
