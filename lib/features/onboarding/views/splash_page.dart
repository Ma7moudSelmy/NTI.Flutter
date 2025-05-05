import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/helper/get_helper.dart';
import '../../auth/views/login_page.dart';
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
    super.initState();
    Timer(const Duration(seconds: 3), () {
      CacheData.firstTime = CacheHelper.getData(key: CacheKeys.firstTime);
      if (CacheData.firstTime == null) {
        CacheHelper.saveData(key: CacheKeys.firstTime, value: true);
        GetHelper.pushReplace(() => const OnBoardingPage());
      } else {
        GetHelper.pushReplace(() => const LoginPage());
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
