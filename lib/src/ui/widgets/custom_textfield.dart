import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/src/core/styles/color.dart';

class CustomTextField extends StatelessWidget {
  final String? lableText;
  final String? hintText;
  final TextInputType? textInputType;
  final bool obscure;
  final bool? isPasswordTextField;
  final TextEditingController textEditingController;
  final int? inputLimit;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final int maxLines;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? suffixText;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final Function()? onTap;
  final AutovalidateMode? autovalidateMode;
  final String? errorText;
  final bool? filled;
  final Color? fillColor;
  final bool isMultipleLine;

  const CustomTextField({
    Key? key,
    this.lableText,
    this.hintText,
    this.textInputType,
    this.obscure = false,
    this.isPasswordTextField,
    required this.textEditingController,
    this.inputLimit,
    this.inputFormatters,
    this.readOnly = false,
    this.maxLines = 1,
    this.prefix,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixText,
    this.validator,
    this.onChanged,
    this.textInputAction = TextInputAction.next,
    this.onTap,
    this.autovalidateMode,
    this.errorText,
    this.filled = true,
    this.fillColor,
    this.isMultipleLine = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleSmall;

    return TextFormField(
      //autofocus: true,
      style: textStyle!.copyWith(
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
      keyboardType: textInputType,
      obscureText: obscure,
      maxLength: inputLimit,
      textInputAction: textInputAction,
      onTap: onTap,
      maxLines: (obscure == true) ? 1 : maxLines,
      controller: textEditingController,
      validator: validator,
      onChanged: onChanged,
      readOnly: readOnly,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        isDense: true,
        counterText: "",
        filled: filled,
        fillColor: fillColor ?? const Color(0xffF7F7F7),
        errorText: errorText,
        errorStyle: textStyle.copyWith(
          fontSize: 9.sp,
          fontWeight: FontWeight.w400,
          color: Colors.red,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.darkGrey, width: 1.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.darkGrey, width: 1.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 22.w),
        labelText: lableText,
        hintText: hintText,
        prefix: prefix,
        prefixIcon: prefixIcon,
        prefixIconConstraints: const BoxConstraints(
          minWidth: 20,
          minHeight: 20,
        ),
        suffixText: suffixText,
        suffixIcon: suffixIcon,
        suffixIconConstraints: const BoxConstraints(
          minWidth: 25,
          minHeight: 25,
        ),
        //suffixStyle: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 1.9.h),
        hintStyle: textStyle.copyWith(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xffB0B0C3),
        ),
        labelStyle: textStyle.copyWith(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xffB0B0C3),
        ),
      ),
    );
  }
}

class PasswordIcon extends StatelessWidget {
  const PasswordIcon(
    this.showPassword, {
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final bool showPassword;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        showPassword ? Icons.visibility_off : Icons.remove_red_eye,
        size: 15.sp,
        color: const Color(0xffB0B0C3),
      ),
    );
  }
}
