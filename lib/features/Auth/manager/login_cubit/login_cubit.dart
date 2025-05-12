import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/user_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool visibality = true;

  void onChangeVisibalityPresed() {
    visibality = !visibality;

    emit(LoginShowPassState());
  }

  void onLoginPressed() {
    emit(LoginLoadingState());
    Future.delayed(const Duration(seconds: 2), () {
      if (!formKey.currentState!.validate()) {
        emit(LoginErrorState(errorMessage: 'Please enter valid data'));
        return;
      }
      UserRepo userRepo = UserRepo();
      if (userRepo.userModel.name != usernameController.text ||
          userRepo.userModel.password != passwordController.text) {
        emit(LoginErrorState(errorMessage: 'Invalid username or password'));
        return;
      }
      emit(LoginSuccessState(userModel: userRepo.userModel));
    });
  }
}
