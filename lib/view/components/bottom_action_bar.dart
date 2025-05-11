import 'package:flutter/material.dart';
import 'package:translator_app/view/camera.dart';
import 'package:translator_app/view/conversation.dart';
import 'package:translator_app/view/more_fun.dart';

class BottomActionBar1 extends StatelessWidget {
  const BottomActionBar1({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionButton(
          context,
          icon: Icons.group,
          label: 'Conversation',
          isActive: false,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ConversationScreen(),
              ),
            );
          },
        ),
        _buildActionButton(
          context,
          icon: Icons.camera_alt,
          label: 'Camera',
          isActive: false,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Camera()),
            );
          },
        ),
        _buildActionButton(
          context,
          icon: Icons.apps,
          label: 'More Fun',
          isActive: true,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MoreFunScreen()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isActive ? Colors.blue : Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.white : Colors.grey[600],
              size: 30,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.blue : Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
