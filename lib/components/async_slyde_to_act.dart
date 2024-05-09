import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pwear_store2/constants.dart';
import 'package:slide_action/slide_action.dart';

class AsyncExample extends StatelessWidget {
  const AsyncExample({
    this.callback,
    Key? key,
  }) : super(key: key);

  final FutureOr<void> Function()? callback;

  @override
  Widget build(BuildContext context) {
    return SlideAction(
      stretchThumb: true,
      trackBuilder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
              ),
            ],
          ),
          child: const Center(
            child: Text(
              "Slide to confirm Order",
            ),
          ),
        );
      },
      thumbBuilder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color:
                state.isPerformingAction ? Colors.blue.shade200 : kPrimaryColor,
            borderRadius: BorderRadius.circular(100),
          ),
          child: state.isPerformingAction
              ? const CupertinoActivityIndicator(
                  color: Colors.white,
                )
              : const Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
        );
      },
      action: callback,
    );
  }
}
