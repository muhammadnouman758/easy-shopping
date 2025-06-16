import 'package:flutter/material.dart';

import '../../core/contants/app_color.dart';


class SocialLoginButtons extends StatelessWidget {
  final VoidCallback onGooglePressed;
  final VoidCallback onFacebookPressed;

  const SocialLoginButtons({
    Key? key,
    required this.onGooglePressed,
    required this.onFacebookPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onGooglePressed,
          icon: const Icon(Icons.fmd_good, color: AppColors.primary),
          iconSize: 40,
        ),
        const SizedBox(width: 20),
        IconButton(
          onPressed: onFacebookPressed,
          icon: const Icon(Icons.facebook, color: AppColors.primary),
          iconSize: 40,
        ),
      ],
    );
  }
}