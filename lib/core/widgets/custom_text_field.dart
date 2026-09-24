import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nti/core/theme/app_colors.dart';

/// Simple rounded text field used across the app's forms.
class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.prefixIconSvg,
    this.suffixIconSvg,
  });

  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;

  final String? prefixIconSvg;
  final String? suffixIconSvg;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final bool _obscure = widget.obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      controller: widget.controller,
      obscureText: _obscure,
      style: const TextStyle(
        fontSize: 15,
        color: AppColors.black,
        fontWeight: FontWeight.w200,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: AppColors.grey,
          fontSize: 15,
          fontWeight: FontWeight.w200,
        ),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),

        prefixIcon: widget.prefixIconSvg == null
            ? null
            : Padding(
                padding: const EdgeInsets.all(14),
                child: SvgPicture.asset(
                  widget.prefixIconSvg!,
                  width: 20,
                  height: 20,
                ),
              ),

        suffixIcon: widget.suffixIconSvg == null
                ? null
                : Padding(
                    padding: const EdgeInsets.all(14),
                    child: SvgPicture.asset(
                      widget.suffixIconSvg!,
                      width: 20,
                      height: 20,
                    ),
                  ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.border,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.border,
          ),
        ),

        
      ),
    );
  }
}