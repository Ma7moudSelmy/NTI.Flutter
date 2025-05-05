import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'features/onboarding/views/splash_page.dart';

import 'core/cache/cache_helper.dart';

import 'core/utils/app_text_styles.dart';

import 'core/utils/app_colors.dart';
import 'features/home/manager/user_cubit/user_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
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
