import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/helper/get_helper.dart';
import '../../../core/utils/app_assets.dart';
import '../../home/manager/user_cubit/user_cubit.dart';
import '../manager/login_cubit/login_cubit.dart';
import '../manager/login_cubit/login_state.dart';
import '../../home/views/home_page.dart';

import '../../../core/widgets/my_custom_button.dart';
import '../../../core/widgets/my_text_form_field.dart';
import 'signup_page.dart';
import '../../../core/widgets/main_image.dart';
import 'widgets/my_footer.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: Scaffold(
        body: Builder(
          builder: (context) {
            var cubit = LoginCubit.get(context);
            return SingleChildScrollView(
              child: Column(
                children: [
                  MainImage(image: Image.asset(AppAssets.logo)),
                  Form(
                    key: cubit.formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          MyTextFormField(
                            fieldType: TextFieldType.username,
                            controller: cubit.usernameController,
                          ),
                          SizedBox(height: 15),
                          BlocBuilder<LoginCubit, LoginState>(
                            builder: (context, state) {
                              return MyTextFormField(
                                onSuffixPressed:
                                    () => cubit.onChangeVisibalityPresed(),
                                controller: cubit.passwordController,
                                fieldType: TextFieldType.password,
                                obsecureText: cubit.visibality,
                              );
                            },
                          ),

                          SizedBox(height: 15),
                          BlocConsumer<LoginCubit, LoginState>(
                            listener: (context, state) {
                              if (state is LoginErrorState) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Login failed!')),
                                );
                              } else if (state is LoginSuccessState) {
                                UserCubit.get(context).getUser(state.userModel);
                                GetHelper.pushReplaceAll(() => HomePage());
                              }
                            },
                            builder: (context, state) {
                              return MyCustomeButton(
                                isLoading: state is LoginLoadingState,
                                text: 'Login',
                                onPressed: () {
                                  cubit.onLoginPressed();
                                },
                              );
                            },
                          ),
                          SizedBox(height: 25),
                          MyFooter(
                            title: 'Don\'t Have An Account?',
                            action: 'Register',
                            onPressed: () {
                              GetHelper.pushReplace(() => SignupPage());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
