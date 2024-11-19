import 'package:flutter/material.dart';

Widget MyField({
  required TextEditingController controller,
  required String label,
  ValueChanged<String>? onChanged,
  IconData? icon
}) {
  return TextField(
    onChanged: onChanged,
    controller: controller,
    decoration: InputDecoration(
      prefixIcon: Icon(icon),
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.black,
          width: 1.5,
        ),
      ),
    ),
  );
}
