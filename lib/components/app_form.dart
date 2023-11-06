import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class AppForm extends StatefulWidget {
  const AppForm(
      {super.key,
      this.controller,
      this.hintText,
      this.onChanged,
      this.keyboardType,
      this.isSearch = false});
  const AppForm.search(
      {super.key,
      this.controller,
      this.hintText,
      this.onChanged,
      this.keyboardType,
      this.isSearch = true});

  final TextEditingController? controller;
  final String? hintText;
  final bool isSearch;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;

  @override
  State<AppForm> createState() => _AppFormState();
}

class _AppFormState extends State<AppForm> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: TextFormField(
        controller: widget.controller,
        style: titleNormal,
        cursorColor: Colors.blueAccent,
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
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
