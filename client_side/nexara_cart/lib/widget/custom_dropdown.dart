import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? initialValue;
  final Color? bgColor;
  final List<T> items;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;
  final String hintText;
  final String Function(T) displayItem;

  const CustomDropdown({
    super.key,
    this.initialValue,
    required this.items,
    required this.onChanged,
    this.validator,
    this.hintText = 'Select an option',
    required this.displayItem,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<T>(
            isExpanded: true,
            hint: Text(
              hintText,
              style: TextStyle(
                color: Theme.of(context).hintColor,
              ),
            ),
            items: items.map((T value) {
              return DropdownMenuItem<T>(
                value: value,
                child: Container(
                  height: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        displayItem(value),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            value: initialValue,
            onChanged: onChanged,
            buttonStyleData: ButtonStyleData(
              padding: const EdgeInsets.only(left: 16, right: 12),
              height: 50,
              decoration: BoxDecoration(
                color: bgColor ?? Theme.of(context).colorScheme.surface,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 0,
            ),
            menuItemStyleData: const MenuItemStyleData(
              padding: EdgeInsets.zero,
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey[50],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
