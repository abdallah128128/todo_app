import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/bloc/cubit.dart';
import 'package:todo_app/presentation/shared_widgets/my_text_form_field.dart';

class BuildStartTime extends StatelessWidget {
  const BuildStartTime({Key? key, required this.startTimeController}) : super(key: key);

  final TextEditingController startTimeController;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Start time', style: TextStyle(
            color: AppCubit.get(context).isDark ? Colors.white :Colors.black,
            fontSize: 16.sp, fontWeight: FontWeight.w500),),
        MyTextFormField(
          controller: startTimeController,
          hintText: 'start time',
          type: TextInputType.text,
          suffixIcon: Icons.watch_later_outlined,
          suffixPressed: () {
            showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            ).then((value) {
              startTimeController.text =
                  value!.format(context).toString();
            });
          },
          validate: (String? value) {
            if (value!.isEmpty) {
              return 'Start time must not be empty';
            }
            return null;
          },
        ),
      ],
    );
  }
}
