import 'package:flutter/material.dart';
import 'package:nti/core/constants/app_assets.dart';
import 'package:nti/core/theme/app_colors.dart';
import 'package:nti/core/widgets/menuTile.dart';
import 'package:nti/features/auth/view/login_screen.dart';
import 'package:nti/features/auth/view_model/auth_view_model.dart';
import 'package:nti/features/todo/view/change_password_screen.dart';
import 'package:nti/features/todo/view/settings_screen.dart';
import 'package:nti/features/todo/view/update_profile_screen.dart';

class ProfileMenuScreen extends StatelessWidget {
  const ProfileMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(
                      AppImages.flag,
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello!',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.black,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      Text(
                        'Ahmed Saber',
                        style: TextStyle(
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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 30),
              child: Column(
                children: [
                  MenuTile(
                    
                    prefixicon: AppSvgs.profile,
                    suffixicon: AppSvgs.arrowUp,
                    label: 'Profile',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const UpdateProfileScreen(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  MenuTile(
                    label: 'Change Password',
                    prefixicon: AppSvgs.password,
                    suffixicon: AppSvgs.arrowUp,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ChangePasswordScreen(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  MenuTile(
                    prefixicon: AppSvgs.settings,
                    suffixicon: AppSvgs.arrowUp,
                    label: 'Settings',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SettingsScreen(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  MenuTile(
                    prefixicon: AppSvgs.delete,
                    suffixicon: AppSvgs.arrowUp,
                    label: 'Logout',
                    onTap: () {
                      AuthViewModel().logout();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

