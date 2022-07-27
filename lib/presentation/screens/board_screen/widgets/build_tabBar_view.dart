import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/bloc/cubit.dart';
import 'package:todo_app/core/themes/colors.dart';
import 'package:todo_app/presentation/shared_widgets/build_task_item.dart';
import 'package:todo_app/presentation/shared_widgets/utils.dart';

class BuildTabBarView extends StatelessWidget {
  const BuildTabBarView({
    Key? key,
    required this.itemCount,
    required this.item,
    required this.condition,
    required this.fallbackText,
  }) : super(key: key);

  final int itemCount;
  final List<Map> item;
  final bool condition;
  final String fallbackText;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: AppCubit.get(context).isDark ? darkColor : Colors.white ,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ConditionalBuilder(
              condition: condition,
              builder: (context) => ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => BuildTaskItem(
                  isFavorite: toBoolean(item[index]['isFavorite']),
                  isComplete: toBoolean(item[index]['isComplete']),
                  item: item[index],
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 12,
                ),
                itemCount: itemCount,
              ),
              fallback: (context) => Center(
                  child: Text(
                fallbackText,
                style: TextStyle(color: Colors.grey.shade500, fontSize: 25),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
