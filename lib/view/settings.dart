import 'package:flutter/material.dart';
import 'package:translator_app/view/components/language_selector.dart';
import 'package:translator_app/view/components/privacy_policy_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          _buildTile(
            context,
            icon: Icons.language,
            title: 'App Language',
            subtitle: 'English',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LanguageSelector(),
                ),
              );
            },
          ),
          _buildTile(
            context,
            icon: Icons.star_border,
            title: 'Rate Us',
            subtitle: 'Share your experience',
            onTap: () {
              // Navigate to rate us screen
            },
          ),
          _buildTile(
            context,
            icon: Icons.feedback_outlined,
            title: 'Feedback',
            subtitle: 'Add your suggestions',
            onTap: () {
              // Navigate to feedback screen
            },
          ),
          _buildTile(
            context,
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            subtitle: 'Learn Privacy Policy',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicyScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.layers_outlined),
            title: const Text('Version'),
            subtitle: const Text('1.0.0'),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
