import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  void onSignupPressed() {
    emit(SignupLoading());
    Future.delayed(const Duration(seconds: 2), () {
      if (!formKey.currentState!.validate()) {
        emit(SignupError());
        return;
      }
      emit(SignupSuccess());
    });
  }
}
