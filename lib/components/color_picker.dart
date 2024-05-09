import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ColorListPicker extends StatefulWidget {
  final List<Color> colors;
  final double itemSize;
  final double spacing;
  final Color selectedColor;
  final ValueChanged<Color?> onColorChanged;

  const ColorListPicker({
    super.key,
    required this.colors,
    required this.itemSize,
    this.spacing = 8.0,
    required this.selectedColor,
    required this.onColorChanged,
  });

  @override
  ColorListPickerState createState() => ColorListPickerState();
}

class ColorListPickerState extends State<ColorListPicker> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.colors.indexOf(widget.selectedColor);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: widget.colors.length,
      separatorBuilder: (context, index) => SizedBox(width: widget.spacing),
      itemBuilder: (context, index) {
        final color = widget.colors[index];
        final isSelected = selectedIndex == index;

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
              widget.onColorChanged(color);
              if (kDebugMode) {
                print(selectedIndex);
              }
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: widget.itemSize,
            height: widget.itemSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(color: const Color(0xFFEED59B), width: 5.0)
                  : null,
            ),
            child: Center(
              child: Container(
                width: widget.itemSize - 7,
                height: widget.itemSize - 7,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
