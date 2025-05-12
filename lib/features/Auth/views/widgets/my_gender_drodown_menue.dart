import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Add this import for `.tr`

import '../../../../core/translation/translation_keys.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../manager/signup_cubit/signup_cubit.dart';

class MyGenderDrodownMenue extends StatelessWidget {
  final SignupCubit cubit;
  const MyGenderDrodownMenue({super.key, required this.cubit});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: AppColors.lightGrey, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: AppColors.lightGrey, width: 2),
          ),
          fillColor: AppColors.white,
          filled: true,
        ),
        dropdownColor: AppColors.white,
        value: cubit.selectedGender,
        items: [
          DropdownMenuItem(
            value: 0,
            child: Text(TranslationKeys.male.tr), // Replaced string
          ),
          DropdownMenuItem(
            value: 1,
            child: Text(TranslationKeys.female.tr), // Replaced string
          ),
        ],
        style: AppTextStyles.s14w300,
        onChanged: (value) {},
      ),
    );
  }
}
