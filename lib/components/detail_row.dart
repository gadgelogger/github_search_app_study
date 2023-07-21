import 'package:flutter/material.dart';

class DetailRow extends StatelessWidget {
  const DetailRow({Key? key, required this.iconData, required this.text})
      : super(key: key);

  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData),
        const SizedBox(width: 8.0),
        Text(text),
      ],
    );
  }
}
