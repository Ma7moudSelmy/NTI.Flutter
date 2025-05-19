import 'dart:developer';

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

  void onLoginPressed() async {
    if (!formKey.currentState!.validate()) return;
    emit(LoginLoadingState());
    UserRepo userRepo = UserRepo();
    var result = await userRepo.login(
      username: usernameController.text,
      password: passwordController.text,
    );
    result.fold(
      (error) {
        emit(LoginErrorState(errorMessage: error));
        log('Login error: $error');
      },
      (userModel) {
        emit(LoginSuccessState(userModel: userModel));

        log('Login success: ${userModel.imagePath ?? ''}');
      },
    );
  }
}
