import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? initialValue;
  final List<T> items;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;
  final String hintText;
  final String Function(T) displayItem;

  const CustomDropdown({
    Key? key,
    this.initialValue,
    required this.items,
    required this.onChanged,
    this.validator,
    this.hintText = 'Select an option',
    required this.displayItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<T>(
        decoration: InputDecoration(
          labelText: hintText,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        value: initialValue,
        items: items.map((T value) {
          return DropdownMenuItem<T>(
            value: value,
            child: Text(displayItem(value)), // Use displayItem to get the text
          );
        }).toList(),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
