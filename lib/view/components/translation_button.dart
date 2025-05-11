import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator_app/data/models/translation_provider.dart';
import 'package:translator_app/viewmodel/translation_viewmodel.dart';

class MicrophoneButton extends StatelessWidget {
  const MicrophoneButton({super.key});

  @override
  Widget build(BuildContext context) {
    final speechProvider = Provider.of<TranslationViewModel>(
      context,
      listen: false,
    );
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Listening...'),
            duration: Duration(seconds: 2),
          ),
        );
        var translatinProvider = context.read<TranslationProvider>();
        speechProvider.setLanguages(
          translatinProvider.sourceLanguage,
          translatinProvider.targetLanguage,
        );
        speechProvider.isListening
            ? speechProvider.stopListening()
            : speechProvider.startListening();
      },
      child: CircleAvatar(
        radius: 35,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.mic, color: Colors.white, size: 32),
      ),
    );
  }
}
