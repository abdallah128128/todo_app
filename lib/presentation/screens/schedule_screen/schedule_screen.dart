import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/bloc/cubit.dart';
import 'package:todo_app/bloc/states.dart';
import 'package:todo_app/presentation/screens/board_screen/board_screen.dart';
import 'package:todo_app/presentation/screens/schedule_screen/widgets/build_sch_item.dart';
import 'package:todo_app/presentation/shared_widgets/utils.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  var dateController = DatePickerController();

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  cubit.getDataFromDataBase(cubit.database);
                  navigateAndFinish(context, const BoardPage());
                },
                icon: const Icon(Icons.arrow_back_ios)),
            title: const Text(
              'Schedule',
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: DatePicker(
                  controller: dateController,
                  DateTime.now(),
                  height: 75.h,
                  width: 50.h,
                  initialSelectedDate: DateTime.now(),
                  onDateChange: (date) {
                    debugPrint('On Date Change : New Date');
                    debugPrint(DateFormat.yMMMd().format(date));
                    cubit.changeSelectedDay(date);
                    cubit.getTodayTasks(
                        cubit.database, DateFormat.yMMMd().format(date));
                  },
                  selectionColor: cubit.isDark ? Colors.grey :Colors.green,
                  selectedTextColor: cubit.isDark ? Colors.amber :Colors.white,
                  dateTextStyle: TextStyle(
                    fontSize: 12.sp,
                    color: cubit.isDark ? Colors.white : Colors.grey.shade700,
                  ),
                  dayTextStyle: TextStyle(
                    fontSize: 9.sp,
                    color: cubit.isDark ? Colors.white : Colors.grey.shade700,
                  ),
                  monthTextStyle: TextStyle(
                    fontSize: 9.sp,
                    color: cubit.isDark ? Colors.white : Colors.grey.shade700,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 0.7.h,
                color: Colors.grey.shade400,
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('EEEE').format(cubit.selectedDay),
                          style: TextStyle(
                              color: cubit.isDark ? Colors.amber : Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(DateFormat.yMMMd().format(cubit.selectedDay),
                            style: TextStyle(
                                color: cubit.isDark
                                    ? Colors.amber
                                    : Colors.grey.shade600)),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Column(
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => BuildScheduleItem(
                            item: cubit.filteredTasksBasedOnDate[index],
                            isFavorite: toBoolean(cubit
                                .filteredTasksBasedOnDate[index]['isFavorite']),
                            isComplete: toBoolean(cubit
                                .filteredTasksBasedOnDate[index]['isComplete']),
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 15.h,
                          ),
                          itemCount: cubit.filteredTasksBasedOnDate.length,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
