import 'package:flutter/material.dart';

class CalltoactionButton extends StatefulWidget {
  const CalltoactionButton(
      {super.key,
      this.color,
      required this.text,
      required this.height,
      required this.width,
      this.onTap});
  final double height;
  final double width;
  final Color? color;
  final String text;
  final Function()? onTap;

  @override
  State<CalltoactionButton> createState() => _CalltoactionButtonState();
}

class _CalltoactionButtonState extends State<CalltoactionButton> {
  bool taped = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          taped = !taped;
        });
        widget.onTap;
      },
      child: Container(
        height: widget.height,
        width: widget.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: widget.height - 30,
          width: widget.width - 30,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Colors.black.withOpacity(0.24),
                  offset: taped ? const Offset(0, 0) : const Offset(4, 8),
                ),
              ]),
          alignment: Alignment.center,
          child: Text(
            widget.text,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
