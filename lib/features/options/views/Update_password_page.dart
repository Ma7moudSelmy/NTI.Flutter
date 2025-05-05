// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/widgets/main_image.dart';
import '../../../core/widgets/my_custom_button.dart';
import '../../../core/widgets/my_text_form_field.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final TextEditingController oldPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  int? selectedGender = 0;
  bool rememberMe = false;
  bool showPass = true;
  final _formKey = GlobalKey<FormState>();

  bool visibality() {
    return showPass;
  }

  void onChangeVisibality() {
    setState(() {
      showPass = !showPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MainImage(image: Image.asset(AppAssets.logo)),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    MyTextFormField(
                      fieldType: TextFieldType.password,
                      controller: oldPassController,
                      onSuffixPressed: onChangeVisibality,
                      obsecureText: true,
                    ),
                    SizedBox(height: 30),
                    MyTextFormField(
                      fieldType: TextFieldType.password,
                      controller: newPassController,
                      onSuffixPressed: onChangeVisibality,
                      obsecureText: true,
                    ),
                    SizedBox(height: 30),
                    MyTextFormField(
                      fieldType: TextFieldType.confirmPasword,
                      controller: confirmPassController,
                      onSuffixPressed: onChangeVisibality,
                      obsecureText: true,
                      passController: newPassController,
                    ),
                    SizedBox(height: 30),
                    MyCustomeButton(
                      text: 'Update',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pop(context);
                        }
                      },
                    ),
                    SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
