import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/bloc/cubit.dart';
import 'package:todo_app/presentation/shared_widgets/utils.dart';

class BuildScheduleItem extends StatefulWidget {
  const BuildScheduleItem({
    Key? key,
    required this.item,
    required this.isFavorite,
    required this.isComplete,
  }) : super(key: key);
  final Map item;
  final bool isFavorite;
  final bool isComplete;

  @override
  // ignore: no_logic_in_create_state
  State<BuildScheduleItem> createState() => _BuildScheduleItemState(
      isFavorite: isFavorite, item: item, isComplete: isComplete);
}

class _BuildScheduleItemState extends State<BuildScheduleItem> {
  bool isFavorite;
  bool isComplete;
  Map item;

  _BuildScheduleItemState(
      {required this.isFavorite, required this.isComplete, required this.item});

  @override
  Widget build(BuildContext context) {
    var cubit=AppCubit.get(context);
    return Container(
      decoration: BoxDecoration(
        color: convertToColor(widget.item['color']),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      //margin: const EdgeInsets.symmetric(horizontal: 12),
      height: 60.h,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget.item['startTime']}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  '${widget.item['title']}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Checkbox(
              side: const BorderSide(color: Colors.white, width: 1.5),
              activeColor: Colors.white.withOpacity(.5),
              checkColor: Colors.white,
              value: widget.isComplete,
              onChanged: (val){
                setState(() {
                  isComplete = val!;
                  cubit.updateIsCompleteInDataBase(
                      isComplete: isComplete.toString(), id: widget.item['id']);
                  cubit.getTodayTasks(cubit.database, DateFormat.yMMMd().format(cubit.selectedDay));
                });
              }),
        ],
      ),
    );
  }
}
