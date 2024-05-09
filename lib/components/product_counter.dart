import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCounter extends StatefulWidget {
  const ProductCounter(
      {super.key,
      required this.size,
      this.qttboxcolor,
      this.actionscolor,
      required this.onQuantityChanged});
  final ValueChanged<int> onQuantityChanged;
  final double size;
  final Color? qttboxcolor;
  final Color? actionscolor;

  @override
  State<ProductCounter> createState() => _ProductCounterState();
}

class _ProductCounterState extends State<ProductCounter> {
  int qtt = 1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            child: Container(
              height: widget.size * 0.8,
              width: widget.size * 0.8,
              decoration: BoxDecoration(
                color: widget.qttboxcolor,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(9, 140, 210, 0.25),
                    offset: Offset(0, 8), //(x,y)
                    blurRadius: 16,
                    spreadRadius: 3,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                qtt.toString(),
                style: TextStyle(
                    fontSize: widget.size * 0.3, fontWeight: FontWeight.w900),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                setState(() {
                  qtt = qtt + 1;
                  widget.onQuantityChanged(qtt);
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: widget.size * 0.4,
                width: widget.size * 0.4,
                decoration: BoxDecoration(
                  color: widget.actionscolor,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(9, 140, 210, 0.25),
                      offset: Offset(0, 8), //(x,y)
                      blurRadius: 16,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: Icon(CupertinoIcons.add, size: widget.size * 0.2),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: InkWell(
              onTap: () {
                setState(() {
                  if (qtt > 1) {
                    qtt = qtt - 1;
                    widget.onQuantityChanged(qtt);
                  }
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: widget.size * 0.4,
                width: widget.size * 0.4,
                decoration: BoxDecoration(
                  color: widget.actionscolor,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(9, 140, 210, 0.25),
                      offset: Offset(0, 8), //(x,y)
                      blurRadius: 16,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: Icon(
                  CupertinoIcons.minus,
                  size: widget.size * 0.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
