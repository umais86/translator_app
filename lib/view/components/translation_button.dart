import 'package:flutter/material.dart';

class MicrophoneButton extends StatelessWidget {
  const MicrophoneButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: IconButton(
        icon: const Icon(Icons.mic, color: Colors.white, size: 32),
        onPressed: () {
          // Would implement speech-to-text functionality
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Voice recognition activated')),
          );
        },
      ),
    );
  }
}
