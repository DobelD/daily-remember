import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, this.onPressed, this.text, this.isLoading});
  final Function()? onPressed;
  final String? text;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42.h,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
          onPressed: onPressed,
          child: isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
              : Text(text ?? 'Button')),
    );
  }
}
