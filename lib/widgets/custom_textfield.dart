import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.inputFormatters,
  }) : super(key: key);
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Color.fromARGB(255, 124, 107, 107))),
      child: TextFormField(
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        validator: (value) {
          if (value?.isEmpty ?? false) {
            return "Lütfen bir değer girin";
          }
          return null;
        },
        controller: controller,
        decoration: InputDecoration(hintText: hintText),
      ),
    );
  }
}
