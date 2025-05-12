import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/helper/get_helper.dart';
import '../../../core/translation/translation_keys.dart';
import 'Update_password_page.dart';
import 'language_page.dart';
import 'update_username_page.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/widgets/home_appbar.dart';
import 'widgets/option_container.dart';

class OptionsPage extends StatefulWidget {
  const OptionsPage({super.key});

  @override
  State<OptionsPage> createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: HomeAppBar.build(
          action: false,
          onProfilePressed: () {
            GetHelper.pop();
          },
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              OptionContainer(
                title: TranslationKeys.updateProfile.tr,
                icon: AppAssets.profile,
                onTap: () {
                  GetHelper.push(() => const UpdateUsernamePage());
                },
              ),
              OptionContainer(
                title: TranslationKeys.changePassword.tr,
                icon: AppAssets.lock,
                onTap: () {
                  GetHelper.push(() => const UpdatePasswordPage());
                },
              ),
              OptionContainer(
                title: TranslationKeys.settings.tr,
                icon: AppAssets.settings,
                onTap: () {
                  GetHelper.push(() => const LanguagePage());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
