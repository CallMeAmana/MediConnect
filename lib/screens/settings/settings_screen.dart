import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mediconnect/providers/settings_provider.dart';
import 'package:mediconnect/utils/theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
            elevation: 0,
          ),
          body: ListView(
            children: [
              const SizedBox(height: 16),
              _buildSection(
                context,
                title: 'Appearance',
                children: [
                  _buildSwitchTile(
                    context,
                    title: 'Dark Mode',
                    value: settings.isDarkMode,
                    onChanged: (value) => settings.toggleTheme(),
                    icon: Icons.dark_mode,
                  ),
                ],
              ),
              _buildSection(
                context,
                title: 'Language',
                children: [
                  _buildLanguageOption(
                    context,
                    title: 'English',
                    languageCode: 'en',
                    currentLanguage: settings.language,
                    onSelect: () => settings.setLanguage('en'),
                  ),
                  _buildLanguageOption(
                    context,
                    title: 'العربية',
                    languageCode: 'ar',
                    currentLanguage: settings.language,
                    onSelect: () => settings.setLanguage('ar'),
                  ),
                  _buildLanguageOption(
                    context,
                    title: 'Français',
                    languageCode: 'fr',
                    currentLanguage: settings.language,
                    onSelect: () => settings.setLanguage('fr'),
                  ),
                ],
              ),
              _buildSection(
                context,
                title: 'Notifications',
                children: [
                  _buildSwitchTile(
                    context,
                    title: 'Enable Notifications',
                    value: settings.notificationsEnabled,
                    onChanged: (value) => settings.toggleNotifications(),
                    icon: Icons.notifications,
                  ),
                ],
              ),
            ].animate(interval: 100.ms).fade().slideX(),
          ),
        );
      },
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
        const Divider(height: 32),
      ],
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required String title,
    required bool value,
    required Function(bool) onChanged,
    required IconData icon,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context, {
    required String title,
    required String languageCode,
    required String currentLanguage,
    required VoidCallback onSelect,
  }) {
    final isSelected = languageCode == currentLanguage;
    return ListTile(
      leading: const Icon(Icons.language),
      title: Text(title),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: Theme.of(context).colorScheme.primary,
            )
          : null,
      onTap: onSelect,
      selected: isSelected,
    );
  }
}