import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/manager/user_cubit/user_cubit.dart';
import '../../features/home/manager/user_cubit/user_state.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';

abstract class HomeAppBar {
  static AppBar build({void Function()? onProfilePressed, bool action = true}) {
    return AppBar(
      leading: null,
      automaticallyImplyLeading: false,
      toolbarHeight: 80,
      title: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          var cubit = UserCubit.get(context);
          return Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
            child: InkWell(
              onTap: onProfilePressed,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/logo.png"),
                    radius: 30,
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello!',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: AppColors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        UserCubit.get(context).userModel?.name ??
                            'MA7MOUDSELMY',

                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),

      backgroundColor: Colors.transparent,
    );
  }
}
