import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      this.onPressed,
      this.bgColor,
      this.text,
      this.isLoading,
      this.icon,
      this.isIcon = false});
  const AppButton.icon(
      {super.key,
      this.onPressed,
      this.bgColor,
      this.text,
      this.isLoading,
      this.icon,
      this.isIcon = true});
  final Function()? onPressed;
  final Color? bgColor;
  final String? text;
  final IconData? icon;
  final bool? isLoading;
  final bool isIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46.h,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: bgColor ?? Colors.blueAccent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6))),
          onPressed: onPressed,
          child: isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
              : isIcon
                  ? Icon(icon)
                  : Text(text ?? 'Button')),
    );
  }
}
