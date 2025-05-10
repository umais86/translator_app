import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:firebase_core/firebase_core.dart'; // ✅ Add this
import 'package:translator_app/data/models/translation_provider.dart';
import 'package:translator_app/view/file_translate.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(); // ✅ Proper Firebase initialization

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TranslationProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Translator App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 55, 74, 215),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: FileTranslationScreen(),
    );
  }
}
