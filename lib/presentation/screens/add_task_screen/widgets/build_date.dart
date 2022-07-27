import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/bloc/cubit.dart';
import 'package:todo_app/presentation/shared_widgets/my_text_form_field.dart';

class BuildDate extends StatelessWidget {
  const BuildDate({
    Key? key,
    required this.dateController,
  }) : super(key: key);

  final TextEditingController dateController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Date',
          style: TextStyle(
              color: AppCubit.get(context).isDark ? Colors.white :Colors.black,
              fontSize: 16.sp, fontWeight: FontWeight.w500),),
        MyTextFormField(
          controller: dateController,
          hintText: 'Enter the date of task',
          type: TextInputType.text,
          suffixIcon: Icons.keyboard_arrow_down,
          suffixPressed: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.parse('2050-12-03'),
            ).then((value) {
              dateController.text =
                  DateFormat.yMMMd().format(value!);
            });
          },
          validate: (String? value) {
            if (value!.isEmpty) {
              return 'time must not be empty';
            }
            return null;
          },
        ),
      ],
    );
  }
}