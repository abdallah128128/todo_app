import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/bloc/cubit.dart';
import 'package:todo_app/presentation/shared_widgets/my_text_form_field.dart';

class BuildEndTime extends StatelessWidget {
  const BuildEndTime({Key? key, required this.endTimeController}) : super(key: key);

  final TextEditingController endTimeController;
  @override
  Widget build(BuildContext context) {
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('End time', style: TextStyle(
            color: AppCubit.get(context).isDark ? Colors.white :Colors.black,
            fontSize: 16.sp, fontWeight: FontWeight.w500),),
        MyTextFormField(
          controller: endTimeController,
          hintText: 'End time',
          type: TextInputType.text,
          suffixIcon: Icons.watch_later_outlined,
          suffixPressed: () {
            showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            ).then((value) {
              endTimeController.text =
                  value!.format(context).toString();
            });
          },
          validate: (String? value) {
            if (value!.isEmpty) {
              return 'End time must not be empty';
            }
            return null;
          },
        ),
      ],
    );
  }
}
