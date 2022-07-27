import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/bloc/cubit.dart';
import 'package:todo_app/bloc/states.dart';
import 'package:todo_app/core/themes/colors.dart';
import 'package:todo_app/presentation/screens/add_task_screen/widgets/build_date.dart';
import 'package:todo_app/presentation/screens/add_task_screen/widgets/build_end_time.dart';
import 'package:todo_app/presentation/screens/add_task_screen/widgets/build_start_time.dart';
import 'package:todo_app/presentation/screens/add_task_screen/widgets/build_title.dart';
import 'package:todo_app/presentation/screens/add_task_screen/widgets/ChooseColorOfTask.dart';
import 'package:todo_app/presentation/screens/board_screen/board_screen.dart';
import 'package:todo_app/presentation/shared_widgets/my_button.dart';
import 'package:todo_app/presentation/shared_widgets/utils.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  var titleController = TextEditingController();

  var dateController = TextEditingController();

  var startTimeController = TextEditingController();

  var endTimeController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Color color = Colors.grey;
  String remind = '';

  ChooseColorOfTask? chooseColourWidget ;
  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Add task',
            ),
            leading: IconButton(
                onPressed: () {
                  navigateAndFinish(context, const BoardPage());
                },
                icon: const Icon(Icons.arrow_back_ios)),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Stack(
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        BuildTitle(titleController: titleController),
                        //------------------------------------------------------------------
                        BuildDate(dateController: dateController),
                        //------------------------------------------------------------------
                        Row(
                          children: [
                            Expanded(
                              child: BuildStartTime(
                                  startTimeController: startTimeController),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Expanded(
                              child: BuildEndTime(
                                  endTimeController: endTimeController),
                            ),
                          ],
                        ),
                        //------------------------------------------------------------------
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Remind',
                              style: TextStyle(
                                  color: AppCubit.get(context).isDark ? Colors.white :Colors.black,
                                  fontSize: 16.sp, fontWeight: FontWeight.w500),
                            ),
                            Container(
                              padding: EdgeInsetsDirectional.only(
                                  start: 15.w, end: 8.w,),
                              margin: EdgeInsetsDirectional.only(
                                  top: 5.h, bottom: 18.h),
                              height: 50.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: AppCubit.get(context).isDark ? Colors.grey : Color(0xffebf3f9),
                                  borderRadius: BorderRadius.circular(12)),
                              child: DropdownButtonFormField(
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'title must not be empty';
                                  }
                                  return null;
                                },
                                  hint: Text(
                                    'chose reminder',
                                    style: TextStyle(
                                        color: AppCubit.get(context).isDark ? Colors.white :Colors.grey.shade400,
                                        fontSize: 15.sp),
                                  ),
                                  focusColor: Colors.grey.shade400,
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey.shade400,
                                    labelStyle:
                                        TextStyle(color: Colors.grey.shade400),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        10.0,
                                      ),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),
                                  items: [
                                    "1 day before",
                                    "1 hour before",
                                    "30 min before",
                                    "10 min before"
                                  ]
                                      .map(
                                        (label) => DropdownMenuItem(
                                          value: label,
                                          child: Text(label,style: TextStyle(color:Colors.grey.shade400),),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      remind = value!;
                                    });
                                  }),
                            ),
                          ],
                        ),
                        //------------------------------------------------------------------
                        SizedBox(height: 10.h,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Choose task color',
                              style: TextStyle(
                                  color: AppCubit.get(context).isDark ? Colors.white :Colors.black,
                                  fontSize: 16.sp, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 10.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ChooseColorOfTask(
                                  backgroundColor: myRed,
                                  onTap: () {
                                    cubit.changeColorIndex(0);
                                  },
                                  isSelected: cubit.colorIndex == 0,
                                ),
                                ChooseColorOfTask(
                                  backgroundColor: myOrange,
                                  onTap: () {
                                    cubit.changeColorIndex(1);
                                  },
                                  isSelected: cubit.colorIndex == 1,
                                ),
                                ChooseColorOfTask(
                                  backgroundColor: myYellow,
                                  onTap: () {
                                    cubit.changeColorIndex(2);
                                  },
                                  isSelected: cubit.colorIndex == 2,
                                ),
                                ChooseColorOfTask(
                                  backgroundColor: myBlue,
                                  onTap: () {
                                    cubit.changeColorIndex(3);
                                  },
                                  isSelected: cubit.colorIndex == 3,
                                ),
                                ChooseColorOfTask(
                                  backgroundColor: myGreen,
                                  onTap: () {
                                    cubit.changeColorIndex(4);
                                  },
                                  isSelected: cubit.colorIndex == 4,
                                ),
                                ChooseColorOfTask(
                                  backgroundColor: myBrown,
                                  onTap: () {
                                    cubit.changeColorIndex(5);
                                  },
                                  isSelected: cubit.colorIndex == 5,
                                ),
                                ChooseColorOfTask(
                                  backgroundColor: myTeal,
                                  onTap: () {
                                    cubit.changeColorIndex(6);
                                  },
                                  isSelected: cubit.colorIndex == 6,
                                ),
                              ],
                            ),
                          ],
                        ),
                        //------------------------------------------------------------------
                        SizedBox(
                          height: 45.h,
                        ),
                        MyButton(
                          text: 'Create a task',
                          paddingAll: 0,
                          buttonColor: const Color(0xff25c06d),
                          buttonBorder: 12,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.insertToDataBase(
                                title: titleController.text,
                                date: dateController.text,
                                startTime: startTimeController.text,
                                endTime: endTimeController.text,
                                remind: remind,
                                color: AppCubit.get(context).noteColor.toString(),
                              );
                              navigateAndFinish(context, const BoardPage());
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
