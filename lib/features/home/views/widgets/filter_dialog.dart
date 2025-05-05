import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/date_field.dart';
import '../../../../core/widgets/my_custom_button.dart';
import '../../data/models/task_model.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({
    super.key,
    required this.statusFilters,
    required this.groupFilters,
    this.onGroupSelected,
    this.onStatusSelected,
    this.onDateSelected,
    this.onFilterPressed,
  });
  final Map<TaskStatus, bool> statusFilters;
  final Map<TaskGroup, bool> groupFilters;
  final void Function(TaskGroup group)? onGroupSelected;
  final void Function(TaskStatus status)? onStatusSelected;
  final void Function(DateTime date)? onDateSelected;
  final void Function()? onFilterPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 330,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: AppColors.white,
        shadowColor: AppColors.black.withAlpha((.25 * 255).toInt()),
        elevation: 4,

        child: Padding(
          padding: const EdgeInsets.all(25),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 15,
                runSpacing: 10,
                children: [
                  ...groupFilters.entries.map(
                    (entry) => _groupContainer(entry.key),
                  ),
                ],
              ),
              const SizedBox(height: 37),
              Wrap(
                spacing: 15,
                runSpacing: 10,
                children: [
                  ...statusFilters.entries.map(
                    (entry) => _statusContainer(entry.key),
                  ),
                ],
              ),
              const SizedBox(height: 37),
              DateField(),
              const SizedBox(height: 22),
              MyCustomeButton(text: 'Filter', onPressed: onFilterPressed),
            ],
          ),
        ),
      ),
    );
  }

  Widget _groupContainer(TaskGroup group) {
    return _tagContainer(
      tag: _getGroupTag(group),
      selected: groupFilters[group]!,
      group: group,
    );
  }

  Widget _statusContainer(TaskStatus status) {
    return _tagContainer(
      tag: _getStatusTag(status),
      selected: statusFilters[status]!,
      status: status,
    );
  }

  Widget _tagContainer({
    required String tag,
    required bool selected,
    TaskGroup? group,
    TaskStatus? status,
  }) {
    return InkWell(
      onTap: () {
        group != null
            ? onGroupSelected?.call(group)
            : onStatusSelected?.call(status!);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 0.5,
            color: selected ? Colors.transparent : AppColors.black,
          ),
        ),
        child: Text(
          tag,
          style:
              selected
                  ? AppTextStyles.s12w600.copyWith(color: AppColors.white)
                  : AppTextStyles.s12w300.copyWith(color: AppColors.black),
        ),
      ),
    );
  }

  String _getGroupTag(TaskGroup group) {
    switch (group) {
      case TaskGroup.home:
        return 'Home';
      case TaskGroup.work:
        return 'Work';
      case TaskGroup.personal:
        return 'Personal';
      case TaskGroup.all:
        return 'All';
    }
  }

  String _getStatusTag(TaskStatus status) {
    switch (status) {
      case TaskStatus.done:
        return 'Done';
      case TaskStatus.missed:
        return 'Missed';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.all:
        return 'All';
    }
  }
}
