import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nti_15_task/core/helper/my_logger.dart';
import 'package:nti_15_task/features/auth/views/login_page.dart';
import '../../home/manager/user_cubit/user_cubit.dart';
import '../../home/views/home_page.dart';
import '../../../core/helper/get_helper.dart';
// import '../../auth/views/login_page.dart';
import '../../../core/cache/cache_data.dart';
import '../../../core/cache/cache_helper.dart';
import '../../../core/cache/cache_keys.dart';
import 'on_boarding_page.dart';
import 'dart:async';
import '../../../core/utils/app_assets.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    navigate(context);
    super.initState();
  }

  void navigate(context) async {
    Future.delayed((Duration(milliseconds: 500)), () {
      CacheData.firstTime = CacheHelper.getData(key: CacheKeys.firstTime);
      // check if first time
      if (CacheData.firstTime != null) {
        CacheData.accessToken = CacheHelper.getData(key: CacheKeys.accessToken);
        // check if the user is logged in using access token
        if (CacheData.accessToken != null) {
          // call the api to get user data
          UserCubit.get(context).getUserFromApi().then((bool result) {
            if (result) {
              // if succeeded to fetch user data then go home
              GetHelper.pushReplace(() => HomePage());
            } else {
              // if failed for any reason the login
              GetHelper.pushReplace(() => LoginPage());
            }
          });
        } else {
          // goto login
          GetHelper.pushReplace(() => LoginPage());
        }
      } else // first time
      {
        GetHelper.pushReplace(() => OnBoardingPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SvgPicture.asset(AppAssets.splash, fit: BoxFit.fill)),
    );
  }
}
