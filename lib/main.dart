import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator_app/data/models/conversation_provider.dart';
import 'package:translator_app/data/models/filetranslation_provider.dart';
import 'package:translator_app/data/models/speech.dart';
// import 'package:firebase_core/firebase_core.dart'; // ✅ Add this
import 'package:translator_app/data/models/translation_provider.dart';
import 'package:translator_app/data/models/translation_repository.dart';
import 'package:translator_app/view/components/privacy_policy_screen.dart';
import 'package:translator_app/view/homepage.dart';
import 'package:translator_app/view/splash_screen.dart';

import 'package:translator_app/viewmodel/translation_viewmodel.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(); // ✅ Proper Firebase initialization

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<FileTranslationProvider>(
          create: (context) => FileTranslationProvider(),
        ),
        ChangeNotifierProvider(create: (_) => TranslationProvider()),
        ChangeNotifierProvider(
          create:
              (context) => SpeechProvider(
                translationProvider: context.read<TranslationProvider>(),
              ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TranslationViewModel>(
          create: (context) => TranslationViewModel(TranslationRepository()),
        ),
        ChangeNotifierProvider<ConversationProvider>(
          create: (_) => ConversationProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Translator App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 55, 74, 215),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
