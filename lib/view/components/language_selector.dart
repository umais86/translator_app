import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator_app/data/models/translation_provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TranslationProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Source language selector
          Expanded(
            child: InkWell(
              onTap: () {
                _showLanguageSelector(context, true);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: AssetImage(
                        'assets/flags/${provider.sourceLanguage.flagAsset}.png',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      provider.sourceLanguage.name,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Swap button
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            onPressed: provider.swapLanguages,
          ),

          // Target language selector
          Expanded(
            child: InkWell(
              onTap: () {
                _showLanguageSelector(context, false);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: AssetImage(
                        'assets/flags/${provider.targetLanguage.flagAsset}.png',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      provider.targetLanguage.name,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageSelector(BuildContext context, bool isSource) {
    final provider = Provider.of<TranslationProvider>(context, listen: false);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select ${isSource ? "Source" : "Target"} Language',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 400,
                child: ListView.builder(
                  itemCount: provider.languages.length,
                  itemBuilder: (context, index) {
                    final language = provider.languages[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/flags/${language.flagAsset}.png',
                        ),
                      ),
                      title: Text(language.name),
                      onTap: () {
                        if (isSource) {
                          provider.setSourceLanguage(language);
                        } else {
                          provider.setTargetLanguage(language);
                        }
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
