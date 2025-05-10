import 'package:flutter/material.dart';

import 'package:translator_app/view/components/bottom_nav.dart';
import 'package:translator_app/view/components/language_selector.dart';
import 'package:translator_app/view/components/text_input_area.dart';
import 'package:translator_app/view/components/translation_button.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Language Translator',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        titleSpacing: 0.4,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Text input area
            const TextInputArea(),

            // Microphone button (centered)
            const SizedBox(height: 330),
            const MicrophoneButton(),
            const SizedBox(height: 15),

            // Language selector
            const LanguageSelector(),
            const Spacer(),
            // Bottom navigation
            const BottomNav(),
          ],
        ),
      ),
    );
  }
}
