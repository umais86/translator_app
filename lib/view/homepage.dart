import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator_app/data/models/translation_provider.dart';
import 'package:translator_app/view/components/bottom_action_bar.dart';

import 'package:translator_app/view/components/language_selector.dart';
import 'package:translator_app/view/components/text_input_area.dart';
import 'package:translator_app/view/components/translation_button.dart';
import 'package:translator_app/viewmodel/translation_viewmodel.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    var translatinProvider = context.read<TranslationProvider>();
    context.read<TranslationViewModel>().setLanguages(
      translatinProvider.sourceLanguage,
      translatinProvider.targetLanguage,
    );
  }

  @override
  Widget build(BuildContext context) {
    TranslationViewModel translationProvider =
        context.watch<TranslationViewModel>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            // Text input area
            const TextInputArea(),
            Text(
              translationProvider.translatedText,
              style: TextStyle(overflow: TextOverflow.ellipsis),
              maxLines: 4,
            ),
            // Microphone button (centered)
            const SizedBox(height: 150),
            const MicrophoneButton(),
            const SizedBox(height: 15),

            // Language selector
            const LanguageSelector(),
            const SizedBox(height: 15),
            // Bottom navigation
            Align(
              alignment: Alignment.bottomCenter,
              child: const BottomActionBar1(),
            ),
          ],
        ),
      ),
    );
  }
}
