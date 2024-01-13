import 'package:flutter/material.dart';

class CustomGridList extends StatelessWidget {
  final double runSpacing = 16;
  final double spacing = 16;
  final int listSize;
  final columns = 3;
  final List<Widget> children;
  final Size keyboardSize;

  const CustomGridList(
      {Key? key, required this.children, required this.keyboardSize})
      : listSize = children.length,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final primarySize = keyboardSize.width > keyboardSize.height
        ? keyboardSize.height
        : keyboardSize.width;
    final itemSize = (primarySize - runSpacing * (columns - 1)) / columns;
    return Wrap(
      runSpacing: runSpacing,
      spacing: spacing,
      alignment: WrapAlignment.end,
      children: children
          .map((item) => SizedBox(
                width: itemSize,
                height: itemSize,
                child: item,
              ))
          .toList(growable: false),
    );
  }
}
