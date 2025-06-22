import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_guard/core/data/models/user_model.dart';
import 'package:work_guard/features/auth/presentation/view_model/cubit/auth_sign_in_cubit.dart';
import 'package:work_guard/features/profile/presentation/view/widgets/menu_list_widget.dart';
import 'package:work_guard/features/profile/presentation/view/widgets/profile_avatar.dart';
import 'package:work_guard/features/profile/presentation/view/widgets/profile_image_upload_button.dart';
import 'package:work_guard/features/profile/presentation/view/widgets/user_info_widget.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                ProfileAvatar(),
                const SizedBox(height: 4),
                UserInfoWidget(),
                const SizedBox(height: 16),
                ProfileImageUploadButton(),

                Spacer(),
                MenuListWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
