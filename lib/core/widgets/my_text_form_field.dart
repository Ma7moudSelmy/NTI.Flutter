import 'package:flutter/material.dart';
import '../../features/add_task/data/models/group_model.dart';
import '../utils/app_text_styles.dart';

import '../wrapper/svg_wrapper.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    required this.fieldType,
    required this.controller,
    this.passController,
    this.obsecureText = true,
    this.onSuffixPressed,
    this.items,
    this.onDropDownChanged,
    this.selectedDropDownValue,
  });
  final TextEditingController controller;
  final TextEditingController? passController;
  final bool obsecureText;
  final void Function()? onSuffixPressed;
  final TextFieldType fieldType;
  final List<GroupModel>? items;
  final void Function(dynamic value)? onDropDownChanged;
  final GroupModel? selectedDropDownValue;

  @override
  Widget build(BuildContext context) {
    switch (fieldType) {
      case TextFieldType.username:
        return _usernameTextField();
      case TextFieldType.password:
        return _passwordTextField();
      case TextFieldType.confirmPasword:
        return _passwordTextField(isConfirmPass: true);
      case TextFieldType.taskTitle:
        return _titleTextField();
      case TextFieldType.taskDescribtion:
        return _descriptionTextField();
      case TextFieldType.group:
        return _groupTextField();
    }
  }

  Widget _usernameTextField() {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.name,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: AppTextStyles.s14w300,
      validator: _validateUsername,
      decoration: _myInputDecoration(
        prefixIconPath: AppAssets.profile,
        hint: 'Username',
      ),
    );
  }

  Widget _passwordTextField({bool isConfirmPass = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.visiblePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: AppTextStyles.s14w300,
      validator: isConfirmPass ? _validateConfirmPass : _validatePassword,
      decoration: _myInputDecoration(
        prefixIconPath: AppAssets.password,
        suffixIconPath: obsecureText ? AppAssets.lock : AppAssets.unlock,
        onSuffixIconPressed: onSuffixPressed,
        hint: isConfirmPass ? 'Confirm Password' : 'Password',
      ),
      obscureText: obsecureText,
    );
  }

  Widget _titleTextField() {
    return TextFormField(
      maxLines: null,
      controller: controller,
      keyboardType: TextInputType.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: AppTextStyles.s14w300,
      validator: _noValidation,
      decoration: _myInputDecoration(hint: 'Title'),
    );
  }

  Widget _descriptionTextField() {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: AppTextStyles.s14w300,
      validator: _noValidation,
      maxLines: null,
      minLines: 1,
      decoration: _myInputDecoration(hint: 'Description'),
    );
  }

  Widget _groupTextField() {
    return DropdownButtonFormField<GroupModel>(
      items:
          items?.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Row(
                children: [
                  SvgWrappe(assetName: item.iconPath, fit: BoxFit.scaleDown),
                  const SizedBox(width: 10),
                  Text(item.name, style: AppTextStyles.s14w300),
                ],
              ),
            );
          }).toList() ??
          [],
      onChanged: onDropDownChanged,
      validator: (value) {
        if (value == null) {
          return 'Please select an option';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: AppTextStyles.s14w200.copyWith(color: AppColors.grey),
      decoration: _myInputDecoration(hint: 'Group'),
    );
  }

  InputBorder _myInputBorder(Color borderColor) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: borderColor, width: 1),
    );
  }

  InputDecoration _myInputDecoration({
    String? prefixIconPath,
    String? suffixIconPath,
    void Function()? onSuffixIconPressed,
    String? hint,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: AppColors.grey,
        fontWeight: FontWeight.w200,
        fontSize: 14,
      ),
      prefixIcon:
          prefixIconPath != null
              ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: SvgWrappe(assetName: prefixIconPath),
                ),
              )
              : null,
      suffixIcon:
          suffixIconPath != null
              ? IconButton(
                onPressed: onSuffixIconPressed,
                icon: SvgWrappe(assetName: suffixIconPath),
              )
              : null,
      enabledBorder: _myInputBorder(AppColors.lightGrey),
      errorBorder: _myInputBorder(Colors.red),
      focusedErrorBorder: _myInputBorder(Colors.red),
      focusedBorder: _myInputBorder(AppColors.primaryColor),
      disabledBorder: _myInputBorder(AppColors.lightGrey),
      fillColor: Colors.white,
      filled: true,
    );
  }

  String? _validatePassword(String? value) {
    final passwordRegEx = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (!passwordRegEx.hasMatch(value)) {
      return 'Password must be at least 8 characters, include letters and numbers';
    }
    return null;
  }

  String? _validateConfirmPass(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (passController == null || passController!.text != value) {
      return 'Password not matched';
    }
    return null;
  }

  String? _validateUsername(String? value) {
    final usernameRegEx = RegExp(r'^[a-zA-Z0-9_]{3,16}$');
    if (value == null || value.isEmpty) {
      return 'Username is required';
    } else if (!usernameRegEx.hasMatch(value)) {
      return 'Username must be 3-16';
    }
    return null;
  }

  String? _noValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is required';
    }
    return null;
  }
}

enum TextFieldType {
  username,
  password,
  confirmPasword,
  taskTitle,
  taskDescribtion,
  group,
}
