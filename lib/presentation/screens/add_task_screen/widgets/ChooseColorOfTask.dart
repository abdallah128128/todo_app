import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChooseColorOfTask extends StatelessWidget {
  ChooseColorOfTask({
    Key? key,
    required this.backgroundColor,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);
  final Color backgroundColor;
  final void Function() onTap;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 19,
      backgroundColor: isSelected ? Colors.grey.shade400 : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: CircleAvatar(
          radius: 14,
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }
}