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
    emit(LoginLoadingState());
    Future.delayed(const Duration(seconds: 2), () async {
      if (!formKey.currentState!.validate()) {
        emit(LoginErrorState(errorMessage: 'Please enter valid data'));
        return;
      }
      // ######## using repo only #########
      // UserRepo userRepo = UserRepo();
      // if (userRepo.userModel.name != usernameController.text ||
      //     userRepo.userModel.password != passwordController.text) {
      //   emit(LoginErrorState(errorMessage: 'Invalid username or password'));
      //   return;
      // }

      // ######## using API #########
      var userRepo = UserRepo();
      var result = await userRepo.login(
        usernameController.text,
        passwordController.text,
      );
      result.fold(
        (error) {
          emit(LoginErrorState(errorMessage: error));
        },
        (response) {
          UserRepo().userModel.name = usernameController.text;
          UserRepo().userModel.password = passwordController.text;
          UserRepo().userModel.aToken = response.data['access_token'];
          UserRepo().userModel.rToken = response.data['refresh_token'];
          emit(LoginSuccessState(userModel: userRepo.userModel));
        },
      );
    });
  }
}
