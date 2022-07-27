import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/bloc/cubit.dart';
import 'package:todo_app/bloc/states.dart';
import 'package:todo_app/presentation/screens/add_task_screen/add_task_screen.dart';
import 'package:todo_app/presentation/screens/board_screen/widgets/build_tabBar_view.dart';
import 'package:todo_app/presentation/screens/schedule_screen/schedule_screen.dart';
import 'package:todo_app/presentation/shared_widgets/my_button.dart';
import 'package:todo_app/presentation/shared_widgets/utils.dart';

class BoardPage extends StatelessWidget {
  const BoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Board',
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.brightness_4_outlined,
                    color: AppCubit.get(context).isDark
                        ? Colors.white
                        : Colors.grey.shade500,
                  ),
                  onPressed: () {
                    AppCubit.get(context).changeAppMode();
                  },
                ),
                IconButton(
                    onPressed: () {
                      cubit.getTodayTasks(cubit.database,
                          DateFormat.yMMMd().format(DateTime.now()));
                      navigateTo(context, const ScheduleScreen());
                    },
                    icon: Icon(
                      Icons.calendar_month,
                      color: AppCubit.get(context).isDark
                          ? Colors.white
                          : Colors.grey.shade500,
                    )),
              ],
            ),
            body: Column(
              children: [
                TabBar(
                  isScrollable: true,
                  indicatorColor: AppCubit.get(context).isDark
                      ? Colors.white
                      : Colors.black,
                  indicatorWeight: 3,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 15),
                  unselectedLabelColor: AppCubit.get(context).isDark
                      ? Colors.white.withOpacity(.6)
                      : Colors.grey.shade400,
                  labelColor: AppCubit.get(context).isDark
                      ? Colors.white
                      : Colors.black,
                  indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 2.0,
                        color: AppCubit.get(context).isDark
                            ? Colors.white
                            : Colors.black,
                      ),
                      insets: EdgeInsets.symmetric(horizontal: 30.0)),
                  tabs: [
                    Tab(
                        child: Text(
                      "All",
                      style: TextStyle(fontSize: 15.sp),
                    )),
                    Tab(
                        child: Text(
                      "Completed",
                      style: TextStyle(fontSize: 15.sp),
                    )),
                    Tab(
                        child: Text(
                      "UnCompleted",
                      style: TextStyle(fontSize: 15.sp),
                    )),
                    Tab(
                        child: Text(
                      "Favorite",
                      style: TextStyle(fontSize: 15.sp),
                    )),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 0.7.h,
                  color: Colors.grey.shade300,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TabBarView(children: [
                      BuildTabBarView(
                        condition: cubit.allTasks.isNotEmpty,
                        itemCount: cubit.allTasks.length,
                        item: cubit.allTasks,
                        fallbackText: 'There is No Tasks Yet',
                      ),
                      BuildTabBarView(
                        condition: cubit.completedTasks.isNotEmpty,
                        itemCount: cubit.completedTasks.length,
                        item: cubit.completedTasks,
                        fallbackText: 'No Completed Task',
                      ),
                      BuildTabBarView(
                        condition: cubit.unCompletedTasks.isNotEmpty,
                        itemCount: cubit.unCompletedTasks.length,
                        item: cubit.unCompletedTasks,
                        fallbackText: 'No UnCompleted Task',
                      ),
                      BuildTabBarView(
                        condition: cubit.favoriteTasks.isNotEmpty,
                        itemCount: cubit.favoriteTasks.length,
                        item: cubit.favoriteTasks,
                        fallbackText: 'No Favorite Task',
                      ),
                    ]),
                  ),
                ),
                MyButton(
                  text: 'Add a Task',
                  buttonColor: const Color(0xff25c06d),
                  buttonBorder: 12,
                  onPressed: () {
                    navigateTo(context, const AddTaskPage());
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
