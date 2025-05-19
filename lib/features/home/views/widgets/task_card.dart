import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/translation/translation_keys.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/wrapper/svg_wrapper.dart';
import '../../data/models/task_model.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task, this.onTapped});
  final TaskModel task;
  final void Function()? onTapped;
  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTapped, child: _generalTaskCard());
  }

  Widget _generalTaskCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      //height: 90,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              // color: Colors.yellow,
              borderRadius: BorderRadius.circular(7),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withAlpha((.25 * 255).toInt()),

                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child:
                  task.imagePath != null
                      ? Image.network(task.imagePath!)
                      : Image.asset(AppAssets.profileImage, fit: BoxFit.fill),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  task.description,
                  style: AppTextStyles.s14w300.copyWith(color: AppColors.black),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Spacer(),
                    Container(
                      height: 17,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: _backgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _taskState,
                        style: _stateTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SvgWrappe(assetName: _icon, width: 22, height: 22),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color get _backgroundColor {
    switch (task.taskState) {
      case TaskStatus.inProgress:
        return AppColors.lightGreen;
      case TaskStatus.done:
        return AppColors.primaryColor;
      case TaskStatus.missed:
        return AppColors.darkRed;
      default:
        return AppColors.lightGreen;
    }
  }

  TextStyle get _stateTextStyle {
    switch (task.taskState) {
      case TaskStatus.inProgress:
        return AppTextStyles.s10w600.copyWith(color: AppColors.black);
      case TaskStatus.done:
        return AppTextStyles.s10w600.copyWith(color: AppColors.white);
      case TaskStatus.missed:
        return AppTextStyles.s10w600.copyWith(color: AppColors.white);
      default:
        return AppTextStyles.s10w600.copyWith(color: AppColors.black);
    }
  }

  String get _taskState {
    switch (task.taskState) {
      case TaskStatus.inProgress:
        return TranslationKeys.InProgress.tr;
      case TaskStatus.done:
        return TranslationKeys.Done.tr;
      case TaskStatus.missed:
        return TranslationKeys.missed.tr;
      default:
        return TranslationKeys.InProgress.tr;
    }
  }

  String get _icon {
    switch (task.taskType) {
      case TaskGroup.personal:
        return AppAssets.personal;
      case TaskGroup.home:
        return AppAssets.home;
      case TaskGroup.work:
        return AppAssets.work;
      default:
        return AppAssets.personal;
    }
  }
}
