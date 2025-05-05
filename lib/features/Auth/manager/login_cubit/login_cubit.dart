import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/data/models/user_model.dart';
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
        emit(LoginErrorState());
        return;
      }
      emit(
        LoginSuccessState(
          userModel: UserModel(
            name: usernameController.text,
            password: passwordController.text,
          ),
        ),
      );
    });
  }
}
