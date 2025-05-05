import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../home/data/models/task_model.dart';

class EditTaskHeader extends StatelessWidget {
  const EditTaskHeader({super.key, this.taskStatus = TaskStatus.inProgress});
  final TaskStatus taskStatus;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 100,
      width: double.infinity,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withAlpha((.25 * 255).toInt()),
                  blurRadius: 4,
                  spreadRadius: 0,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 40,

              child: ClipOval(child: Image.asset("assets/images/logo.png")),
            ),
          ),

          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _title,
                  style: AppTextStyles.s14w300.copyWith(color: AppColors.black),
                ),
                const SizedBox(height: 5),
                Text(
                  _subTitle,
                  //overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.s14w300.copyWith(color: AppColors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String get _title {
    switch (taskStatus) {
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.done:
        return 'Done';
      case TaskStatus.missed:
        return 'Missed Task';
      default:
        return 'In Progress';
    }
  }

  String get _subTitle {
    switch (taskStatus) {
      case TaskStatus.inProgress:
        return 'Believe you can, and you\'re halfway there.';
      case TaskStatus.done:
        return 'Congrats!';
      case TaskStatus.missed:
        return 'There is Always another chance.';
      default:
        return 'Believe you can, and you\'re halfway there.';
    }
  }
}
