import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator_app/data/models/translation_provider.dart';
import 'package:translator_app/view/components/language_selector.dart';

class TranslationScreen extends StatelessWidget {
  const TranslationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TranslationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Translate"),
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            onPressed: () => provider.swapLanguages(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const LanguageSelector(),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(provider.sourceLanguage.name),
                const SizedBox(width: 8),
                IconButton(icon: const Icon(Icons.volume_up), onPressed: () {}),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                hintText: "Enter Text",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {},
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.paste),
                  label: const Text("Paste Text"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[200],
                    foregroundColor: Colors.white,
                  ),
                ),
                const Spacer(),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    icon: const Icon(Icons.mic, color: Colors.white),
                    onPressed: () {
                      // TODO: Implement voice input
                    },
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/flags/${provider.sourceLanguage.flagAsset}.png',
                    height: 20,
                  ),
                  const SizedBox(width: 6),
                  Text(provider.sourceLanguage.name),
                  const SizedBox(width: 10),
                  const Icon(Icons.compare_arrows),
                  const SizedBox(width: 10),
                  Image.asset(
                    'assets/flags/${provider.targetLanguage.flagAsset}.png',
                    height: 20,
                  ),
                  const SizedBox(width: 6),
                  Text(provider.targetLanguage.name),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
