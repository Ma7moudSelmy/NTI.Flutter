import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart'; // Add this import for `.tr`
import 'package:image_picker/image_picker.dart';

import '../../../core/helper/get_helper.dart';
import '../../../core/widgets/image_manager/image_manager_view.dart';
import '../../../core/translation/translation_keys.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/main_image.dart';
import '../../../core/widgets/my_custom_button.dart';
import '../../../core/widgets/my_text_form_field.dart';
import '../manager/signup_cubit/signup_cubit.dart';
import '../manager/signup_cubit/signup_state.dart';
import 'login_page.dart';
import 'widgets/my_footer.dart';
import 'widgets/my_gender_drodown_menue.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: Scaffold(
        body: Builder(
          builder: (context) {
            var cubit = SignupCubit.get(context);
            return SingleChildScrollView(
              child: Column(
                children: [
                  BlocBuilder<SignupCubit, SignupState>(
                    builder: (context, state) {
                      // return MainImage(
                      //   onTap: () {
                      //     cubit.onChangeImage();
                      //   },
                      //   image:
                      //       cubit.imageFile != null
                      //           ? Image.file(
                      //             File(cubit.imageFile!.path),
                      //             fit: BoxFit.cover,
                      //           )
                      //           : Image.asset(AppAssets.logo),
                      // );
                      return ImageManagerView(
                        onPicked: (XFile image) {
                          cubit.imageFile = image;
                        },
                        pickedBody: (XFile image) {
                          return Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.36,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              image: DecorationImage(
                                image: FileImage(File(image.path)),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                        unPickedBody: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          child: Image.asset(
                            AppAssets.logo,
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.36,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
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
                          BlocBuilder<SignupCubit, SignupState>(
                            buildWhen: (previous, current) {
                              return current is SignupShowPassState;
                            },
                            builder: (context, state) {
                              return MyTextFormField(
                                fieldType: TextFieldType.password,
                                onSuffixPressed: cubit.onChangeVisibalityPresed,
                                controller: cubit.passwordController,
                                obsecureText: cubit.visibality,
                              );
                            },
                          ),
                          SizedBox(height: 15),
                          BlocBuilder<SignupCubit, SignupState>(
                            buildWhen: (previous, current) {
                              return current is SignupShowPassState;
                            },
                            builder: (context, state) {
                              return MyTextFormField(
                                fieldType: TextFieldType.confirmPasword,
                                obsecureText: cubit.visibality,
                                passController: cubit.passwordController,
                                onSuffixPressed: cubit.onChangeVisibalityPresed,
                                controller: cubit.confirmPassController,
                              );
                            },
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              MyGenderDrodownMenue(cubit: cubit),
                              Spacer(),
                              Text(
                                TranslationKeys
                                    .rememberMe
                                    .tr, // Replaced string
                                style: const TextStyle(
                                  color: AppColors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              BlocBuilder<SignupCubit, SignupState>(
                                buildWhen: (previous, current) {
                                  return current is SignupRememberMeState;
                                },
                                builder: (context, state) {
                                  return Checkbox(
                                    value: cubit.rememberMe,
                                    onChanged: (value) {
                                      cubit.onChangeRememberMe();
                                    },
                                    fillColor:
                                        WidgetStateProperty.resolveWith<Color>((
                                          states,
                                        ) {
                                          if (states.contains(
                                            WidgetState.selected,
                                          )) {
                                            return AppColors.primaryColor;
                                          }
                                          return Colors.transparent;
                                        }),
                                    checkColor: Colors.white,
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          BlocConsumer<SignupCubit, SignupState>(
                            listener: (context, state) {
                              if (state is SignupSuccess) {
                                GetHelper.pushReplaceAll(() => LoginPage());
                              } else if (state is SignupError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      TranslationKeys
                                          .signupFailed
                                          .tr, // Replaced string
                                    ),
                                  ),
                                );
                              }
                            },
                            builder: (context, state) {
                              return MyCustomeButton(
                                isLoading: state is SignupLoading,
                                text:
                                    TranslationKeys
                                        .register
                                        .tr, // Replaced string
                                onPressed: () {
                                  cubit.onSignupPressed();
                                },
                              );
                            },
                          ),
                          SizedBox(height: 25),
                          MyFooter(
                            title:
                                TranslationKeys
                                    .alreadyHaveAnAccount
                                    .tr, // Replaced string
                            action: TranslationKeys.login.tr, // Replaced string
                            onPressed: () {
                              GetHelper.pushReplace(() => LoginPage());
                            },
                          ),
                          SizedBox(height: 30),
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
