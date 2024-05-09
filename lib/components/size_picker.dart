import 'package:flutter/material.dart';

class SizeListPicker extends StatefulWidget {
  final List<String> sizes;
  final double itemSize;
  final double spacing;
  final String selectedSize;
  final ValueChanged<String?> onSizeChanged;

  const SizeListPicker({
    super.key,
    required this.sizes,
    required this.itemSize,
    this.spacing = 0.0,
    required this.selectedSize,
    required this.onSizeChanged,
  });

  @override
  SizeListPickerState createState() => SizeListPickerState();
}

class SizeListPickerState extends State<SizeListPicker> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.sizes.indexOf(widget.selectedSize);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: widget.sizes.length,
      separatorBuilder: (context, index) => SizedBox(width: widget.spacing),
      itemBuilder: (context, index) {
        final size = widget.sizes[index];
        final isSelected = selectedIndex == index;

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
              widget.onSizeChanged(size);
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: widget.itemSize * 2 - 2,
            height: widget.itemSize - 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              shape: BoxShape.rectangle,
              border: isSelected
                  ? Border.all(color: const Color(0xFFEED59B), width: 5)
                  : null,
            ),
            child: Center(
              child: Container(
                width: widget.itemSize * 2 - 4,
                height: widget.itemSize - 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  color: Colors.grey.shade400,
                  shape: BoxShape.rectangle,
                ),
                child: Center(
                    child: Text(
                  size,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                )),
              ),
            ),
          ),
        );
      },
    );
  }
}
