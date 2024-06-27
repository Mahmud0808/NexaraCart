import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CouponTextField extends StatelessWidget {
  final String labelText;
  final double? height;
  final TextEditingController controller;
  final TextInputType? inputType;
  final int? lineNumber;
  final void Function(String?) onSave;
  final String? Function(String?)? validator;

  const CouponTextField({
    super.key,
    required this.labelText,
    required this.onSave,
    this.inputType = TextInputType.text,
    this.lineNumber = 1,
    this.validator,
    required this.controller,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
        child: TextFormField(
          controller: controller,
          maxLines: lineNumber,
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          ),
          keyboardType: inputType,
          onSaved: (value) {
            onSave(value?.isEmpty ?? true ? null : value);
          },
          validator: validator,
          inputFormatters: [
            LengthLimitingTextInputFormatter(700),
            if (inputType == TextInputType.number)
              FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
          ],
        ),
      ),
    );
  }
}
