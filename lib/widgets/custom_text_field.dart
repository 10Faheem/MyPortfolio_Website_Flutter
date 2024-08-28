import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  OutlineInputBorder get getInputBorder {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    );
  }

  final TextEditingController? controller;
  final int maxLines;
  final String? hintText;

  const CustomTextField({
    super.key,
    this.controller,
    this.maxLines = 1,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 27, 28, 37),
        enabledBorder: getInputBorder,
        focusedBorder: getInputBorder,
        border: getInputBorder,
        hintText: hintText,
        hintStyle: const TextStyle(color: Color.fromARGB(255, 165, 165, 165)),
      ),
    );
  }
}
