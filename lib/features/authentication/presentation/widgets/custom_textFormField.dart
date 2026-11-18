import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextformfield extends StatefulWidget {
  const CustomTextformfield({
    super.key,
    required this.controller,
    required this.bordercolor,
    this.isPassword = false,
    this.icon,
    required this.text,
    required this.fillcolor,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
  });

  // الـ fields:
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  final String? Function(String?)? validator;

  final TextEditingController controller;
  final Color bordercolor;
  final Color fillcolor;

  final IconData? icon;
  final String text;

  final bool isPassword;

  @override
  State<CustomTextformfield> createState() => _CustomTextformfieldState();
}

class _CustomTextformfieldState extends State<CustomTextformfield> {
  bool isObsecure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      obscureText: widget.isPassword && isObsecure,
      controller: widget.controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.fillcolor,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isObsecure = !isObsecure;
                  });
                },
                icon: Icon(
                  isObsecure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(width: 1.w, color: widget.bordercolor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(width: 1.w, color: widget.bordercolor),
        ),
        hintText: widget.text,
      ),
    );
  }
}

// validators
class Validators {
  Validators._();

  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9]+([._%+\-][a-zA-Z0-9]+)*@[a-zA-Z0-9]+([.\-][a-zA-Z0-9]+)*\.com$',
    caseSensitive: false,
  );

  // الاسم: من 3 لـ 30
  static String? name(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Name is required';
    if (v.length < 3) return 'Name must be at least 3 characters';
    if (v.length > 30) return 'Name must not exceed 30 characters';
    return null;
  }

  // الايميل
  static String? email(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Email is required';
    if (v.length > 254) return 'Email is too long';
    if (!_emailRegex.hasMatch(v))
      return 'Email must be valid and end with .com';
    return null;
  }

  // المدينة: من 3 لـ 15
  static String? city(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'City is required';
    if (v.length < 3) return 'City must be at least 3 characters';
    if (v.length > 15) return 'City must not exceed 15 characters';
    return null;
  }

  // المنطقة: من 3 لـ 15
  static String? area(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Area is required';
    if (v.length < 3) return 'Area must be at least 3 characters';
    if (v.length > 15) return 'Area must not exceed 15 characters';
    return null;
  }

  // الباسورد (للتسجيل وتغيير الباسورد)
  static String? password(String? value) {
    final v = value ?? '';
    if (v.isEmpty) return 'Password is required';
    if (v.contains(' ')) return 'Password must not contain spaces';
    if (v.length < 8) return 'Password must be at least 8 characters';
    if (v.length > 64) return 'Password must not exceed 64 characters';
    if (!RegExp(r'[a-zA-Z]').hasMatch(v)) {
      return 'Password must include at least one letter';
    }
    if (!RegExp(r'\d').hasMatch(v)) {
      return 'Password must include at least one number';
    }
    return null;
  }

  // الباسورد في اللوجين: بس مطلوب (متقيدوش بقواعد)
  static String? loginPassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    return null;
  }

  // OTP: 6 أرقام بالظبط
  static String? otp(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Enter the code';
    if (!RegExp(r'^\d{6}$').hasMatch(v)) return 'Enter exactly 6 digits';
    return null;
  }
}
