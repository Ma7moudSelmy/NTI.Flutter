import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/simple_appbar.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  bool isEnglish = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar.build(
        title: 'Settings',
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
              'Language',
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
              child: Row(
                children: [
                  Expanded(child: _myContainer('AR', !isEnglish)),
                  Expanded(child: _myContainer('EN', isEnglish)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _myContainer(String language, bool isEnglish) {
    return InkWell(
      onTap: () {
        setState(() {
          this.isEnglish = isEnglish;
        });
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
