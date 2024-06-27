import 'package:flutter/material.dart';
import 'package:nexara_cart/utility/app_color.dart';

class HorizontalList<T> extends StatelessWidget {
  final List<T>? items;
  final T selected;
  final String Function(T) itemToString;
  final void Function(T) onSelect;

  const HorizontalList(
      {super.key,
      this.items,
      required this.itemToString,
      required this.selected,
      required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: SizedBox(
        height: 50,
        child: ListView.builder(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          itemCount: items?.length ?? 0,
          itemBuilder: (context, index) {
            T item = items![index];
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: ChoiceChip(
                label: Text(itemToString(item)),
                selected: selected == item,
                onSelected: (bool selected) {
                  onSelect(item);
                },
                backgroundColor: Colors.blueGrey[50]!,
                selectedColor: AppColor.lightAccent,
                showCheckmark: false,
              ),
            );
          },
        ),
      ),
    );
  }
}
