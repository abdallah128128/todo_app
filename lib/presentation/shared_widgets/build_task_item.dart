import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/bloc/cubit.dart';
import 'package:todo_app/presentation/shared_widgets/utils.dart';

class BuildTaskItem extends StatefulWidget {
  const BuildTaskItem(
      {Key? key,
      required this.isFavorite,
      required this.item,
      required this.isComplete
      })
      : super(key: key);

  final bool isFavorite;
  final bool isComplete;
  final Map item;

  @override
  // ignore: no_logic_in_create_state
  State<BuildTaskItem> createState() => _BuildTaskItemState(
      isFavorite: isFavorite, item: item,
      isComplete: isComplete
  );
}

class _BuildTaskItemState extends State<BuildTaskItem> {
  bool isFavorite;
  bool isComplete;
  Map item;

  _BuildTaskItemState(
      {required this.isFavorite,
        required this.isComplete,
        required this.item});

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Transform.scale(
          scale: 1.2,
          child: Checkbox(
              side: BorderSide(
                  color: convertToColor(widget.item['color']).withOpacity(.8),
                  width: 2,
                style: BorderStyle.solid,
              ),
              activeColor: convertToColor(widget.item['color']).withOpacity(.8),
              value: isComplete,
              onChanged: (val) {
                setState((){
                isComplete=val!;
                  AppCubit.get(context).updateIsCompleteInDataBase(
                      isComplete: isComplete.toString(), id: widget.item['id']);
                });
              }),
        ),
        SizedBox(
          width: 3.w,
        ),
        Expanded(
          child: Text(
            '${widget.item['title']}',
            style: TextStyle(
              fontSize: 17.sp,
              color: AppCubit.get(context).isDark ? Colors.white : Colors.black.withOpacity(.6),
              //fontWeight: FontWeight.w400,
            ),
          ),
        ),
        PopupMenuButton(
          icon: Icon(Icons.menu,color: convertToColor(widget.item['color']).withOpacity(.8),),
            itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite;
                        AppCubit.get(context).updateIsFavoriteInDataBase(
                            isFavorite: isFavorite.toString(), id: widget.item['id']);
                      });
                    },
                    child: toBoolean(widget.item['isFavorite'])
                        ? Icon(Icons.favorite,color: convertToColor(widget.item['color']).withOpacity(.8),)
                        : Icon(Icons.favorite_border,color: convertToColor(widget.item['color']).withOpacity(.8),),
                  ),
                  PopupMenuItem(
                    value: 2,
                    onTap: () {
                      AppCubit.get(context).deleteItemFromDataBase(id:widget.item['id']);
                    },
                    child: Icon(Icons.delete_rounded,color: convertToColor(widget.item['color']).withOpacity(.8),),
                  ),
                ]),
      ],
    );
  }
}
