import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'core/cache/cache_data.dart';
import 'core/cache/cache_keys.dart';
import 'core/translation/translation_helper.dart';
import 'features/onboarding/views/splash_page.dart';

import 'core/cache/cache_helper.dart';

import 'core/utils/app_text_styles.dart';

import 'core/utils/app_colors.dart';
import 'features/home/manager/user_cubit/user_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await TranslationHelper.setLanguage();
  // CacheHelper.removeData(key: CacheKeys.firstTime);
  // CacheHelper.removeData(key: CacheKeys.loggedIn);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(),
      child: Builder(
        builder: (context) {
          return GetMaterialApp(
            locale: Locale(CacheData.lang!),
            translations: TranslationHelper(),
            title: 'To-Do',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: AppTextStyles.fontFamily,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              scaffoldBackgroundColor: AppColors.scaffoldBackground,
            ),
            home: SplashPage(),
          );
        },
      ),
    );
  }
}
