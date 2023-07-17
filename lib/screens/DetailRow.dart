import 'package:flutter/material.dart';

class DetailRow extends StatelessWidget {
  final IconData iconData;
  final String text;

  DetailRow({required this.iconData, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData),
        const SizedBox(width: 8.0),
        Text(text),
        const Text('watchers', style: TextStyle(fontWeight: FontWeight.w200)),
      ],
    );
  }
}
