import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nti/core/constants/app_assets.dart';
import 'package:nti/core/theme/app_colors.dart';

class DetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DetailAppBar({
    super.key,
    required this.title,
    this.trailing,
  });

  final String title;
  final Widget? trailing;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      centerTitle: true,

      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: SvgPicture.asset(
          AppSvgs.arrow2,
          width: 24,
          height: 24,
        ),
      ),

      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.black,
          fontSize: 19,
          fontWeight: FontWeight.w300,
        ),
      ),

      actions: trailing == null
          ? null
          : [trailing!, const SizedBox(width: 12)],
    );
  }
}