import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/themes/app_colors.dart';

class SearchBox extends StatelessWidget {
  final TextEditingController searchController;
  final String hintText;
  final Function(String) onChanged;
  const SearchBox({
    Key? key,
    required this.searchController,
    required this.hintText,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.15),
          borderRadius: BorderRadius.circular(1.5.w)),
      child: TextField(
        controller: searchController,
        keyboardType: TextInputType.streetAddress,
        onChanged: (text) => onChanged(text),
        style: TextStyle(
          fontSize: 14.sp,
          color: AppColors.darkElv0,
        ),
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: AppColors.darkElv0.withOpacity(0.5),
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
            border: InputBorder.none,
            isDense: true),
      ),
    );
  }
}
