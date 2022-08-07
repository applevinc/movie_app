import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/src/core/styles/color.dart';
import 'package:movie_app/src/core/styles/text.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    Key? key,
    required this.onChanged,
    required this.onClose,
  }) : super(key: key);

  final Function(String) onChanged;
  final Function() onClose;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: Theme.of(context).textTheme.bodyText1,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.darkGrey,
        hintText: 'Search using email or phone number',
        hintStyle: AppText.bold400(context).copyWith(
          color: AppColors.darkText,
          fontSize: 14.sp,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 11.h,
          horizontal: 11.5.w,
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: Color(0xff231F20),
        ),
        suffixIcon: controller.text.isNotEmpty
            ? GestureDetector(
                child: const Icon(Icons.close),
                onTap: () {
                  controller.clear();
                  widget.onClose();
                  setState(() {});
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
      ),
    );
  }
}
