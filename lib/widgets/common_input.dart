import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  const CustomTextField(
      {super.key, required this.title, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: title),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'All fields are required';
          }
          return null;
        },
      ),
    );
  }
}
