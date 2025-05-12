import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/repo/user_repo.dart';
import '../../../home/data/repo/tasks_repo.dart';
import 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  int? selectedGender = 0;
  bool rememberMe = false;
  bool visibality = true;
  final formKey = GlobalKey<FormState>();

  static SignupCubit get(context) => BlocProvider.of(context);

  void onGenderSelected(int? value) {
    selectedGender = value;
  }

  void onChangeRememberMe() {
    rememberMe = !rememberMe;
    emit(SignupRememberMeState());
  }

  void onChangeVisibalityPresed() {
    visibality = !visibality;

    emit(SignupShowPassState());
  }

  XFile? imageFile;
  void onChangeImage() async {
    final ImagePicker imagePicker = ImagePicker();
    imageFile = await imagePicker.pickImage(source: ImageSource.gallery);
    emit(SignupChangeImageState());
  }

  void onSignupPressed() async {
    emit(SignupLoading());
    Future.delayed(const Duration(seconds: 2), () async {
      if (!formKey.currentState!.validate()) {
        emit(SignupError());
        return;
      }
      // ######## using repo only #########
      // UserRepo userRepo = UserRepo();
      // TasksRepo tasksRepo = TasksRepo();
      // userRepo.userModel.name = usernameController.text;
      // userRepo.userModel.password = passwordController.text;
      // userRepo.userModel.image = imageFile;
      // // Tie the tasks in the userModel with the tasksRepo
      // userRepo.userModel.tasks = tasksRepo.tasks;

      // ######## using API #########
      var result = await UserRepo().register(
        usernameController.text,
        passwordController.text,
      );
      result.fold(
        (error) {
          // left
          emit(SignupError(errorMessage: error));
        },
        (r) {
          // right
          emit(SignupSuccess());
        },
      );
      emit(SignupSuccess());
    });
  }
}
