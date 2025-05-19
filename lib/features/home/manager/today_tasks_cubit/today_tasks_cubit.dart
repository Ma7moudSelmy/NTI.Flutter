import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/tasks_repo.dart';
import '../../data/models/task_model.dart';
import 'today_tasks_state.dart';

class TodayTasksCubit extends Cubit<TodayTasksState> {
  static TodayTasksCubit get(context) => BlocProvider.of(context);

  TodayTasksCubit() : super(TodayTasksInitial());

  DateTime selectedDate = DateTime.now();
  List<TaskModel> allTasks = [];
  List<TaskModel> filteredTasks = [];

  Map<TaskGroup, bool> groupFilters = {
    TaskGroup.all: true,
    TaskGroup.home: false,
    TaskGroup.work: false,
    TaskGroup.personal: false,
  };
  Map<TaskStatus, bool> statusFilters = {
    TaskStatus.all: true,
    TaskStatus.inProgress: false,
    TaskStatus.done: false,
    TaskStatus.missed: false,
  };

  void onGroupFilterChanged(TaskGroup group) {
    groupFilters.updateAll((_, __) => false);
    groupFilters[group] = true;
    emit(GroupFilterChangedState());
  }

  void onStatusFilterChanged(TaskStatus status) {
    statusFilters.updateAll((_, __) => false);

    statusFilters[status] = true;

    emit(StatusFilterChangedState());
  }

  void onDateSelected(DateTime date) {
    selectedDate = date;
    emit(DateSelectedState());
  }

  void getTasks() {
    emit(GetTasksLoading());
    try {
      final TasksRepo tasksRepo = TasksRepo();
      allTasks = tasksRepo.tasks;
      _applyFilters();
    } catch (e) {
      emit(GetTasksError(e.toString()));
    }
  }

  void _applyFilters() {
    filteredTasks =
        allTasks.where((task) {
          final selectedGroup =
              groupFilters.entries.firstWhere((e) => e.value).key;
          final groupMatch =
              selectedGroup == TaskGroup.all || task.taskType == selectedGroup;

          final selectedStatus =
              statusFilters.entries.firstWhere((e) => e.value).key;
          final statusMatch =
              selectedStatus == TaskStatus.all ||
              task.taskState == selectedStatus;

          // Date filter (example - adjust as needed)
          // final dateMatch =
          //     task.dueDate?.year == selectedDate.year &&
          //     task.dueDate?.month == selectedDate.month &&
          //     task.dueDate?.day == selectedDate.day;

          return groupMatch && statusMatch;
        }).toList();

    emit(GetTasksSuccess(tasks: filteredTasks));
  }
}
