import 'package:flutter/material.dart';

class TextTitle extends StatelessWidget {
  const TextTitle(
      {Key? key, required this.title, this.style, this.titleShadows})
      : super(key: key);

  final String title;
  final TextStyle? style;
  final List<Shadow>? titleShadows;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: style ??
          TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.w500,
              shadows: titleShadows ??
                  [const Shadow(color: Colors.indigo, offset: Offset(1, 1))]),
    );
  }
}
