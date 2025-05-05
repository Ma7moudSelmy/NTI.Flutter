import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/task_model.dart';
import 'today_tasks_state.dart';

class TodayTasksCubit extends Cubit<TodayTasksState> {
  static TodayTasksCubit get(context) => BlocProvider.of(context);

  TodayTasksCubit() : super(TodayTasksInitial());

  DateTime selectedDate = DateTime.now();

  Map<TaskGroup, bool> groupFilters = {
    TaskGroup.all: false,
    TaskGroup.home: false,
    TaskGroup.work: false,
    TaskGroup.personal: true,
  };
  Map<TaskStatus, bool> statusFilters = {
    TaskStatus.all: false,
    TaskStatus.inProgress: true,
    TaskStatus.done: false,
    TaskStatus.missed: false,
  };

  void onGroupFilterChanged(TaskGroup group) {
    groupFilters[group] = !groupFilters[group]!;
    log('group selected');
    emit(GroupFilterChangedState());
  }

  void onStatusFilterChanged(TaskStatus status) {
    statusFilters[status] = !statusFilters[status]!;
    log('status selected');
    emit(StatusFilterChangedState());
  }

  void onDateSelected(DateTime date) {
    selectedDate = date;
    emit(DateSelectedState());
  }
}
