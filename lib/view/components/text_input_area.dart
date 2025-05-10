import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator_app/viewmodel/translation_viewmodel.dart';
import 'package:translator_app/view/components/input_area.dart';

class TextInputArea extends StatelessWidget {
  const TextInputArea({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TranslationViewModel>(context);
    final mediaQuery = MediaQuery.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Paste Button
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  provider.pasteText(); // ✅ calls method from ViewModel
                },
                icon: const Icon(Icons.paste, color: Colors.white),
                label: const Text(
                  'Paste Text',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Text Input Field
          Container(
            height: mediaQuery.size.height * 0.1,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              onChanged: (text) => provider.setSourceText(text),
              maxLines: null,
              expands: true,
              decoration: const InputDecoration(
                hintText: 'Type your text here...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InputArea()),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Show Translated Text
          if (provider.translatedText.isNotEmpty) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                provider.translatedText,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Show Loading Indicator
          if (provider.isLoading) ...[
            const Center(child: CircularProgressIndicator()),
          ],
        ],
      ),
    );
  }
}
