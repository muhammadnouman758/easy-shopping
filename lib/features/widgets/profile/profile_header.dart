import 'package:flutter/material.dart';

import '../../profile/user_model.dart';

class ProfileHeader extends StatelessWidget {
  final User user;
  final VoidCallback onEditPressed;

  const ProfileHeader({
    Key? key,
    required this.user,
    required this.onEditPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(user.imageUrl ?? 'assets/images/default_profile.png'),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: IconButton(
                icon: const Icon(Icons.edit, color: Colors.white, size: 20),
                onPressed: onEditPressed,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          user.name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          user.email,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 16,
          ),
        ),
        if (user.phone != null) ...[
          const SizedBox(height: 4),
          Text(
            user.phone!,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
        ],
      ],
    );
  }
}