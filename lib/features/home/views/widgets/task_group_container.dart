import 'package:flutter/material.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/wrapper/svg_wrapper.dart';
import '../../data/models/task_model.dart';

class TaskGroupContainer extends StatelessWidget {
  const TaskGroupContainer({
    super.key,
    required this.tasks,
    required this.taskGroup,
    this.onTapped,
  });
  final double width = double.infinity;
  final double height = 63;
  final List<TaskModel> tasks;
  final TaskGroup taskGroup;
  final void Function()? onTapped;

  @override
  Widget build(BuildContext context) {
    switch (taskGroup) {
      case TaskGroup.personal:
        return _personalGroup();
      case TaskGroup.work:
        return _workGroup();
      case TaskGroup.home:
        return _homeGroup();
      default:
        return _buildTaskGroupContainer();
    }
  }

  Widget _personalGroup() {
    return _buildTaskGroupContainer(
      counter:
          tasks.where((task) => task.taskType == TaskGroup.personal).length,
      counterColor: AppColors.primaryColor,
      counterBackGroundColor: AppColors.lightGreen,
      taskGroup: 'personal',
      taskCount:
          tasks.where((task) => task.taskType == TaskGroup.personal).length,
      icon: AppAssets.personal,
    );
  }

  Widget _workGroup() {
    return _buildTaskGroupContainer(
      counter: tasks.where((task) => task.taskType == TaskGroup.work).length,
      counterColor: AppColors.white,
      counterBackGroundColor: AppColors.black,
      taskGroup: 'work',
      taskCount: tasks.where((task) => task.taskType == TaskGroup.work).length,
      icon: AppAssets.work,
    );
  }

  Widget _homeGroup() {
    return _buildTaskGroupContainer(
      counter: tasks.where((task) => task.taskType == TaskGroup.home).length,
      counterColor: AppColors.darkPink,
      counterBackGroundColor: AppColors.lightPink,
      taskGroup: 'home',
      taskCount: tasks.where((task) => task.taskType == TaskGroup.home).length,
      icon: AppAssets.home,
    );
  }

  Widget _buildTaskGroupContainer({
    int counter = 0,
    Color counterColor = AppColors.white,
    Color counterBackGroundColor = AppColors.white,
    String taskGroup = 'personal',
    int taskCount = 0,
    String icon = AppAssets.personal,
  }) {
    return InkWell(
      onTap: onTapped,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            SvgWrappe(assetName: icon),
            SizedBox(width: 10),
            Expanded(
              child: Text('$taskGroup Tasks', style: AppTextStyles.s14w300),
            ),
            Container(
              width: 22,
              height: 23,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: counterBackGroundColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  counter.toString(),
                  style: AppTextStyles.s14w400.copyWith(color: counterColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
