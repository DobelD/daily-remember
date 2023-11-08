import 'package:flutter/material.dart';

class ClipWithEditButton extends StatelessWidget {
  final String word;
  final VoidCallback onEditPressed;

  const ClipWithEditButton(
      {super.key, required this.word, required this.onEditPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            color: Colors.blueAccent,
            padding: const EdgeInsets.all(5),
            child: Text(
              word,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 5),
        InkWell(
          onTap: onEditPressed,
          child: const Icon(Icons.edit, color: Colors.blueAccent),
        ),
      ],
    );
  }
}
