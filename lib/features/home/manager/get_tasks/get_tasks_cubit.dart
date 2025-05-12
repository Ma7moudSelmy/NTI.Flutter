import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/tasks_repo.dart';
import 'get_tasks_state.dart';

class GetTasksCubit extends Cubit<GetTasksState> {
  GetTasksCubit() : super(GetTasksInitialState());

  static GetTasksCubit get(context) => BlocProvider.of(context);

  void getTasks() {
    TasksRepo tasksRepo = TasksRepo();

    emit(GetTasksSuccess(tasks: tasksRepo.tasks));
  }
}
