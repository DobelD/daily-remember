import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

class AppForm extends StatefulWidget {
  const AppForm(
      {super.key,
      this.controller,
      this.hintText,
      this.onChanged,
      this.keyboardType,
      this.isPassword = false,
      this.isSearch = false,
      this.focusNode,
      this.onEditingComplete});
  const AppForm.search(
      {super.key,
      this.controller,
      this.hintText,
      this.onChanged,
      this.keyboardType,
      this.isPassword = false,
      this.isSearch = true,
      this.focusNode,
      this.onEditingComplete});
  const AppForm.password(
      {super.key,
      this.controller,
      this.hintText,
      this.onChanged,
      this.keyboardType,
      this.isPassword = true,
      this.isSearch = false,
      this.focusNode,
      this.onEditingComplete});

  final TextEditingController? controller;
  final String? hintText;
  final bool isSearch;
  final bool isPassword;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;

  @override
  State<AppForm> createState() => _AppFormState();
}

class _AppFormState extends State<AppForm> {
  bool isObsecure = false;
  void showPassword() {
    setState(() {
      isObsecure = !isObsecure;
    });
  }

  @override
  void initState() {
    isObsecure = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46.h,
      child: TextFormField(
        focusNode: widget.focusNode,
        controller: widget.controller,
        style: titleNormal,
        cursorColor: Colors.blueAccent,
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        obscureText: isObsecure,
        autocorrect: false,
        enableSuggestions: false,
        onEditingComplete: widget.onEditingComplete,
        decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: hintTitleNormal,
            border: _border,
            enabledBorder: _border,
            focusedBorder: _borderActive,
            prefixIcon: widget.isSearch
                ? Icon(
                    IconlyLight.search,
                    color: Colors.grey.shade400,
                    size: 22,
                  )
                : null,
            prefixIconConstraints:
                const BoxConstraints(maxWidth: 50, minWidth: 40),
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: showPassword,
                    icon: Icon(
                      isObsecure ? Icons.visibility_off : Icons.visibility,
                      size: 20.w,
                    ))
                : null,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 4)),
      ),
    );
  }

  OutlineInputBorder get _border {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300));
  }

  OutlineInputBorder get _borderActive {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.blueAccent, width: 1.2));
  }
}
