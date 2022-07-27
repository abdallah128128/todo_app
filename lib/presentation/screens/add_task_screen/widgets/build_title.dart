import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/bloc/cubit.dart';
import 'package:todo_app/presentation/shared_widgets/my_text_form_field.dart';

class BuildTitle extends StatelessWidget {
  const BuildTitle({
    Key? key,
    required this.titleController,
  }) : super(key: key);

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Title',
          style: TextStyle(
              color: AppCubit.get(context).isDark ? Colors.white :Colors.black,
              fontSize: 16.sp, fontWeight: FontWeight.w500),),
        MyTextFormField(
          hintText: 'title',
          controller: titleController,
          type: TextInputType.text,
          validate: (String? value) {
            if (value!.isEmpty) {
              return 'title must not be empty';
            }
            return null;
          },
        ),
      ],
    );
  }
}