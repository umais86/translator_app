import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator_app/data/models/conversation_provider.dart';
import 'package:translator_app/view/components/language_selector.dart';

class ConversationScreen extends StatelessWidget {
  const ConversationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ConversationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conversation"),
        centerTitle: true,
        leading: BackButton(),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: provider.messages.length,
              itemBuilder: (context, index) {
                final msg = provider.messages.reversed.toList()[index];
                final isFromSource = msg.fromLang == provider.fromLang;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color:
                        isFromSource ? Colors.red.shade50 : Colors.blue.shade50,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   DateFormat(
                        //     "dd MMM yyyy, hh:mm a",
                        //   ).format(msg.timestamp),
                        //   style: TextStyle(color: Colors.grey),
                        // ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(msg.fromLang == "en" ? "English" : "Arabic"),
                            IconButton(
                              icon: Icon(Icons.volume_up),
                              onPressed:
                                  () => provider.speak(msg.text, msg.fromLang),
                            ),
                          ],
                        ),
                        Text(msg.text),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(msg.toLang == "en" ? "English" : "Arabic"),
                            IconButton(
                              icon: Icon(Icons.volume_up),
                              onPressed:
                                  () => provider.speak(
                                    msg.translatedText,
                                    msg.toLang,
                                  ),
                            ),
                          ],
                        ),
                        Text(
                          msg.translatedText,
                          textDirection: TextDirection.ltr,
                        ),
                        Text(
                          msg.translatedText,
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          _MicrophoneInputArea(),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: LanguageSelector(
              swapClick: () {
                provider.swapLanguages();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MicrophoneInputArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ConversationProvider>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _MicButton(
              color: Colors.red,
              lang: provider.fromLang,
              onTap: () async {
                await provider.startListening();
                await provider.stopListening();
                await provider.translateAndAdd();
              },
            ),
            const SizedBox(width: 100),
            _MicButton(
              color: Colors.blue,
              lang: provider.toLang,
              onTap: () {
                // provider.swapLanguages();
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        // ElevatedButton(
        //   onPressed: () async {
        //     await provider.stopListening();
        //     await provider.translateAndAdd();
        //   },
        //   child: Text("Translate"),
        // ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _MicButton extends StatelessWidget {
  final Color color;
  final String lang;
  final VoidCallback onTap;

  const _MicButton({
    required this.color,
    required this.lang,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(Icons.mic, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
