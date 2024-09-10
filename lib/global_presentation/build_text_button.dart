import 'package:alert_brains/global_presentation/build_text.dart';
import 'package:flutter/material.dart';

class BuildTextButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final Color color;

  const BuildTextButton(
      {super.key, required this.text, required this.onPressed, required this.color});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(50, 30),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: AlignmentDirectional.centerEnd,
      ),
      onPressed: onPressed,
      child: BuildText(
        text: text,
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}
