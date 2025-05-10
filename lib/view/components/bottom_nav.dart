import 'package:flutter/material.dart';
import 'package:translator_app/view/components/language_selector.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [const LanguageSelector()]));
  }
}
