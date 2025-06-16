import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tera/features/profile/profile_view_model.dart';

import '../widgets/profile/setting_switch.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileViewModel = Provider.of<ProfileViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Column(
                children: [
                  SettingSwitch(
                    title: 'Dark Mode',
                    value: profileViewModel.darkMode,
                    onChanged: profileViewModel.toggleDarkMode,
                  ),
                  const Divider(height: 1),
                  SettingSwitch(
                    title: 'Notifications',
                    value: profileViewModel.notificationsEnabled,
                    onChanged: profileViewModel.toggleNotifications,
                  ),
                  const Divider(height: 1),
                  SettingSwitch(
                    title: 'Biometric Authentication',
                    description: 'Use fingerprint or face ID to login',
                    value: profileViewModel.biometricAuth,
                    onChanged: profileViewModel.toggleBiometricAuth,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Change Password'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // Navigate to change password screen
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Language'),
                    trailing: const Text('English', style: TextStyle(color: Colors.grey)),
                    onTap: () {
                      // Navigate to language selection
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Currency'),
                    trailing: const Text('USD', style: TextStyle(color: Colors.grey)),
                    onTap: () {
                      // Navigate to currency selection
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Privacy Policy'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // Navigate to privacy policy
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Terms of Service'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // Navigate to terms of service
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}