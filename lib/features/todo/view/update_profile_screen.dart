import 'package:flutter/material.dart';
import 'package:nti/core/constants/app_assets.dart';
import 'package:nti/core/theme/app_colors.dart';
import 'package:nti/core/widgets/custom_button.dart';
import 'package:nti/core/widgets/custom_text_field.dart';
import 'package:nti/features/auth/view_model/auth_view_model.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _usernameController = TextEditingController();
  final _authViewModel = AuthViewModel();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final user = await _authViewModel.getUserData();
      if (!mounted) return;
      _usernameController.text = user.username;
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  Future<void> _save() async {
    setState(() => _isLoading = true);
    try {
      await _authViewModel.updateProfile(
        username: _usernameController.text.trim(),
      );
      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                AppImages.flag,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CustomTextField(
                    hintText: 'Username',
                    controller: _usernameController,
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: _isLoading ? '...' : 'Save',
                    onPressed: _isLoading ? null : _save,
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
