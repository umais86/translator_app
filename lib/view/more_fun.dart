import 'package:flutter/material.dart';
import 'package:translator_app/view/dictionary.dart';
import 'package:translator_app/view/file_translate.dart';

import 'settings.dart';

class MoreFunScreen extends StatelessWidget {
  const MoreFunScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('More Fun'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to Settings screen or perform action
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Settings()),
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildButton(
            context,
            color: Colors.lightBlue[100]!,
            title: 'File translate',
            subtitle: 'Ask anything from AI experts',
            onTap: () {
              // Navigate to File Translate screen or perform action
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FileTranslationScreen(),
                ),
              );
            },
          ),
          SizedBox(height: 12),
          _buildButton(
            context,
            color: Colors.lightGreen[100]!,
            title: 'Dictionary',
            subtitle: 'Ask anything from AI experts',
            onTap: () {
              // Navigate to Dictionary screen or perform action
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DictionaryScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.98,
          height: 100,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(
                  title == 'File translate' ? Icons.description : Icons.book,
                  size: 40,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
