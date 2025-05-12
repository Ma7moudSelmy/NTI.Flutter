import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../core/translation/translation_keys.dart';
import '../manager/language_cubit/language_cubit.dart';
import '../manager/language_cubit/language_state.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/simple_appbar.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit(),
      child: Builder(
        builder: (context) {
          var cubit = LanguageCubit.get(context);
          return Scaffold(
            appBar: SimpleAppBar.build(
              title: TranslationKeys.settings.tr,
              onBack: () {
                Navigator.pop(context);
              },
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    TranslationKeys.language.tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: AppColors.black,
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.scaffoldBackground,
                      border: Border.all(color: AppColors.lightGrey),
                    ),
                    child: BlocConsumer<LanguageCubit, LanguageState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        return Row(
                          children: [
                            Expanded(
                              child: _myContainer(
                                'AR',
                                !cubit.isEnglish,
                                cubit,
                              ),
                            ),
                            Expanded(
                              child: _myContainer('EN', cubit.isEnglish, cubit),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _myContainer(String language, bool isEnglish, LanguageCubit cubit) {
    return InkWell(
      onTap: () {
        cubit.changeLanguage();
      },
      child: Container(
        height: 36,
        padding: EdgeInsets.all(2),
        color: isEnglish ? AppColors.primaryColor : AppColors.lightGrey,
        child: Text(
          language,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300,
            color: isEnglish ? AppColors.white : AppColors.black,
          ),
        ),
      ),
    );
  }
}
