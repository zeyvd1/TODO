import 'package:flutter/material.dart';
import 'package:nti/core/theme/app_colors.dart';
import 'package:nti/core/widgets/detail_app_bar.dart';
import 'package:nti/core/widgets/language.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _language = 'EN'; // 'AR' | 'EN'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const DetailAppBar(title: 'Settings'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              const Text(
                'Language',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: AppColors.black,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: AppColors.pillGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LangOption(
                      label: 'AR',
                      selected: _language == 'AR',
                      onTap: () => setState(() => _language = 'AR'),
                    ),
                    LangOption(
                      label: 'EN',
                      selected: _language == 'EN',
                      onTap: () => setState(() => _language = 'EN'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

