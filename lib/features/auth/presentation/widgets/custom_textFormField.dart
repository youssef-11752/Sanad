import 'package:flutter/material.dart';
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
  });

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
      obscureText: widget.isPassword && isObsecure,
      validator:
          widget.validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Field Is Required';
            } else if (value.length < 3) {
              return 'Must Be More Than 3';
            }
            return null;
          },
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
