import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator_app/data/models/filetranslation_provider.dart';
import 'package:translator_app/data/models/translation_provider.dart';
import 'package:translator_app/view/components/language_selector.dart';

class FileTranslationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FileTranslationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'File Translator',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          const Text(
            '''Select a File
             to Translate''',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Center(
            child: SizedBox(
              height: 400,
              width: 400,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    ElevatedButton.icon(
                      onPressed:
                          provider.isLoading ? null : provider.selectFile,
                      icon: const Icon(Icons.upload_file),
                      label: const Text('Select File'),
                    ),
                    if (provider.selectedFileName != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Selected File: ${provider.selectedFileName!}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Expanded(child: LanguageSelector())],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        var languageProvider =
                            context.read<TranslationProvider>();
                        provider.changeFromLanguage(
                          languageProvider.sourceLanguage.code,
                        );
                        provider.changeToLanguage(
                          languageProvider.targetLanguage.code,
                        );
                        provider.translateFile();
                      },
                      icon: const Icon(Icons.translate),
                      label: const Text('Translate'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (provider.isLoading) const CircularProgressIndicator(),
                    if (provider.errorMessage != null)
                      Text(
                        provider.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    if (provider.translatedContent != null)
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SingleChildScrollView(
                            child: Text(
                              provider.translatedContent!,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
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
}
